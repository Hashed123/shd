import 'package:flutter/material.dart';
import 'package:slider/API/DiagnosisApi%20.dart';
import 'package:slider/DBModels/Diagnosis%20.dart';
import 'package:slider/presentation/Tests.dart';

class DiagnosesPage extends StatelessWidget {
  final DiagnosisApiService _apiService = DiagnosisApiService();

  @override
  Widget build(BuildContext context) {
    final gradientColor1 = Color.fromARGB(255, 83, 201, 234); // اللون الأول

    return Scaffold(
      appBar: AppBar(
        title: Text('Diagnoses'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [gradientColor1, Color.fromARGB(255, 75, 234, 122)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Diagnosis>>(
        future: _apiService.fetchAllDiagnoses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(gradientColor1),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No diagnoses found.'));
          } else {
            List<Diagnosis> diagnoses = snapshot.data!;

            return ListView.builder(
              itemCount: diagnoses.length,
              itemBuilder: (context, index) {
                Diagnosis diagnosis = diagnoses[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(
                        diagnosis.diagnosisResult,
                        style: TextStyle(
                          color: gradientColor1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (diagnosis.notes != null)
                            Text(
                              'Notes: ${diagnosis.notes}',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          if (diagnosis.symptoms != null)
                            ...diagnosis.symptoms!
                                .map((symptom) => Text(
                                      'Symptom: ${symptom.name}',
                                      style: TextStyle(color: Colors.grey[700]),
                                    ))
                                .toList(),
                          if (diagnosis.medications != null &&
                              diagnosis.medications!.isNotEmpty)
                            Text(
                              'Medications:',
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 14),
                            ),
                          if (diagnosis.medications != null)
                            ...diagnosis.medications!
                                .map((medication) => Text(
                                      'Medication: ${medication.name}',
                                      style: TextStyle(color: Colors.grey[700]),
                                    ))
                                .toList(),
                        ],
                      ),
                      onTap: () {
                        // تمرير diagnosisId إلى صفحة MedicationPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TestPage(),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
