import 'package:flutter/material.dart';
import 'package:veteran_connect/screens/home_screen.dart';

class BenefitsListScreen extends StatelessWidget {
  const BenefitsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List of benefits and their qualifications
    final List<Map<String, String>> benefits = [
      {
        'title': 'Veteran Benefits',
        'qualification': 'Eligibility based on service in the armed forces.'
      },
      {
        'title': 'Youth Benefits',
        'qualification': 'For individuals under 30 years old.'
      },
      {
        'title': 'Mid-Life Benefits',
        'qualification': 'For individuals between 30 to 50 years old.'
      },
      {
        'title': 'Senior Benefits',
        'qualification': 'For individuals over 50 years old.'
      },
      {
        'title': 'Disability Benefits',
        'qualification': 'Available for veterans with service-connected disabilities.'
      },
      {
        'title': 'Combat Benefits',
        'qualification': 'For veterans who served in combat zones.'
      },
      {
        'title': 'Retirement Benefits',
        'qualification': 'For veterans with qualifying years of service.'
      },
      {
        'title': 'Employment Benefits',
        'qualification': 'Includes job training and placement services.'
      },
      {
        'title': 'Dependent Benefits',
        'qualification': 'For dependents of veterans.'
      },
      {
        'title': 'VA Benefits',
        'qualification': 'Benefits offered by the Department of Veterans Affairs.'
      },
      {
        'title': 'Higher Education Benefits',
        'qualification': 'For veterans seeking higher education funding.'
      },
    ];

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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: benefits.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        benefits[index]['title']!,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        benefits[index]['qualification']!,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              );
            },
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
