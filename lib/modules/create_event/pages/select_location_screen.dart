import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({Key? key}) : super(key: key);

  @override
  _SelectLocationScreenState createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  LatLng? _selectedPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Event Location'),
        actions: [
          if (_selectedPosition != null)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                Navigator.pop(context, _selectedPosition);
              },
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(30.046684585217108, 31.236830168953464),
          zoom: 10,
        ),
        onTap: (LatLng position) {
          setState(() {
            _selectedPosition = position;
          });
        },
        markers: _selectedPosition == null
            ? {}
            : {
                Marker(
                  markerId: MarkerId('selected'),
                  position: _selectedPosition!,
                ),
              },
      ),
    );
  }
}
