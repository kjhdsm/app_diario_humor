import 'package:app_diario/pages/editar_registro.dart';
import 'package:app_diario/pages/registro_humor.dart';
import 'package:flutter/material.dart';
import '../models/registro_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<registroModel> entries = [];

  void _navigateToAddEntry() async {
    final newEntry = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => registroHumor()),
    );

    if (newEntry != null && newEntry is registroModel) {
      setState(() {
        entries.insert(0, newEntry);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      body: SafeArea(
          child: Column(
            children: [
              Container(
                color: Colors.black,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: const Center(
                  child: Text(
                      'Junho 2025',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                  ),
                )
              ),
              const SizedBox(height: 20),
              const Text(
                  'Como foi seu dia?\nFaça um registro!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
              ),
              const SizedBox(height: 29),
              FloatingActionButton(
                  onPressed: _navigateToAddEntry,
                  child: const Icon(Icons.add),
              ),
              const SizedBox(height: 20),
              Expanded(
                  child: entries.isEmpty ?
                      const Center(
                        child: Text(
                          'Não há registros de humor',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                  : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: entries.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final entry = entries[index];
                      return GestureDetector(
                        onDoubleTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditarRegistroPage(registroOriginal: entry),
                            ),
                          );

                          if (result is Map && result['delete'] == true) {
                            setState(() {
                              entries.removeAt(index);
                            });
                          } else if (result is registroModel) {
                            setState(() {
                              entries[index] = result;
                            });
                          }
                        },
                        child: RegistroCard(
                          data: '${entry.data.day.toString().padLeft(2, '0')}/${entry.data.month.toString().padLeft(2, '0')}',
                          humor: 'Nota ${entry.humor}',
                          descricao: entry.descricao,
                        ),
                      );
                    },
                  )
              )
            ],
          )
      ),
    );
  }
}

class RegistroCard extends StatelessWidget {
  final String data;
  final String humor;
  final String descricao;

  const RegistroCard({
    super.key,
    required this.data,
    required this.humor,
    required this.descricao
});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    descricao,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    humor,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}