import 'package:flutter/material.dart';
import '../models/registro_model.dart';

class registroHumor extends StatefulWidget {
  const registroHumor({super.key});

  @override
  State<registroHumor> createState() => _registroHumorState();
}

class _registroHumorState extends State<registroHumor> {
  final TextEditingController _controller = TextEditingController();
  int selectedHumor = 5;

  void _saveEntry() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final newEntry = registroModel(
      descricao: text,
      humor: selectedHumor,
      data: DateTime.now(),
    );
    print('Salvando registro: ${newEntry.descricao}, humor ${newEntry.humor}');
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
            const SizedBox(height: 360),
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
