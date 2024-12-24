import 'package:flutter/material.dart';
import 'package:slider/presentation/FinalDiagnosisPage.dart';
import 'package:slider/presentation/PatientScreen.dart';
import 'package:slider/presentation/SymptomsScreen.dart';
import '../API/LoginApi.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _loginMessage = '';

  // تعريف الألوان التدرج
  final gradientColor1 = Color.fromARGB(255, 83, 201, 234); // اللون الأول
  final gradientColor2 = Color.fromARGB(255, 75, 234, 122); // اللون الثاني

  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    String result = await AuthService().login(email, password);
    setState(() {
      _loginMessage = result;
    });

    // إذا كانت نتيجة تسجيل الدخول صحيحة، سيتم الانتقال إلى صفحة SymptomsPage
    if (result == "تم تسجيل الدخول بنجاح") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SymptomsPage()), // انتقل إلى SymptomsPage
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // جعل العناصر في الوسط عموديًا
              crossAxisAlignment:
                  CrossAxisAlignment.center, // جعل العناصر في الوسط أفقيًا
              children: <Widget>[
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'البريد الإلكتروني'),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'كلمة المرور'),
                  obscureText: true,
                ),
                SizedBox(height: 20),

                // استخدام Container مع التدرج اللوني لزر "تسجيل الدخول"
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [gradientColor1, gradientColor2],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius:
                        BorderRadius.circular(8), // تعيين الزوايا المدورة
                  ),
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent, // جعل خلفية الزر شفافة
                      padding: EdgeInsets.symmetric(
                          vertical: 15), // لتكبير الزر عموديًا
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8), // تعيين الزوايا المدورة للزر
                      ),
                      side: BorderSide(
                          color: Colors
                              .transparent), // إزالة الحدود لتبقى الشفافية
                    ),
                    child: Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                        color: Colors.white, // تغيير لون النص إلى أبيض
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                Text(
                  _loginMessage,
                  style: TextStyle(color: Colors.red),
                ),
                SizedBox(height: 20),

                // زر "إنشاء حساب" مع تأثير التدرج
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [gradientColor1, gradientColor2],
                      tileMode: TileMode.clamp,
                    ).createShader(bounds);
                  },
                  child: TextButton(
                    onPressed: () {
                      // الانتقال إلى صفحة التسجيل
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RegisterPatientScreen()), // صفحة التسجيل
                      );
                    },
                    child: Text(
                      'إنشاء حساب',
                      style: TextStyle(
                        fontSize: 16, // حجم النص
                        fontWeight: FontWeight.bold, // جعل النص عريضًا
                        color: Colors.white, // تحديد اللون الأبيض للنص
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
