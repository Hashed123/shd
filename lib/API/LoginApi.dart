import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'http://localhost:5059/api/login';

  // دالة لتسجيل الدخول
  Future<String> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // في حالة النجاح يتم إرجاع رسالة أو بيانات المريض
      return "تم تسجيل الدخول بنجاح";
    } else if (response.statusCode == 401) {
      // في حالة حدوث خطأ في البريد الإلكتروني أو كلمة المرور
      return "البريد الإلكتروني أو كلمة المرور غير صحيحة.";
    } else {
      // إذا كان هناك أي خطأ آخر
      return "حدث خطأ أثناء تسجيل الدخول.";
    }
  }
}
