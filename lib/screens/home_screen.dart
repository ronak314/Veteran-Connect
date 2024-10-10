import 'package:flutter/material.dart';
import 'telehealth_screen.dart';
import 'navigator_screen_benefits.dart';

double buttonSize = 30;

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.green, // Set the background color to green
        centerTitle: true, // Center the title
        title: Text(
          'Veteran Connect',
          style: TextStyle(
            fontSize: 50,
            fontFamily: 'Anton', // Use the Anton font for the title
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
            mainAxisAlignment: MainAxisAlignment.start, // Align items to the start
            children: <Widget>[
              SizedBox(height: 5), // Add space from the top
              Image.asset(
                'assets/images/homepagestock.png', // Replace with your asset path
                height: 340,
              ),
              SizedBox(height: 20.0), // Space between the image and buttons
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
                    'Telehealth Access',
                    style: TextStyle(
                      fontSize: buttonSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TelehealthScreen()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Navigating to Telehealth Access')),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
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
                    'Benefits Navigator',
                    style: TextStyle(
                      fontSize: buttonSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BenefitsNavigatorScreen()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Navigating to Benefits Navigator')),
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
