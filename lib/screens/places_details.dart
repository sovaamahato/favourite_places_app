import 'package:favourite_places_app/components/colors.dart';
import 'package:favourite_places_app/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../models.dart';

class PlaceDetailScreen extends StatelessWidget {
  final Place place;
  const PlaceDetailScreen({super.key, required this.place});

//map images ko lagi
  Widget buildMapPreview() {
    return GestureDetector(
      child: Container(
        child: FlutterMap(
          options: MapOptions(
            initialCenter:
                LatLng(place.location.latitude, place.location.longitude),
            initialZoom: 10.0,
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              //subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  width: 50,
                  height: 60,
                  point:
                      LatLng(place.location.latitude, place.location.longitude),
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Widget preview = buildMapPreview();
    return Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          backgroundColor: background2,
          title: Text(
            place.title,
          ),
        ),
        body: Stack(
          children: [
            //place pic-------------------------------
            Image.file(
              place.image,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            //map image and address------------------------------
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //address-------------
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          decoration: const BoxDecoration(),
                          child: Text(
                            place.location.address,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: DeepPurple),
                          ),
                        ),
                      ),
                      //map image----------------------------------
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => MapScreen(
                                    currentLocation: place.location,
                                    isSelecting: false,
                                  )));
                        },
                        child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  DeepPurple,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: const Row(
                              children: [
                                Text(
                                  "See location on map",
                                  style: TextStyle(
                                      fontSize: 18, letterSpacing: 1.3),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.location_on,
                                  color: Color.fromARGB(255, 145, 39, 31),
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                ))
          ],
        ));
  }
}
