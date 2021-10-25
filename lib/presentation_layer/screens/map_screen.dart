import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/my_colors.dart';
import 'package:flutter_maps/helpers/location_helper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {



  static Position? position;
  final Completer<GoogleMapController> _mapController = Completer();
  static final CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
    zoom: 17.0,
    tilt: 0.0,
    target: LatLng(position!.latitude, position!.longitude),
  );

  /// TODO : Go to current position
  Future<void> _goToCurrentPosition() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(_myCurrentLocationCameraPosition));
  }

  /// TODO : Get My Current position
  Future<void> getMyCurrentLocation() async {
    await LocationHelper.getPosition();

    position = await Geolocator.getCurrentPosition().whenComplete(
      () => setState(() {}),
    );
  }

  @override
  void initState() {
    super.initState();
    getMyCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          position != null
              ? GoogleMap(
                  mapType: MapType.normal,
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  initialCameraPosition: _myCurrentLocationCameraPosition,
                  onMapCreated: (GoogleMapController controller) {
                    _mapController.complete(controller);
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ],
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
        child: FloatingActionButton(
          backgroundColor: MyColors.myBlue,
          onPressed: _goToCurrentPosition,
          child: const Icon(
            Icons.place,
            color: Colors.white,
          ),
        ),
      ),
    );
  }


}
