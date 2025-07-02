import 'dart:io';
import 'package:app_diario/core/dao_registro.dart';
import 'package:flutter/material.dart';
import '../models/registro_model.dart';
import '../service/adicionar_imagem.dart';

class registroHumor extends StatefulWidget {
  const registroHumor({super.key});

  @override
  State<registroHumor> createState() => _registroHumorState();
}

class _registroHumorState extends State<registroHumor> {
  final TextEditingController _controller = TextEditingController();
  int selectedHumor = 5;
  File? _imageFile;

  void _saveEntry() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final newEntry = registroModel(
      descricao: text,
      humor: selectedHumor,
      data: DateTime.now(),
      imagePath: _imageFile?.path,
    );

    await RegistroDao().inserirRegistro(newEntry);

    print('Salvando registro: ${newEntry.descricao}, humor ${newEntry.humor}, imagem ${newEntry.imagePath}');
    Navigator.pop(context, newEntry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Como você está se sentindo hoje?'),
            const SizedBox(height: 40),
            Wrap(
              spacing: 10,
              children: List.generate(10, (index) => index + 1).map((i) {
                return ChoiceChip(
                  label: Text('$i'),
                  selected: selectedHumor == i,
                  onSelected: (_) => setState(() => selectedHumor = i),
                );
              }).toList(),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Descreva seu dia',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 100),
            AdicionarImagemWidget(
              onImageSelected: (File? image) {
                _imageFile= image;
              },
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: _saveEntry,
                child: const Text('Salvar'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
