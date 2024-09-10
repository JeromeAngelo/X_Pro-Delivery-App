import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:x_pro_delivery_app/provider/timeline_provider.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  var isGettingLocation = false;
  LatLng currentLocation = const LatLng(15.058583416335447, 120.77471934782055);
  MapController mapController = MapController();

  void _getLocation() async {
    setState(() {
      isGettingLocation = true;
    });

    await Future.delayed(const Duration(milliseconds: 200));

    setState(() {
      currentLocation;
      isGettingLocation = false;
    });

    mapController.move(currentLocation, 13);

    _showMapOptions(context);
  }

  void _showMapOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Open Location'),
          content: const Text('Choose an app to open the location'),
          actions: <Widget>[
            TextButton(
              child: const Text('Google Maps'),
              onPressed: () {
                Navigator.of(context).pop();
                _launchMaps('google', currentLocation.latitude,
                    currentLocation.longitude);
              },
            ),
            TextButton(
              child: const Text('Waze'),
              onPressed: () {
                Navigator.of(context).pop();
                _launchMaps('waze', currentLocation.latitude,
                    currentLocation.longitude);
              },
            ),
          ],
        );
      },
    );
  }

  void _launchMaps(String app, double lat, double lng) async {
    String url;
    if (app == 'google') {
      url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    } else {
      url = 'https://waze.com/ul?ll=$lat,$lng&navigate=yes';
    }

    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not launch $url'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: 300,
              child: FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  initialCenter: currentLocation,
                  initialZoom: 18,
                  interactionOptions: const InteractionOptions(
                    flags: InteractiveFlag.pinchZoom,
                  ),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://mt1.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                    additionalOptions: const {
                      'apiKey': 'AIzaSyB-9CfMDDgQFEW3YTCN5xR62Cs9oTmJc1k',
                    },
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: currentLocation,
                        child: GestureDetector(
                          onTap: _getLocation,
                          child: Icon(
                            Icons.person_pin_circle,
                            color: Theme.of(context).colorScheme.primary,
                            size: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      onTap: () {
                        Provider.of<TimelineProvider>(context, listen: false)
                            .toggleMapVisibility();
                      },
                      child: const Icon(Icons.minimize_outlined),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
