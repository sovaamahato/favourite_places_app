import 'package:favourite_places_app/screens/places_details.dart';
import 'package:flutter/material.dart';

import '../models.dart';
import '../providers/user_places.dart';

class PlacesList extends StatelessWidget {
  final List<Place> places;
  const PlacesList({super.key, required this.places});

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
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
        itemCount: places.length,
        itemBuilder: (ctx, index) => ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: FileImage(places[index].image),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => PlaceDetailScreen(
                      place: places[index],
                    ),
                  ),
                );
              },
              subtitle: Text(
                places[index].location.address,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              title: Text(
                places[index].title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {},
              ),
            ));
  }
}
