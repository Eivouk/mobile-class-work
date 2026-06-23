import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'zoombuttons_plugin.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Open Street Map in Flutter',
          style: TextStyle(fontSize: 22),
        ),
      ),
      body: getMap(),
    );
  }

  Widget getMap() {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(2.8960, 101.7040),
        initialZoom: 12,
        interactionOptions: InteractionOptions(
          flags: ~InteractiveFlag.doubleTapZoom,
        ),
      ),
      children: [
        TileLayer(
          // OSM 官方服务器会拦截大量 flutter_map 请求，改用 Carto（同样基于 OSM 数据）
          urlTemplate:
              'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
          subdomains: const ['a', 'b', 'c', 'd'],
          userAgentPackageName: 'dev.chapter9.mapapp.study',
        ),
        MarkerLayer(
          markers: [
            _buildMarker(const LatLng(2.8327038, 101.7027641)),
            _buildMarker(const LatLng(2.9691535, 101.7124737)),
            _buildMarker(const LatLng(2.8229771, 101.6954209)),
          ],
        ),
        const FlutterMapZoomButtons(
          minZoom: 4,
          maxZoom: 19,
          mini: true,
          padding: 10,
          alignment: Alignment.bottomRight,
        ),
      ],
    );
  }

  Marker _buildMarker(LatLng point) {
    return Marker(
      point: point,
      width: 60,
      height: 60,
      alignment: Alignment.centerLeft,
      child: const Icon(Icons.location_pin, size: 60, color: Colors.red),
    );
  }
}
