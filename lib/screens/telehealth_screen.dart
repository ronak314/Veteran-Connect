import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math'; // Import the dart:math library
import 'package:geocoding/geocoding.dart'; // Import the geocoding package
import 'dart:convert'; // Import for JSON parsing
import 'package:flutter/services.dart'; // Import for loading assets
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

class VAFacility {
  final String name;
  final double latitude;
  final double longitude;

  VAFacility(this.name, this.latitude, this.longitude);
}

class TelehealthScreen extends StatefulWidget {
  @override
  _TelehealthScreenState createState() => _TelehealthScreenState();
}

class _TelehealthScreenState extends State<TelehealthScreen> {
  Position? _currentPosition;
  List<VAFacility> vaFacilities = [];

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
    loadFacilities(); // Load facilities when initializing the state
  }

  Future<void> loadFacilities() async {
    String jsonString = await rootBundle.loadString('assets/va_facilities.json'); // Load the JSON file
    final List<dynamic> jsonResponse = json.decode(jsonString); // Decode the JSON
    setState(() {
      vaFacilities = jsonResponse.map((facility) => VAFacility(
        facility['name'],
        facility['latitude'],
        facility['longitude']
      )).toList(); // Map JSON data to List<VAFacility>
    });
  }

  Future<void> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied');
      return;
    }
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      print('Location permissions are allowed');
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {}); // Update the UI to reflect the current position
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  double haversine(double lat1, double lon1, double lat2, double lon2) {
    const R = 3958.8; // Radius of the earth in miles
    final dLat = (lat2 - lat1) * (pi / 180); // Use 'pi' from dart:math
    final dLon = (lon2 - lon1) * (pi / 180); // Use 'pi' from dart:math
    final a = (sin(dLat / 2) * sin(dLat / 2)) +
              (cos(lat1 * (pi / 180)) * cos(lat2 * (pi / 180)) * sin(dLon / 2) * sin(dLon / 2));
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c; // Distance in miles
  }

  List<MapEntry<VAFacility, double>> findNearestFacilities() {
    if (_currentPosition == null) return [];
    
    List<MapEntry<VAFacility, double>> distances = vaFacilities.map((facility) {
      double distance = haversine(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        facility.latitude,
        facility.longitude,
      );
      return MapEntry(facility, distance);
    }).toList();

    distances.sort((a, b) => a.value.compareTo(b.value)); // Sort by distance
    return distances.take(5).toList(); // Get top 5 nearest facilities
  }

  Future<String> getAddress(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        return '${placemark.street}, ${placemark.locality}, ${placemark.country}';
      }
    } catch (e) {
      print('Error getting address: $e');
    }
    return 'Address not found';
  }

  Future<void> openMaps(double latitude, double longitude) async {
    // Create a Google Maps URL with the coordinates
    String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not open Google Maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          'Telehealth',
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
        child: _currentPosition == null
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Nearest VA Facilities',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Set color to black
                      ),
                      textAlign: TextAlign.center, // Center the text
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<MapEntry<VAFacility, String>>>(
                      future: Future.wait(findNearestFacilities().map((entry) async {
                        String address = await getAddress(entry.key.latitude, entry.key.longitude);
                        return MapEntry(entry.key, address); // Keep the address
                      })),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else {
                          final facilitiesWithAddresses = snapshot.data!;
                          return ListView.builder(
                            itemCount: facilitiesWithAddresses.length,
                            itemBuilder: (context, index) {
                              final facility = facilitiesWithAddresses[index].key;
                              final address = facilitiesWithAddresses[index].value;
                              final distance = haversine(
                                _currentPosition!.latitude,
                                _currentPosition!.longitude,
                                facility.latitude,
                                facility.longitude,
                              );

                              return Card(
                                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                child: ListTile(
                                  title: Text(facility.name),
                                  subtitle: Text('${distance.toStringAsFixed(2)} miles away\n$address'), // Display the address in miles
                                  trailing: IconButton(
                                    icon: Icon(Icons.directions),
                                    onPressed: () => openMaps(facility.latitude, facility.longitude), // Use the lat and long here
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
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
            Navigator.pop(context); // Go back to the previous screen
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
