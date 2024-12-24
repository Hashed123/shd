import 'package:slider/DBModels/Diagnosis%20.dart';
import 'package:slider/DBModels/PatientRecord%20.dart';

class Patient {
  final int id;
  final String name;
  final int age;
  final String medicalHistory;
  final String gender;
  final String email;
  final String password;
  dynamic diagnoses;
  dynamic records; // إضافة السجلات (PatientRecords)

  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.medicalHistory,
    required this.gender,
    required this.email,
    required this.password,
    this.diagnoses,
    this.records, // إضافة السجلات في المُنشئ
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['Id'],
      name: json['Name'],
      age: json['Age'],
      medicalHistory: json['MedicalHistory'],
      gender: json['Gender'],
      email: json['Email'],
      password: json['Password'],
      diagnoses: json['Diagnoses'] != null
          ? (json['Diagnoses'] as List)
              .map((item) => Diagnosis.fromJson(item))
              .toList()
          : null,
      records: json['Records'] != null
          ? (json['Records'] as List)
              .map((item) => PatientRecord.fromJson(item))
              .toList() // تحويل السجلات إلى كائنات PatientRecord
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Age': age,
      'MedicalHistory': medicalHistory,
      'Gender': gender,
      'Email': email,
      'Password': password,
      'Diagnoses': diagnoses != null
          ? (diagnoses as List).map((e) => e.toJson()).toList()
          : null,
      'Records': records != null
          ? (records as List)
              .map((e) => e.toJson())
              .toList() // تحويل السجلات إلى JSON
          : null,
    };
  }
}
