class registroModel {
  final String descricao;
  final int humor;
  final DateTime data;
  final String? imagePath;

  registroModel({
    required this.descricao,
    required this.humor,
    required this.data,
    this.imagePath
  });

  Map<String, dynamic> toMap() {
    return {'text': descricao,
      'mood': humor,
      'date': data.toIso8601String(),
      'image': imagePath
    };
  }

  factory registroModel.fromMap(Map<String, dynamic> map) {
    return registroModel(
      descricao: map['text'],
      humor: map['mood'],
      data: DateTime.parse(map['date']),
      imagePath: map['imagePath'],
    );
  }
}
