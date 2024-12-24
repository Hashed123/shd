import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:slider/DBModels/PatientRecord%20.dart';

class ApiPatientRecord {
  final String baseUrl = "http://localhost:5059/api/PatientRecords";

  // دالة للحصول على سجل المريض
  Future<PatientRecord> getPatientRecords(int patientId) async {
    final response = await http.get(Uri.parse('$baseUrl/$patientId'));

    if (response.statusCode == 200) {
      // التحقق مما إذا كانت الاستجابة هي كائن واحد
      var data = json.decode(response.body);
      return PatientRecord.fromJson(data);
    } else {
      throw Exception('Failed to load patient record');
    }
  }

  // دالة لإنشاء سجل جديد
  Future<PatientRecord> createPatientRecord(PatientRecord record) async {
    final response = await http.post(
      Uri.parse('$baseUrl/patientrecords'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(record.toJson()),
    );

    if (response.statusCode == 201) {
      return PatientRecord.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create record');
    }
  }

  // دالة لتحديث سجل المريض
  Future<PatientRecord> updatePatientRecord(PatientRecord record) async {
    final response = await http.put(
      Uri.parse('$baseUrl/patientrecords/${record.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(record.toJson()),
    );

    if (response.statusCode == 200) {
      return PatientRecord.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update record');
    }
  }

  // دالة لحذف سجل المريض
  Future<void> deletePatientRecord(int id) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/patientrecords/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete record');
    }
  }
}
