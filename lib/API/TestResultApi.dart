import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = 'http://localhost:5059/api/TestResults';

  // دالة لإرسال نتيجة الفحص إلى الـ API
  Future<bool> submitTestResult({
    required int testId,
    required String result,
    required DateTime testDate,
    required String testType,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'TestId': testId,
          'Result': result,
          'TestDate': testDate.toIso8601String(), // تحويل التاريخ إلى ISO
          'TestType': testType,
        }),
      );

      if (response.statusCode == 200) {
        return true; // إذا كانت الاستجابة 200، فهذا يعني النجاح
      } else {
        return false; // فشل العملية
      }
    } catch (e) {
      return false; // في حال حدوث استثناء، نرجع false
    }
  }
}
