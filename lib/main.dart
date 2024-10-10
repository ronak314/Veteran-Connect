import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';


void main() {
 runApp(VeteranConnectApp());
}


class VeteranConnectApp extends StatelessWidget {
 const VeteranConnectApp({super.key});


 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'Veteran Connect',
     theme: ThemeData(
       primarySwatch: Colors.green,
       fontFamily: 'KayPhoDu', // Set the default font for the entire app
     ),
     home: HomeScreen(),
   );
 }
}





