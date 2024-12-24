import 'package:slider/DBModels/PatientRecord%20.dart';
import 'package:slider/DBModels/Test%20.dart';

class TestResult {
  int id;
  int testId;
  String result;
  DateTime testDate;
  String? testType; // نوع الفحص مثل مخبري، إشعاعي...
  Test? test; // العلاقة مع الفحص
  int? patientRecordId; // إضافة PatientRecordId
  PatientRecord? patientRecord; // إضافة العلاقة مع سجل المريض

  TestResult({
    required this.id,
    required this.testId,
    required this.result,
    required this.testDate,
    this.testType,
    this.test,
    this.patientRecordId,
    this.patientRecord,
  });

  // تحويل JSON إلى TestResult
  factory TestResult.fromJson(Map<String, dynamic> json) {
    return TestResult(
      id: json['id'] ?? 0, // إضافة القيمة الافتراضية إذا لم تكن موجودة
      testId: json['testId'] ?? 0,
      result: json['result'] ?? '',
      testDate: json['testDate'] != null
          ? DateTime.tryParse(json['testDate']) ?? DateTime.now()
          : DateTime.now(),
      testType: json['testType'], // قد يكون String أو null
      test: json['test'] != null ? Test.fromJson(json['test']) : null,
      patientRecordId: json['patientRecordId'], // إضافة patientRecordId
      patientRecord: json['patientRecord'] != null
          ? PatientRecord.fromJson(json['patientRecord'])
          : null, // إضافة patientRecord
    );
  }

  // تحويل TestResult إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'testId': testId,
      'result': result,
      'testDate': testDate.toIso8601String(),
      'testType': testType, // سيتم تضمين القيمة نفسها (قد تكون String أو null)
      'test': test?.toJson(),
      'patientRecordId': patientRecordId, // تضمين patientRecordId
      'patientRecord': patientRecord?.toJson(), // تضمين patientRecord
    };
  }
}
