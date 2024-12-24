import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:slider/DBModels/Diagnosis%20.dart';
import 'package:slider/DBModels/Test%20.dart';
import 'package:slider/presentation/FinalDiagnosisPage.dart';
import 'package:slider/presentation/TestResult.dart';

class TestPage extends StatefulWidget {
  late final Diagnosis diagnosis;
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<Test> tests = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTests();
  }

  // Fetch tests from the API
  Future<void> _fetchTests() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:5059/api/Tests'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          tests = data.map((item) => Test.fromJson(item)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load tests');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error fetching tests: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final gradientColor1 = Color.fromARGB(255, 83, 201, 234); // first color

    // Use BasePage to wrap the content of TestPage
    return BasePage(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(gradientColor1),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: tests.length,
                itemBuilder: (context, index) {
                  final test = tests[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TestResultPage(testId: test.id),
                          ),
                        );
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        title: Text(
                          test.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: gradientColor1,
                          ),
                        ),
                        subtitle: Text(
                          test.description,
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward,
                          color: gradientColor1,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
