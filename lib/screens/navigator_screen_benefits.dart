import 'package:flutter/material.dart';
import 'package:veteran_connect/screens/benefits_list_screen.dart';
import 'package:veteran_connect/screens/home_screen.dart';
import 'package:veteran_connect/screens/quiz_screen.dart';

class BenefitsNavigatorScreen extends StatelessWidget {
  const BenefitsNavigatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.green, // Match the HomeScreen app bar color
        centerTitle: true, // Center the title
        title: Text(
          'Benefits', 
          style: TextStyle(
            fontSize: 40,
            fontFamily: 'Anton', // Use the same font for consistency
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade700, Colors.green.shade300], // Match gradient background
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 35), // Space from the top
              Text(
                'Take Eligibility Quiz',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold, // Text size for the heading
                ),
              ),
              SizedBox(height: 20.0), // Space below the text
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
                    'Start Quiz',
                    style: TextStyle(
                      fontSize: 30, // Match the button text size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    // Code for eligibility quiz
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuizScreen())
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Navigating to Eligibility Quiz')),
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
          // Handle tab navigation here
          if (index == 0) {
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
          } else if (index == 2) {
            // Implement navigation to Settings page if needed
          }
        },
      ),
    );
  }
}
