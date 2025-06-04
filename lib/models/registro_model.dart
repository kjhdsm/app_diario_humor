class registroModel {
  final String descricao;
  final int humor;
  final DateTime data;
  registroModel({
    required this.descricao,
    required this.humor,
    required this.data }
  );
  Map<String, dynamic> toMap() {
    return {'text': descricao, 'mood': humor, 'date': data.toIso8601String()};
  }
  factory registroModel.fromMap(Map<String, dynamic> map) {
    return registroModel(
      descricao: map['text'],
      humor: map['mood'],
      data: DateTime.parse(map['date']),
    );
  }
}
