import 'package:slider/DBModels/Medication%20.dart';
import 'package:slider/DBModels/Patient%20.dart';
import 'package:slider/DBModels/Question%20.dart';
import 'package:slider/DBModels/symptom.dart';

class Diagnosis {
  final int id;
  final int? patientId;
  final String diagnosisResult;
  final String? notes;
  final Patient? patient;
  final List<Symptom>? symptoms;
  final List<Medication>? medications;
  final List<Question>? questions;

  // Constructor
  Diagnosis({
    required this.id,
    this.patientId,
    required this.diagnosisResult,
    this.notes,
    this.patient,
    this.symptoms,
    this.medications,
    this.questions,
  });

  // Factory constructor to create a Diagnosis from JSON
  factory Diagnosis.fromJson(Map<String, dynamic> json) {
    var symptomsList = json['Symptoms'] as List?;
    List<Symptom>? symptoms = symptomsList != null
        ? symptomsList.map((i) => Symptom.fromJson(i)).toList()
        : null;

    var medicationsList = json['Medications'] as List?;
    List<Medication>? medications = medicationsList != null
        ? medicationsList.map((i) => Medication.fromJson(i)).toList()
        : null;

    var questionsList = json['Questions'] as List?;
    List<Question>? questions = questionsList != null
        ? questionsList.map((i) => Question.fromJson(i)).toList()
        : null;

    return Diagnosis(
      id: json['Id'],
      patientId: json['PatientId'],
      diagnosisResult: json['DiagnosisResult'],
      notes: json['Notes'],
      patient:
          json['Patient'] != null ? Patient.fromJson(json['Patient']) : null,
      symptoms: symptoms,
      medications: medications,
      questions: questions,
    );
  }

  // Method to convert Diagnosis to JSON
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'PatientId': patientId,
      'DiagnosisResult': diagnosisResult,
      'Notes': notes,
      'Patient': patient?.toJson(),
      'Symptoms':
          symptoms != null ? symptoms!.map((e) => e.toJson()).toList() : [],
      // Remove medications if it is null or empty

      'Medications': medications != null
          ? medications!.map((e) => e.toJson()).toList()
          : [],
      'Questions':
          questions != null ? questions!.map((e) => e.toJson()).toList() : [],
    };
  }
}
