import 'package:flutter/material.dart';
import 'package:slider/API/TestResultApi.dart';
import 'package:slider/presentation/FinalDiagnosisPage.dart'; // Import BasePage

class TestResultPage extends StatefulWidget {
  final int testId;

  TestResultPage({required this.testId});

  @override
  _TestResultPageState createState() => _TestResultPageState();
}

class _TestResultPageState extends State<TestResultPage> {
  TextEditingController resultController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String? testType = 'Laboratory'; // نوع الفحص الافتراضي
  bool isLoading = false;

  // اختيار تاريخ الفحص
  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // إرسال نتيجة الفحص إلى الـ API
  Future<void> _submitTestResult() async {
    if (resultController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter all fields')));
      return;
    }

    setState(() {
      isLoading = true;
    });

    bool isSuccess = await ApiService().submitTestResult(
      testId: widget.testId,
      result: resultController.text,
      testDate: selectedDate,
      testType: testType ??
          'Laboratory', // إذا كان testType فارغًا، نستخدم 'Laboratory' كقيمة افتراضية
    );

    setState(() {
      isLoading = false;
    });

    if (isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Test result submitted successfully')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit test result')));
    }
  }

  @override
  Widget build(BuildContext context) {
    // الألوان المستخدمة في AppBar
    final gradientColor1 = Color.fromARGB(255, 83, 201, 234); // اللون الأول

    // Return the BasePage with the dynamic content passed as body
    return BasePage(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      gradientColor1), // لون دوران التحميل أزرق
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter Test Result:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: gradientColor1, // اللون الأزرق من AppBar
                    ),
                  ),
                  TextField(
                    controller: resultController,
                    decoration: InputDecoration(
                      hintText: 'Enter the test result',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: gradientColor1), // تلوين الحواف بالأزرق
                      ),
                    ),
                    maxLines: 5,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Select a Test Date:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: gradientColor1, // اللون الأزرق من AppBar
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _pickDate,
                    style: ElevatedButton.styleFrom(
                      primary: gradientColor1, // اللون الأزرق من AppBar
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Pick Date', style: TextStyle(fontSize: 16)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Selected Date: ${selectedDate.toLocal()}'
                        .split(' ')[0], // عرض التاريخ
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Select Test Type:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: gradientColor1, // اللون الأزرق من AppBar
                    ),
                  ),
                  DropdownButton<String>(
                    value: testType,
                    onChanged: (String? newValue) {
                      setState(() {
                        testType = newValue;
                      });
                    },
                    items: <String>['Laboratory', 'Radiology']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitTestResult,
                    style: ElevatedButton.styleFrom(
                      primary: gradientColor1, // اللون الأزرق من AppBar
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Submit Result',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // تغيير لون النص إلى الأبيض
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
