import 'package:slider/DBModels/symptom.dart';

class Question {
  final int id;
  final String text;
  dynamic symptomId; // جعلها dynamic لقبول أي نوع بيانات
  dynamic symptom; // جعلها dynamic لقبول أي نوع بيانات
  dynamic answer; // جعلها dynamic لقبول أي نوع بيانات

  Question({
    required this.id,
    required this.text,
    this.symptomId,
    this.symptom,
    this.answer, // إضافة الجواب في البنية
  });

  // تحويل من JSON إلى كائن Question
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['Id'] ?? 0, // تأكد من أن المفتاح هو 'Id' وليس 'id'
      text: json['Text'] ?? '', // تأكد من أن المفتاح هو 'Text' وليس 'text'
      symptomId: json['SymptomId'], // الآن يمكن أن يكون من أي نوع
      symptom:
          json['Symptom'] != null && json['Symptom'] is Map<String, dynamic>
              ? Symptom.fromJson(json['Symptom'])
              : null, // إذا كانت موجودة سيتم تحويلها إلى Symptom
      answer: json['Answer'], // الآن يمكن أن يكون من أي نوع
    );
  }

  // تحويل كائن Question إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'Id': id, // تأكد من أن المفتاح هو 'Id' وليس 'id'
      'Text': text, // تأكد من أن المفتاح هو 'Text' وليس 'text'
      'SymptomId': symptomId, // يمكن أن تكون من أي نوع
      'Symptom': symptom != null
          ? symptom.toJson()
          : null, // تحويل Symptom إلى JSON إذا كانت موجودة
      'Answer': answer, // يمكن أن تكون من أي نوع
    };
  }
}
