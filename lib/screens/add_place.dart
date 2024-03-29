import 'dart:io';

import 'package:favourite_places_app/components/colors.dart';
import 'package:favourite_places_app/models.dart';
import 'package:favourite_places_app/providers/user_places.dart';
import 'package:favourite_places_app/widgets/image_input.dart';
import 'package:favourite_places_app/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  //controllers
  final _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

//to save the place entered
  void _savePlace() {
    final enteredTitle = _titleController.text;
    if (enteredTitle.isEmpty ||
        _selectedImage == null ||
        _selectedLocation == null) {
      return;
    }
    ref
        .read(userPlaceProvider.notifier)
        .addPlace(enteredTitle, _selectedImage!, _selectedLocation!);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background2,
        elevation: 0,
        title: Text(
          "Add New",
          style: TextStyle(color: DeepPurple),
        ),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              TextField(
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: " Title",
                ),
              ),
              const SizedBox(
                height: 17,
              ),
              //image input

              ImageInput(
                onPickImage: (image) {
                  _selectedImage = image;
                },
              ),
              const SizedBox(
                height: 17,
              ),
              //location input
              LocationInput(
                onSelectLocation: (location) {
                  _selectedLocation = location;
                },
              ),
              InkWell(
                onTap: _savePlace,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
                  decoration: BoxDecoration(
                      color: background2,
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    "Add Place",
                    style: TextStyle(color: DeepPurple, fontSize: 19),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
