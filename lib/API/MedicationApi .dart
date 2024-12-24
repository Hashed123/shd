import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:slider/DBModels/Medication%20.dart';

class MedicationApi {
  static const String baseUrl = 'http://localhost:5059/api/Medications';

  // دالة جلب الأدوية بناءً على diagnosisId
  static Future<List<Medication>> fetchMedications(int diagnosisId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$diagnosisId'));

      if (response.statusCode == 200) {
        // تحليل البيانات من JSON
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => Medication.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load medications  $diagnosisId');
      }
    } catch (e) {
      throw Exception('Error fetching medications: $e');
    }
  }
}
