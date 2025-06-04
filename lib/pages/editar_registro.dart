import 'package:flutter/material.dart';
import '../models/registro_model.dart';

class EditarRegistroPage extends StatefulWidget {
  final registroModel registroOriginal;

const EditarRegistroPage({super.key, required this.registroOriginal});

  @override
  State<EditarRegistroPage> createState() => _EditarRegistroPageState();
}

class _EditarRegistroPageState extends State<EditarRegistroPage>{
  late TextEditingController _controller;
  late int selectedHumor;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.registroOriginal.descricao);
    selectedHumor = widget.registroOriginal.humor;
  }

  void _deleteRegistro() {
    Navigator.pop(context, {'delete': true});
  }

  void _saveChanges() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final updatedRegistro = registroModel(
        descricao: text,
        humor: selectedHumor,
        data: widget.registroOriginal.data,
    );
    Navigator.pop(context, updatedRegistro);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar registro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Como você está se sentindo?'),
            const SizedBox(height: 12),
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
          const SizedBox(height: 32),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Descreva seu dia',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: _deleteRegistro,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  child: const Text('Excluir'),
              ),
              ElevatedButton(
                onPressed: _saveChanges,
                child: const Text('Salvar edição'),
              ),
            ],
          ),
          ],
        ),
      ),
    );
  }
}