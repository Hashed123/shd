import 'package:flutter/material.dart';
import 'package:slider/API/MedicationApi%20.dart';

import '../DBModels/Medication .dart';

class MedicationPage extends StatefulWidget {
  final int diagnosisId; // تمرير diagnosisId من صفحة DiagnosesPage

  MedicationPage({required this.diagnosisId});

  @override
  _MedicationPageState createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
  List<Medication> medications = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMedications(); // جلب الأدوية باستخدام diagnosisId
  }

  // جلب الأدوية بناءً على diagnosisId
  Future<void> _fetchMedications() async {
    try {
      List<Medication> fetchedMedications =
          await MedicationApi.fetchMedications(
              widget.diagnosisId); // استخدام diagnosisId
      setState(() {
        medications = fetchedMedications;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error fetching medications: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final gradientColor1 = Color.fromARGB(255, 83, 201, 234);
    final gradientColor2 = Color.fromARGB(255, 75, 234, 122);

    return Scaffold(
      appBar: AppBar(
        title: Text("Medications"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [gradientColor1, gradientColor2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // العودة للصفحة السابقة
          },
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(gradientColor1),
              ),
            )
          : ListView.builder(
              itemCount: medications.length,
              itemBuilder: (context, index) {
                final medication = medications[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      medication.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: gradientColor1,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (medication.description.isNotEmpty)
                          Text(
                            'Description: ${medication.description}',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        if (medication.dosage?.isNotEmpty ?? false)
                          Text(
                            'Dosage: ${medication.dosage}',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        if (medication.diagnosis?.diagnosisResult.isNotEmpty ??
                            false)
                          Text(
                            'Diagnosis: ${medication.diagnosis!.diagnosisResult}',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                      ],
                    ),
                    tileColor: Colors.teal[50],
                    onTap: () {},
                  ),
                );
              },
            ),
    );
  }
}
