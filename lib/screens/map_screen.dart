import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  MapScreen({super.key, required this.currentLocation});
  Position? currentLocation;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(widget.currentLocation!.latitude,
                  widget.currentLocation!.longitude),
              initialZoom: 10.0,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                //subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 50,
                    height: 60,
                    point: LatLng(widget.currentLocation!.latitude,
                        widget.currentLocation!.longitude),
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
