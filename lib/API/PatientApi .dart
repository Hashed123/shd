import 'dart:convert';
import 'package:http/http.dart' as http;

class PatientApi {
  // هنا يتم وضع رابط API الخاص بالخادم الذي ستتعامل معه.
  final String baseUrl = 'http://localhost:5059/api/Patients';

  // دالة لإرسال بيانات المريض إلى API
  Future<String> registerPatient(String name, int age, String medicalHistory,
      String gender, String email, String password) async {
    final response = await http.post(Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'Name': name,
          'Age': age,
          'MedicalHistory': medicalHistory,
          'Gender': gender,
          'Email': email,
          'Password': password,
          // إضافة خاصية الجنس هنا
        }));

    if (response.statusCode == 200) {
      // فرضًا أن الـ patientId يتم إرجاعه هنا بعد التسجيل بنجاح
      final patientId = response
          .body; // أو استخدم طريقة لاستخراج الـ patientId من الـ response
      return patientId;
    } else {
      throw Exception('Failed to register patient');
    }
  }
}
