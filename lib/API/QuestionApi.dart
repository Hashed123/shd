import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:slider/DBModels/Question%20.dart';

class QuestionsApi {
  static const String baseUrl = "http://localhost:5059/api/Questions";

  // جلب الأسئلة بناءً على الـ symptomId
  Future<List<Question>> fetchQuestions(int symptomId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$symptomId'),
      );

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => Question.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load questions for symptom $symptomId');
      }
    } catch (e) {
      throw Exception('Error occurred while fetching questions: $e');
    }
  }
}
