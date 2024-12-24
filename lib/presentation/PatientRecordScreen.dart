import 'package:flutter/material.dart';
import 'package:slider/API/PatientRecordApi.dart';
import 'package:slider/DBModels/PatientRecord%20.dart';

class PatientRecordScreen extends StatefulWidget {
  final int patientId;

  PatientRecordScreen({required this.patientId});

  @override
  _PatientRecordScreenState createState() => _PatientRecordScreenState();
}

class _PatientRecordScreenState extends State<PatientRecordScreen> {
  late ApiPatientRecord apiPatientRecord; // تغيير الاسم هنا
  late Future<PatientRecord>
      patientRecord; // تغيير نوع المستقبل إلى PatientRecord

  @override
  void initState() {
    super.initState();
    apiPatientRecord = ApiPatientRecord(); // تغيير الاسم هنا
    patientRecord =
        apiPatientRecord.getPatientRecords(widget.patientId); // تغيير الاسم هنا
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Patient Record")),
      body: FutureBuilder<PatientRecord>(
        future: patientRecord,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return Center(child: Text('No record found.'));
          }

          PatientRecord record = snapshot.data!; // السجل الوحيد
          return ListView(
            children: [
              ListTile(
                title: Text(record.details), // عرض التفاصيل
                subtitle:
                    Text(record.date.toIso8601String()), // عرض تاريخ السجل
              ),
            ],
          );
        },
      ),
    );
  }
}
