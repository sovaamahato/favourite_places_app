import 'package:favourite_places_app/components/colors.dart';
import 'package:favourite_places_app/providers/user_places.dart';
import 'package:favourite_places_app/screens/add_place.dart';
import 'package:favourite_places_app/screens/my_drawer.dart';
import 'package:favourite_places_app/widgets/places.list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import 'developer_screen.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});
  @override
  ConsumerState<PlacesScreen> createState() {
    return _placesScreenState();
  }
}

class _placesScreenState extends ConsumerState<PlacesScreen>
    with SingleTickerProviderStateMixin {
  late Future<void> _placesFuture;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _placesFuture = ref.read(userPlaceProvider.notifier).loadPlace();

    //for animation bus

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(-1, 0.0),
      end: Offset(0.9, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    //for looping effect
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Animation completed, reset to start from the left again
        _controller.reset();
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final userPlaces = ref.watch(userPlaceProvider);

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background2,
        title: Text(
          "my Places",
          style: TextStyle(color: DeepPurple),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const AddPlaceScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.add_a_photo_outlined,
              color: DeepPurple,
            ),
          ),
        ],
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: Container(
        height: 40,
        width: double.infinity,
        child: Listener(
          onPointerUp: (_) {
            // Manually reset the animation when tapping on the screen
            _controller.reset();
            _controller.forward();
          },
          child: SlideTransition(
            position: _offsetAnimation,
            child: LottieBuilder.asset(
              "assets/animation3.json",
              width: double.infinity,
              height: 40,
              repeat: false,
            ),
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: _placesFuture,
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: const CircularProgressIndicator(),
                      )
                    : PlacesList(places: userPlaces),
          )),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
