import 'package:flutter/material.dart';
import 'package:slider/presentation/FinalDiagnosisPage.dart';

// الصفحة الرئيسية التي تستدعي كلاس BasePage
class HomePage extends StatelessWidget {
  final gradientColor1 = Color.fromARGB(255, 83, 201, 234); // اللون الأول
  final gradientColor2 = Color.fromARGB(255, 75, 234, 122); // اللون الثاني

  @override
  Widget build(BuildContext context) {
    return BasePage(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // رسالة ترحيب
              Text(
                'مرحبًا بك في تطبيق تشخيص الأمراض',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // تم تغيير اللون إلى الأسود
                ),
              ),
              SizedBox(height: 20),
              Text(
                'من فضلك اختر الخيار الذي ترغب في البدء به:',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black, // تم تغيير اللون إلى الأسود
                ),
              ),
              SizedBox(height: 20),

              // Grid of Icons (تشخيصات، الفحوصات، الأعراض)
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2, // عدد الأعمدة في الشبكة
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: <Widget>[
                    _buildIconCard(
                      context,
                      icon: Icons.local_hospital,
                      title: 'التشخيصات',
                      onTap: () {
                        // اذهب إلى صفحة التشخيصات
                      },
                    ),
                    _buildIconCard(
                      context,
                      icon: Icons.healing,
                      title: 'الفحوصات',
                      onTap: () {
                        // اذهب إلى صفحة الفحوصات
                      },
                    ),
                    _buildIconCard(
                      context,
                      icon: Icons.search,
                      title: 'اختيار الأعراض',
                      onTap: () {
                        // اذهب إلى صفحة الأعراض
                      },
                    ),
                    _buildIconCard(
                      context,
                      icon: Icons.help,
                      title: 'الأسئلة الشائعة',
                      onTap: () {
                        // اذهب إلى صفحة الأسئلة الشائعة
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your floating action button functionality here
        },
        child: Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 163, 239, 166),
      ),
    );
  }

  // دالة لبناء كل Card يحتوي على أيقونة
  Widget _buildIconCard(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [gradientColor1, gradientColor2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: Icon(
                icon,
                size: 50,
                color: Colors.white, // نستخدم اللون الأبيض لكي يظهر التدرج
              ),
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black, // تم تغيير اللون إلى الأسود
              ),
            ),
          ],
        ),
      ),
    );
  }
}
