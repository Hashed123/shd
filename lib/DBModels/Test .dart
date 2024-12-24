import 'package:slider/DBModels/TestResult%20.dart';

class Test {
  final int id;
  final String name;
  final String description;
  final String testType; // إضافة نوع الفحص
  dynamic testResults; // يمكن أن تكون List<TestResult> أو null

  Test({
    required this.id,
    required this.name,
    required this.description,
    required this.testType, // إضافة نوع الفحص
    this.testResults, // يمكن أن تكون null أو List<TestResult>
  });

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      id: json['Id'],
      name: json['Name'],
      description: json['Description'],
      testType:
          json['TestType'] ?? '', // إضافة القيمة الافتراضية إذا لم تكن موجودة
      testResults: json['TestResults'] != null
          ? (json['TestResults'] as List)
              .map((item) => TestResult.fromJson(item))
              .toList()
          : null, // إذا كانت TestResults غير موجودة، ستكون null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Description': description,
      'TestType': testType, // تضمين نوع الفحص
      'TestResults': testResults != null
          ? (testResults as List).map((e) => e.toJson()).toList()
          : null, // إذا كانت testResults فارغة، ستكون null
    };
  }
}
