import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdicionarImagemWidget extends StatefulWidget {
  final void Function(File? image) onImageSelected;
  const AdicionarImagemWidget({super.key, required this.onImageSelected});


  @override
  State<AdicionarImagemWidget> createState() => _AdicionarImagemWidgetState();
}

class _AdicionarImagemWidgetState extends State<AdicionarImagemWidget> {
  File? _imagePicked;

  Future<void> _selecionarImagem(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 85);

    if (pickedFile != null) {
      setState(() {
        _imagePicked = File(pickedFile.path);
      });
      widget.onImageSelected(_imagePicked);
    }
  }

  void _mostrarOpcoes() {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Tirar foto"),
              onTap: () {
                Navigator.pop(context);
                _selecionarImagem(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Escolher da galeria"),
              onTap: () {
                Navigator.pop(context);
                _selecionarImagem(ImageSource.gallery);
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: _mostrarOpcoes,
          icon: const Icon(Icons.image),
          label: const Text("Adicionar imagem"),
        ),
        const SizedBox(height: 12),
        if (_imagePicked != null)
          Image.file(
            _imagePicked!,
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
      ],
    );
  }
}
