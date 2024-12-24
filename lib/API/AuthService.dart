import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:slider/DBModels/Patient%20.dart';

class AuthService {
  static const String baseUrl = 'http://your-api-url/api/auth';

  // تسجيل الدخول
  Future<Patient?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return Patient.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  // إنشاء حساب
  Future<Patient?> register(Patient newPatient) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(newPatient.toJson()),
    );

    if (response.statusCode == 200) {
      return Patient.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
