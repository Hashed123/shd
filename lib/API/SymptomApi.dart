import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:slider/DBModels/symptom.dart';

class SymptomsApi {
  static const String baseUrl =
      'http://localhost:5059/api/Symptoms'; // URL الأساسي

  // دالة لجلب الأعراض من API
  static Future<List<Symptom>> fetchSymptoms() async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl')).timeout(Duration(seconds: 10));

      // التحقق من حالة الاستجابة
      if (response.statusCode == 200) {
        // إذا كانت الاستجابة ناجحة
        final List<dynamic> data = json.decode(response.body);
        // تحويل البيانات المستلمة إلى قائمة من الأعراض
        return data.map((json) => Symptom.fromJson(json)).toList();
      } else {
        // في حالة فشل الاستجابة من الخادم
        throw Exception('فشل تحميل الأعراض: ${response.statusCode}');
      }
    } catch (e) {
      // التعامل مع الأخطاء، مثل عدم وجود اتصال بالإنترنت أو Timeout
      throw Exception('حدث خطأ أثناء الاتصال: $e');
    }
  }
}
