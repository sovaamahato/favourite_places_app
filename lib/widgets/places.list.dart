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
  // void _deletePlace(String placeId) {
  //   ref.read(userPlaceProvider.notifier).deletePlace(placeId);
  //   // Optionally, you can add code to navigate back or update the UI after deletion.
  //   // For example, you might want to pop the current screen:
  //   // Navigator.of(context).pop();
  // }

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
        itemBuilder: (ctx, index) => ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: FileImage(widget.places[index].image),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => PlaceDetailScreen(
                      place: widget.places[index],
                    ),
                  ),
                );
              },
              subtitle: Text(
                widget.places[index].location.address,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              title: Text(
                widget.places[index].title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _deletePlace(context, widget.places[index].id);
                },
              ),
            ));
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
