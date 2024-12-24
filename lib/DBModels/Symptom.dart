import 'package:slider/DBModels/Question%20.dart';

class Symptom {
  final int id;
  final String name;
  final String description;
  final int? diagnosisId; // يمكن أن يكون null أو int
  final List<Question> questions;

  Symptom({
    required this.id,
    required this.name,
    required this.description,
    this.diagnosisId, // يمكن أن تكون null
    this.questions = const [],
  });

  // منشئ مصنع لإنشاء كائن Symptom من JSON
  factory Symptom.fromJson(Map<String, dynamic> json) {
    return Symptom(
      id: json['Id'],
      name: json['Name'],
      description: json['Description'] ?? "",
      diagnosisId: json['DiagnosisId'], // يمكن أن تكون null
      questions: json['Questions'] != null
          ? (json['Questions'] as List)
              .map((item) => Question.fromJson(item))
              .toList()
          : [],
    );
  }

  // دالة لتحويل كائن Symptom إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Description': description,
      'DiagnosisId': diagnosisId, // قد تكون null هنا
      'Questions': questions.map((e) => e.toJson()).toList(),
    };
  }
}
