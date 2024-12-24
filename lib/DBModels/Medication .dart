import 'package:slider/DBModels/Diagnosis%20.dart';

class Medication {
  final int id;
  final String name;
  final String description;
  final String? dosage;
  final int? diagnosisId;
  dynamic diagnosis; // يمكن أن يكون Diagnosis أو أي شيء آخر

  // Constructor to initialize the fields
  Medication({
    required this.id,
    required this.name,
    required this.description,
    this.dosage,
    this.diagnosisId,
    this.diagnosis, // ملاحظة: الآن يمكن أن يكون diagnosis من نوع dynamic
  });

  // Convert a JSON object to a Medication object
  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      dosage: json['dosage'],
      diagnosisId: json['diagnosisId'],
      diagnosis: json['diagnosis'] != null
          ? Diagnosis.fromJson(
              json['diagnosis']) // تحويل diagnosis إذا كانت موجودة
          : null, // إذا لم تكن موجودة، يمكن أن تكون null
    );
  }

  // Convert a Medication object to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'dosage': dosage,
      'diagnosisId': diagnosisId,
      'diagnosis': diagnosis != null
          ? diagnosis.toJson()
          : null, // إذا كانت diagnosis غير null، تحويلها إلى JSON
    };
  }
}
