import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:slider/DBModels/Diagnosis%20.dart';

class DiagnosisApiService {
  static const String baseUrl = "http://localhost:5059/api/Diagnoses";

  // جلب جميع التشخيصات
  Future<List<Diagnosis>> fetchAllDiagnoses() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      // تأكد من أن البيانات تأتي بشكل صحيح
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Diagnosis.fromJson(json)).toList();
    } else {
      throw Exception("فشل في تحميل التشخيصات");
    }
  }

  // جلب تشخيص بناءً على ID
  Future<Diagnosis> fetchDiagnosisById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      // تحويل الـ JSON إلى موديل Diagnosis
      return Diagnosis.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("فشل في تحميل التشخيص");
    }
  }
}
