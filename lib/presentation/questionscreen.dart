import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:slider/DBModels/Question%20.dart';
import 'package:http/http.dart' as http;
import 'package:slider/presentation/DiagnosisScreen.dart';
import 'package:slider/presentation/FinalDiagnosisPage.dart'; // Import BasePage

class QuestionsPage extends StatefulWidget {
  final List<int> selectedSymptomIds; // List of symptom IDs

  QuestionsPage({required this.selectedSymptomIds});

  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  List<Question> questions = [];
  bool isLoading = true;
  Map<int, String> answers = {}; // To store the answers
  bool allAnswered = false; // Track if all questions have been answered

  @override
  void initState() {
    super.initState();
    fetchQuestions(); // Fetch questions when the page is loaded
  }

  Future<void> fetchQuestions() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://localhost:5059/api/Questions'), // Ensure the correct URL
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body); // Decode data
        setState(() {
          questions = data.map((json) => Question.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load questions');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Handle "Yes" and "No" answers
  void _handleAnswer(int questionId, String answer) {
    setState(() {
      answers[questionId] = answer;
      // Check if all questions are answered
      allAnswered = answers.length == questions.length;
    });
  }

  void _navigateToDiagnosis() {
    if (!allAnswered) {
      // Show an alert if not all questions are answered
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Incomplete answers'),
          content: Text('Please answer all questions before proceeding.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Proceed to Diagnosis Page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (conztext) => DiagnosesPage(), // Use appropriate page here
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final gradientColor1 = Color.fromARGB(255, 83, 201, 234);

    return BasePage(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final question = questions[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    title: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        question.text.isEmpty
                            ? "No text available"
                            : question.text,
                        style: TextStyle(
                          color: gradientColor1, // primary color
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _handleAnswer(question.id, "Yes");
                              },
                              child: Text("Yes"),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                onPrimary: Colors.white, // white text
                              ),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                _handleAnswer(question.id, "No");
                              },
                              child: Text("No"),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                onPrimary: Colors.white, // white text
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: allAnswered
          ? FloatingActionButton(
              onPressed: _navigateToDiagnosis,
              backgroundColor: gradientColor1, // primary color
              child:
                  Icon(Icons.arrow_forward, color: Colors.white), // Icon color
            )
          : null, // Only show FAB when all questions are answered
    );
  }
}
