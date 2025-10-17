import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsView extends StatefulWidget {
  const MapsView({super.key});

  @override
  State<MapsView> createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEventLocations();
  }

  Future<void> _loadEventLocations() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('events')
          .get();

      final List<Marker> loadedMarkers = [];

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final lat = data['latitude'];
        final lng = data['longitude'];
        final title = data['title'] ?? 'Event';

        if (lat != null && lng != null && lat is num && lng is num) {
          loadedMarkers.add(
            Marker(
              markerId: MarkerId(doc.id),
              position: LatLng(lat.toDouble(), lng.toDouble()),
              infoWindow: InfoWindow(title: title),
            ),
          );
        }
      }

      setState(() {
        _markers
          ..clear()
          ..addAll(loadedMarkers);
        _isLoading = false;
      });

      if (_markers.isNotEmpty && _mapController != null) {
        _fitAllMarkers();
      }

      debugPrint(" Loaded ${_markers.length} event markers");
    } catch (e) {
      debugPrint(" Error loading event locations: $e");
      setState(() => _isLoading = false);
    }
  }

  Future<void> _fitAllMarkers() async {
    if (_markers.isEmpty || _mapController == null) return;

    LatLngBounds bounds = _createBounds(
      _markers.map((e) => e.position).toList(),
    );
    await _mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 50),
    );
  }

  LatLngBounds _createBounds(List<LatLng> positions) {
    double minLat = positions.first.latitude;
    double maxLat = positions.first.latitude;
    double minLng = positions.first.longitude;
    double maxLng = positions.first.longitude;

    for (LatLng pos in positions) {
      if (pos.latitude < minLat) minLat = pos.latitude;
      if (pos.latitude > maxLat) maxLat = pos.latitude;
      if (pos.longitude < minLng) minLng = pos.longitude;
      if (pos.longitude > maxLng) maxLng = pos.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Event Locations")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(30.0444, 31.2357),
                zoom: 6,
              ),
              onMapCreated: (controller) {
                _mapController = controller;
                if (_markers.isNotEmpty) _fitAllMarkers();
              },
              markers: _markers,
              zoomControlsEnabled: true,
              myLocationButtonEnabled: false,
            ),
    );
  }
}
