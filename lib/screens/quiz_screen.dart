import 'package:flutter/material.dart';
import 'package:veteran_connect/screens/benefits_list_screen.dart';
import 'package:veteran_connect/screens/home_screen.dart';

class BenefitsNavigatorScreen extends StatelessWidget {
  const BenefitsNavigatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          'Benefits',
          style: TextStyle(
            fontSize: 40,
            fontFamily: 'Anton',
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade700, Colors.green.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 35),
              Text(
                'Take Eligibility Quiz',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              AnimatedPadding(
                padding: EdgeInsets.all(8.0),
                duration: Duration(milliseconds: 500),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.green),
                    ),
                  ),
                  child: Text(
                    'Start Quiz',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuizScreen()),
                    );
                  },
                ),
              ),
              SizedBox(height: 12.5), // Space between buttons
              AnimatedPadding(
                padding: EdgeInsets.all(8.0),
                duration: Duration(milliseconds: 500),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Background color
                    foregroundColor: Colors.green, // Text color
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Rounded corners
                      side: BorderSide(color: Colors.green), // Border color
                    ),
                  ),
                  child: Text(
                    'View Benefits',
                    style: TextStyle(
                      fontSize: 30, // Match the button text size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BenefitsListScreen()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Navigating to View Benefits')),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            // Navigate back to the Home screen
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (route) => false,
            );
          } else if (index == 1) {
            // Show "About" pop-up
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('About'),
                  content: Text('Produced by Ronak Pai.\n\nThis app was created for educational purposes.'),
                  actions: [
                    TextButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Are you a veteran?',
      'type': 'yesno',
    },
    {
      'question': 'What is your age?',
      'type': 'multiple-choice',
      'options': ['Under 30', '30-50', 'Over 50'],
    },
    {
      'question': 'Do you have a service-related disability?',
      'type': 'yesno',
    },
    {
      'question': 'What branch of the military did you serve?',
      'type': 'multiple-choice',
      'options': ['Army', 'Space Force', 'Air Force', 'Marines', 'Coast Guard', 'Navy'],
    },
    {
      'question': 'Have you served in combat?',
      'type': 'yesno',
    },
    {
      'question': 'Do you receive retirement pay?',
      'type': 'yesno',
    },
    {
      'question': 'Are you currently employed?',
      'type': 'yesno',
    },
    {
      'question': 'Do you have dependent children?',
      'type': 'yesno',
    },
    {
      'question': 'Have you applied for VA benefits before?',
      'type': 'yesno',
    },
    {
      'question': 'Do you have a higher education degree?',
      'type': 'yesno',
    },
  ];

  List<String?> answers = []; // Declare the answers list without initialization

  @override
  void initState() {
    super.initState();
    answers = List.filled(questions.length, null); // Initialize the answers list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          'Eligibility Quiz',
          style: TextStyle(
            fontSize: 35,
            fontFamily: 'Anton',
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    questions[index]['question'],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 12, 142, 20), // Set question text color to white
                    ),
                  ),
                  SizedBox(height: 10), // Add space between question and buttons
                  if (questions[index]['type'] == 'yesno') ...[
                    Center( // Center the Yes/No buttons
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildYesNoButton('Yes', index),
                          SizedBox(width: 20), // Add space between buttons
                          _buildYesNoButton('No', index),
                        ],
                      ),
                    ),
                  ] else if (questions[index]['type'] == 'multiple-choice') ...[
                    Center( // Center the multiple choice buttons
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 10, // Space between buttons
                        children: questions[index]['options']
                            .map<Widget>((option) {
                          return _buildMultipleChoiceButton(option, index);
                        }).toList(),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle submission and navigate to results screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultsScreen(answers: answers),
            ),
          );
        },
        child: Icon(Icons.check),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _buildYesNoButton(String label, int questionIndex) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: answers[questionIndex] == label ? Colors.green : Colors.white,
        foregroundColor: answers[questionIndex] == label ? Colors.white : Colors.green,
      ),
      onPressed: () {
        setState(() {
          answers[questionIndex] = label;
        });
      },
      child: Text(label),
    );
  }

  Widget _buildMultipleChoiceButton(String label, int questionIndex) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: answers[questionIndex] == label ? Colors.green : Colors.white,
        foregroundColor: answers[questionIndex] == label ? Colors.white : Colors.green,
      ),
      onPressed: () {
        setState(() {
          answers[questionIndex] = label;
        });
      },
      child: Text(label),
    );
  }
}

class ResultsScreen extends StatelessWidget {
  final List<String?> answers;

  ResultsScreen({required this.answers});

  @override
  Widget build(BuildContext context) {
    // Prepare the list of benefits
    List<String> benefits = [];

    if (answers[0] == 'Yes') {
      benefits.add('Veteran Benefits');
    }
    if (answers[1] == 'Under 30') {
      benefits.add('Youth Benefits');
    } else if (answers[1] == '30-50') {
      benefits.add('Mid-Life Benefits');
    } else if (answers[1] == 'Over 50') {
      benefits.add('Senior Benefits');
    }
    if (answers[2] == 'Yes') {
      benefits.add('Disability Benefits');
    }
    if (answers[3] != null) {
      benefits.add('Benefits related to the ${answers[3]}');
    }
    if (answers[4] == 'Yes') {
      benefits.add('Combat Benefits');
    }
    if (answers[5] == 'Yes') {
      benefits.add('Retirement Benefits');
    }
    if (answers[6] == 'Yes') {
      benefits.add('Employment Benefits');
    }
    if (answers[7] == 'Yes') {
      benefits.add('Dependent Benefits');
    }
    if (answers[8] == 'Yes') {
      benefits.add('VA Benefits');
    }
    if (answers[9] == 'Yes') {
      benefits.add('Higher Education Benefits');
    }

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          'Results',
          style: TextStyle(
            fontSize: 35,
            fontFamily: 'Anton',
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade700, Colors.green.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'You could be eligible for the following benefits:',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ...benefits.map((benefit) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      benefit,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  );
                }).toList(),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BenefitsNavigatorScreen(),
                      ),
                    ); // Navigate to BenefitsNavigatorScreen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.green,
                  ),
                  child: Text(
                    'Return to Benefits',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            // Navigate back to the Home screen
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (route) => false,
            );
          } else if (index == 1) {
            // Show "About" pop-up
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('About'),
                  content: Text('Produced by Ronak Pai\n\nThis app was created for educational purposes.'),
                  actions: [
                    TextButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
