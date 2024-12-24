import 'package:flutter/material.dart';
import 'package:slider/presentation/DiagnosisScreen.dart';
import 'package:slider/presentation/Home.dart';
import 'package:slider/presentation/PatientScreen.dart';

class BasePage extends StatelessWidget {
  final Widget body; // This will be the changing content of the page
  final FloatingActionButton? floatingActionButton; // Floating Action Button

  BasePage({required this.body, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    final gradientColor1 = Color.fromARGB(255, 83, 201, 234); // first color
    final gradientColor2 = Color.fromARGB(255, 75, 234, 122); // second color

    return Scaffold(
      // Adding Drawer with a plain background for ListView items
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // User info header with gradient background
            UserAccountsDrawerHeader(
              accountName: Text(
                'اسم المستخدم',
                style: TextStyle(
                    color: Colors.white), // Change text color to white
              ),
              accountEmail: Text(
                'البريد الإلكتروني',
                style: TextStyle(
                    color: Colors.white), // Change text color to white
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: gradientColor1,
                ),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    gradientColor1,
                    gradientColor2
                  ], // Gradient applied here
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            // List tiles in Drawer with navigation functionality
            ListTile(
              leading: Icon(Icons.home),
              title: Text('الصفحة الرئيسية'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage()), // Navigate to HomePage
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('المرضى'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          RegisterPatientScreen()), // Navigate to PatientsPage
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('التشخيص'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('الإعدادات'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('تسجيل الخروج'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Add logout functionality here (for example, clear user session)
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Medical App"),
        centerTitle: true, // Center the title
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [gradientColor1, gradientColor2],
              begin: Alignment.centerLeft, // gradient starts from left
              end: Alignment.centerRight, // gradient ends on the right
            ),
          ),
        ),
      ),
      body: body, // Adding the dynamic content here
      floatingActionButton: floatingActionButton, // Using the passed FAB
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent, // Transparent to show gradient
        selectedItemColor: Colors.white, // Color for selected icons
        unselectedItemColor: Colors.white70, // Color for unselected icons
        elevation: 0, // Remove shadow for a cleaner look
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Patients',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Diagnose',
          ),
        ],
        onTap: (index) {
          // Handle navigation based on the index
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage()), // Navigate to HomePage
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        RegisterPatientScreen()), // Navigate to PatientsPage
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DiagnosesPage()), // Navigate to DiagnosePage
              );
              break;
          }
        },
      ),
    );
  }
}
