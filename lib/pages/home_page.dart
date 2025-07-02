import 'dart:async';

import 'package:app_diario/pages/editar_registro.dart';
import 'package:app_diario/pages/registro_humor.dart';
import 'package:flutter/material.dart';
import '../core/dao_registro.dart';
import '../models/registro_model.dart';
import '../widgets/registro_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<registroModel> entries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final registros = await RegistroDao().listarRegistros();
    setState(() {
      entries.clear();
      entries.addAll(registros.reversed);
    });
  }

  Future<void> _navigateToAddEntry() async {
    final newEntry = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => registroHumor()),
    );

    if (newEntry != null && newEntry is registroModel) {
      await _loadEntries();
    }
  }

  Future<void> _editarExcluir(registroModel registro, int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarRegistroPage(registroOriginal: registro),
      ),
    );

    if (result is Map && result['delete'] == true) {
      await RegistroDao().deletarRegistro(registro.data);
      await _loadEntries();
    } else if (result is registroModel) {
      await RegistroDao().atualizarRegistro(result);
      await _loadEntries();
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
                        onDoubleTap: () => _editarExcluir(entry, index),
                        child: RegistroCard(
                          data: '${entry.data.day.toString().padLeft(2, '0')}/${entry.data.month.toString().padLeft(
                              2, '0')}',
                          humor: 'Nota ${entry.humor}',
                          descricao: entry.descricao,
                          imagePath: entry.imagePath,
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

