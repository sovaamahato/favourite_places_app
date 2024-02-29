import 'package:favourite_places_app/screens/places_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models.dart';
import '../providers/user_places.dart';

class PlacesList extends ConsumerStatefulWidget {
  final List<Place> places;
  const PlacesList({super.key, required this.places});

  @override
  ConsumerState<PlacesList> createState() => _PlacesListState();
}

class _PlacesListState extends ConsumerState<PlacesList> {
  @override
  Widget build(BuildContext context) {
    if (widget.places.isEmpty) {
      return Center(
        child: Text(
          "No places added yet",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      );
    }
    return ListView.builder(
      itemCount: widget.places.length,
      itemBuilder: (ctx, index) => InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => PlaceDetailScreen(
                place: widget.places[index],
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 160,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: Image(
                    isAntiAlias: true,
                    fit: BoxFit.cover,
                    image: FileImage(widget.places[index].image),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.places[index].title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: Colors.green,
                            ),
                            Text(
                              widget.places[index].location.address,
                              // style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              //     color: Theme.of(context).colorScheme.onBackground),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            size: 20,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            _deletePlace(context, widget.places[index].id);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
      // ListTile(
      //   leading: CircleAvatar(
      //     radius: 20,
      //     backgroundImage: FileImage(widget.places[index].image),
      //   ),
      //   onTap: () {
      //     Navigator.of(context).push(
      //       MaterialPageRoute(
      //         builder: (ctx) => PlaceDetailScreen(
      //           place: widget.places[index],
      //         ),
      //       ),
      //     );
      //   },
      //   subtitle: Text(
      //     widget.places[index].location.address,
      //     style: Theme.of(context)
      //         .textTheme
      //         .bodySmall!
      //         .copyWith(color: Theme.of(context).colorScheme.onBackground),
      //   ),
      //   title: Text(
      //     widget.places[index].title,
      //     style: Theme.of(context)
      //         .textTheme
      //         .titleMedium!
      //         .copyWith(color: Theme.of(context).colorScheme.onBackground),
      //   ),
      //   trailing: IconButton(
      //     icon: Icon(Icons.delete),
      //     onPressed: () {
      //       _deletePlace(context, widget.places[index].id);
      //     },
      //   ),
      // ),
    );
  }

  void _deletePlace(BuildContext context, String placeId) {
    // Assuming you have access to your provider reference
    ref.read(userPlaceProvider.notifier).deletePlace(placeId);

    // Update the local 'places' list
    // Make sure to call the appropriate method based on your actual implementation
    ref.read(userPlaceProvider.notifier).removePlaceById(placeId);

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Place deleted"),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
