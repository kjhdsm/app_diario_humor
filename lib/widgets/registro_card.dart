import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistroCard extends StatelessWidget {
  final String data;
  final String humor;
  final String descricao;
  final String? imagePath;

  const RegistroCard({
    super.key,
    required this.data,
    required this.humor,
    required this.descricao,
    this.imagePath
  });

  @override
  Widget build(BuildContext context) {
    print('Exibindo imagem: $imagePath');
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
            // Imagem ao lado esquerdo
            if (imagePath != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(imagePath!),
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              )
            else
              const SizedBox(
                width: 80,
                height: 80,
                child: Icon(Icons.image, size: 40, color: Colors.grey),
              ),

            const SizedBox(width: 16),

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