import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:slider/DBModels/Patient%20.dart';
import 'package:slider/presentation/FinalDiagnosisPage.dart';
import 'package:slider/presentation/SymptomsScreen.dart';

class RegisterPatientScreen extends StatefulWidget {
  @override
  _RegisterPatientScreenState createState() => _RegisterPatientScreenState();
}

class _RegisterPatientScreenState extends State<RegisterPatientScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers لقراءة المدخلات من المستخدم
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _medicalHistoryController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // قائمة الخيارات للجنس
  List<String> genderOptions = ['أنثى', 'ذكر'];
  String? selectedGender;

  // دالة لإرسال البيانات إلى الـ API
  Future<void> _registerPatient() async {
    if (_formKey.currentState!.validate()) {
      // إذا كانت البيانات صحيحة
      Patient newPatient = Patient(
        id: 0, // إذا كانت الـ id تُحدد من قبل الخادم
        name: _nameController.text,
        age: int.parse(_ageController.text),
        medicalHistory: _medicalHistoryController.text,
        gender: selectedGender ?? '', // استخدام الجندر المحدد
        email: _emailController.text,
        password: _passwordController.text,
        diagnoses: null, // يمكن إضافتها إذا كانت هناك حاجة
        records: null, // يمكن إضافتها إذا كانت هناك حاجة
      );

      // إرسال البيانات إلى API
      final String url =
          "http://localhost:5059/api/Patients"; // يجب تعديل الرابط حسب الـ API الفعلي
      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(newPatient.toJson()), // تحويل البيانات إلى JSON
        );

        if (response.statusCode == 201) {
          // نجاح عملية التسجيل
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('تم التسجيل بنجاح'),
          ));

          // بعد نجاح التسجيل، الانتقال إلى صفحة الأعراض
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SymptomsPage()), // الانتقال إلى صفحة الأعراض
          );
        } else {
          // فشل عملية التسجيل
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('فشل في التسجيل'),
          ));
        }
      } catch (e) {
        // التعامل مع الخطأ في حالة عدم الاتصال بالخادم
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('حدث خطأ: $e'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final gradientColor1 = Color.fromARGB(255, 84, 89, 91); // اللون الأول
    final textColor = const Color.fromARGB(255, 145, 136, 136);
    final gradientColor3 = Color.fromARGB(255, 83, 201, 234); // first color

    final gradientColor2 = Color.fromARGB(255, 75, 234, 122) // second color

        .withOpacity(0.7); // الأسود مع شفافية 70%

    return BasePage(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // حقل الاسم مع الأيقونة
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'الاسم',
                  labelStyle: TextStyle(color: textColor),
                  prefixIcon:
                      Icon(Icons.person, color: gradientColor1), // أيقونة شخصية
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: gradientColor1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: gradientColor1),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال الاسم';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // حقل العمر مع الأيقونة
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(
                  labelText: 'العمر',
                  labelStyle: TextStyle(color: textColor),
                  prefixIcon: Icon(Icons.calendar_today,
                      color: gradientColor1), // أيقونة تقويم
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: gradientColor1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: gradientColor1),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال العمر';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // حقل التاريخ الطبي مع الأيقونة
              TextFormField(
                controller: _medicalHistoryController,
                decoration: InputDecoration(
                  labelText: 'التاريخ الطبي',
                  labelStyle: TextStyle(color: textColor),
                  prefixIcon: Icon(Icons.history,
                      color: gradientColor1), // أيقونة التاريخ الطبي
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: gradientColor1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: gradientColor1),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال التاريخ الطبي';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Dropdown لاختيار الجنس مع الأيقونة
              DropdownButtonFormField<String>(
                value: selectedGender,
                decoration: InputDecoration(
                  labelText: 'الجنس',
                  labelStyle: TextStyle(color: textColor),
                  prefixIcon: Icon(Icons.transgender,
                      color: gradientColor1), // أيقونة الجنس
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: gradientColor1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: gradientColor1),
                  ),
                ),
                items: genderOptions.map((String gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'يرجى اختيار الجنس';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // حقل البريد الإلكتروني مع الأيقونة
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'البريد الإلكتروني',
                  labelStyle: TextStyle(color: textColor),
                  prefixIcon: Icon(Icons.email,
                      color: gradientColor1), // أيقونة البريد الإلكتروني
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: gradientColor1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: gradientColor1),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال البريد الإلكتروني';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // حقل كلمة المرور مع الأيقونة
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'كلمة المرور',
                  labelStyle: TextStyle(color: textColor),
                  prefixIcon:
                      Icon(Icons.lock, color: gradientColor1), // أيقونة القفل
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: gradientColor1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: gradientColor1),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال كلمة المرور';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // زر التسجيل
              ElevatedButton(
                onPressed: _registerPatient,
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent, // خلفية الزر تكون شفافة
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        gradientColor3,
                        gradientColor2
                      ], // تطبيق التدرج اللوني
                      begin: Alignment.topLeft, // بداية التدرج من أعلى اليسار
                      end: Alignment.bottomRight, // نهاية التدرج في أسفل اليمين
                    ),
                    borderRadius: BorderRadius.circular(30), // نفس شكل الزر
                  ),
                  child: Center(
                    child: Text(
                      'إنشاء حساب',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
