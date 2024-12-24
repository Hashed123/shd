import 'package:flutter/material.dart';
import 'package:slider/API/SymptomApi.dart';
import 'package:slider/DBModels/symptom.dart';
import 'package:slider/presentation/FinalDiagnosisPage.dart';
import 'package:slider/presentation/questionscreen.dart';

class SymptomsPage extends StatefulWidget {
  @override
  _SymptomsPageState createState() => _SymptomsPageState();
}

class _SymptomsPageState extends State<SymptomsPage> {
  List<Symptom> symptoms = [];
  List<Symptom> selectedSymptoms = [];

  @override
  void initState() {
    super.initState();
    _fetchSymptoms();
  }

  // جلب الأعراض من الـ API
  Future<void> _fetchSymptoms() async {
    try {
      symptoms = await SymptomsApi.fetchSymptoms();
      setState(() {});
    } catch (e) {
      print('Error fetching symptoms: $e');
    }
  }

  // التعامل مع اختيار/إلغاء اختيار الأعراض
  void _onSymptomSelected(Symptom symptom) {
    setState(() {
      if (selectedSymptoms.contains(symptom)) {
        selectedSymptoms.remove(symptom);
      } else {
        selectedSymptoms.add(symptom);
      }
    });
  }

  // التنقل إلى صفحة الأسئلة مع الأعراض المختارة
  void _navigateToQuestionsPage() {
    if (selectedSymptoms.isNotEmpty) {
      List<int> selectedSymptomIds = selectedSymptoms.map((e) => e.id).toList();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              QuestionsPage(selectedSymptomIds: selectedSymptomIds),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select at least one symptom')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // الألوان المستخدمة في AppBar
    final gradientColor1 = Color.fromARGB(255, 83, 201, 234); // اللون الأول
// اللون الثاني

    // الـ FloatingActionButton الذي سيتم تمريره إلى BasePage
    final floatingActionButton = FloatingActionButton(
      onPressed: _navigateToQuestionsPage,
      backgroundColor: gradientColor1, // نفس اللون من AppBar
      child:
          Icon(Icons.arrow_forward, color: Colors.white), // تغيير لون الأيقونة
    );

    return BasePage(
      body: symptoms.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  // نص "اختر الأعراض"
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'اختر الأعراض',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: gradientColor1, // نفس اللون من AppBar
                      ),
                    ),
                  ),
                  // قائمة الأعراض
                  Expanded(
                    child: ListView.builder(
                      itemCount: symptoms.length,
                      itemBuilder: (context, index) {
                        final symptom = symptoms[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            title: Text(
                              symptom.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: gradientColor1, // نفس اللون من AppBar
                              ),
                            ),
                            subtitle: Text(
                              symptom.description, // فحص القيمة قبل العرض
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                            onTap: () => _onSymptomSelected(symptom),
                            trailing: selectedSymptoms.contains(symptom)
                                ? Icon(
                                    Icons.check_circle,
                                    color: gradientColor1,
                                  ) // نفس اللون من AppBar
                                : Icon(Icons.check_circle_outline,
                                    color: Colors.grey),
                            tileColor: selectedSymptoms.contains(symptom)
                                ? gradientColor1.withOpacity(0.1)
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: floatingActionButton, // تم تمرير الـ FAB هنا
    );
  }
}
