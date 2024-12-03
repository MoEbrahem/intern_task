// ignore_for_file: deprecated_member_use, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationApp extends StatefulWidget {
  @override
  _LocationAppState createState() => _LocationAppState();
}

class _LocationAppState extends State<LocationApp> {
  String _address = 'Address ';
  String _coordinates = 'Coordinates ';

  Future<void> _getLocationFromGoogleMapsLink(String link) async {
    try {
      final regex = RegExp(r'@(-?\d+\.\d+),(-?\d+\.\d+)');
      //  (-?[\d]*\.[\d]*),(-[\d]*\.[\d]*)
      final match = regex.firstMatch(link);
      if (match != null) {
        final latitude = double.parse(match.group(1)!);
        final longitude = double.parse(match.group(2)!);
        setState(() {
          _coordinates = 'Latitude: $latitude, Longitude: $longitude';
        });
        await _getAddressDetailsFromCoordinates(latitude, longitude);
      } else {
        setState(() {
          _address = 'Invalid Google Maps link';
        });
      }
    } catch (e) {
      setState(() {
        _address = 'Error: $e';
      });
    }
  }

  Future<void> _getAddressDetailsFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks.first;
      setState(() {
        _address =
            '${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
      });
    } catch (e) {
      setState(() {
        _address = 'Error: $e';
      });
    }
  }

  Future<void> _getLocationFromCoordinates(
      double latitude, double longitude) async {
    setState(() {
      _coordinates = 'Latitude: $latitude, Longitude: $longitude';
    });
    await _getAddressDetailsFromCoordinates(latitude, longitude);
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _coordinates =
            'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
      });
      await _getAddressDetailsFromCoordinates(
          position.latitude, position.longitude);
    } catch (e) {
      setState(() {
        _address = 'Error: $e';
        print(_address);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController googleMapsLinkController = TextEditingController();
    TextEditingController latitudeController = TextEditingController();
    TextEditingController longitudeController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Fetching'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: googleMapsLinkController,
                decoration: InputDecoration(
                  labelText: 'Google Maps Link',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _getLocationFromGoogleMapsLink(
                    googleMapsLinkController.text),
                child: const Text('Get Location from Link'),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: latitudeController,
                      decoration: InputDecoration(
                        labelText: 'Latitude',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: longitudeController,
                      decoration: InputDecoration(
                        labelText: 'Longitude',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _getLocationFromCoordinates(
                  double.tryParse(latitudeController.text) ?? 0.0,
                  double.tryParse(longitudeController.text) ?? 0.0,
                ),
                child: const Text('Get Location from Coordinates'),
              ),
            const SizedBox(height: 15,),
              ElevatedButton(
                onPressed: _getCurrentLocation,
                child: const Text('Get Current Location'),
              ),
              const SizedBox(height: 20),
              const Text('Coordinates:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(_coordinates),
              const SizedBox(height: 20),
              const Text('Address:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(_address),
            ],
          ),
        ),
      ),
    );
  }
}
