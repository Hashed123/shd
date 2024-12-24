import 'package:slider/DBModels/Diagnosis%20.dart';
import 'package:slider/DBModels/Medication%20.dart';
import 'package:slider/DBModels/Patient%20.dart';
import 'package:slider/DBModels/Question%20.dart';
import 'package:slider/DBModels/Symptom.dart';
import 'package:slider/DBModels/TestResult%20.dart';

class PatientRecord {
  final int id;
  final int? patientId;
  final int? diagnosisId;
  final DateTime date;
  final String details;
  final Patient? patient;
  final Diagnosis? diagnosis;
  final List<TestResult>? testResults;
  final List<Medication>? medications;
  final List<Symptom>? symptoms;
  final List<Question>? questions;

  PatientRecord({
    required this.id,
    this.patientId,
    this.diagnosisId,
    required this.date,
    required this.details,
    this.patient,
    this.diagnosis,
    this.testResults,
    this.medications,
    this.symptoms,
    this.questions,
  });

  // تحويل JSON إلى PatientRecord
  factory PatientRecord.fromJson(Map<String, dynamic> json) {
    return PatientRecord(
      id: json['Id'],
      patientId: json['PatientId'],
      diagnosisId: json['DiagnosisId'],
      date: DateTime.parse(json['Date']),
      details: json['Details'],
      patient:
          json['Patient'] != null ? Patient.fromJson(json['Patient']) : null,
      diagnosis: json['Diagnosis'] != null
          ? Diagnosis.fromJson(json['Diagnosis'])
          : null,
      testResults: json['TestResults'] != null && json['TestResults'] is List
          ? (json['TestResults'] as List)
              .map((item) => TestResult.fromJson(item))
              .toList()
          : [], // التأكد من أن TestResults قائمة
      medications: json['Medications'] != null && json['Medications'] is List
          ? (json['Medications'] as List)
              .map((item) => Medication.fromJson(item))
              .toList()
          : [], // التأكد من أن Medications قائمة
      symptoms: json['Symptoms'] != null && json['Symptoms'] is List
          ? (json['Symptoms'] as List)
              .map((item) => Symptom.fromJson(item))
              .toList()
          : [], // التأكد من أن Symptoms قائمة
      questions: json['Questions'] != null && json['Questions'] is List
          ? (json['Questions'] as List)
              .map((item) => Question.fromJson(item))
              .toList()
          : [], // التأكد من أن Questions قائمة
    );
  }

  // تحويل PatientRecord إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'PatientId': patientId,
      'DiagnosisId': diagnosisId,
      'Date': date.toIso8601String(),
      'Details': details,
      'Patient': patient?.toJson(),
      'Diagnosis': diagnosis?.toJson(),
      'TestResults': testResults != null
          ? testResults!.map((e) => e.toJson()).toList()
          : null,
      'Medications': medications != null
          ? medications!.map((e) => e.toJson()).toList()
          : null,
      'Symptoms':
          symptoms != null ? symptoms!.map((e) => e.toJson()).toList() : null,
      'Questions':
          questions != null ? questions!.map((e) => e.toJson()).toList() : null,
    };
  }
}
