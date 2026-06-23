import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class FlutterMapZoomButtons extends StatelessWidget {
  const FlutterMapZoomButtons({
    super.key,
    this.minZoom = 4,
    this.maxZoom = 19,
    this.mini = true,
    this.padding = 10,
    this.alignment = Alignment.bottomRight,
  });

  final double minZoom;
  final double maxZoom;
  final bool mini;
  final double padding;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final mapController = MapController.of(context);
    final camera = MapCamera.of(context);
    final zoom = camera.zoom;

    return Align(
      alignment: alignment,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              heroTag: 'map_zoom_in',
              mini: mini,
              onPressed: zoom >= maxZoom
                  ? null
                  : () {
                      final nextZoom = (zoom + 1).clamp(minZoom, maxZoom);
                      mapController.move(camera.center, nextZoom);
                    },
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 8),
            FloatingActionButton(
              heroTag: 'map_zoom_out',
              mini: mini,
              onPressed: zoom <= minZoom
                  ? null
                  : () {
                      final nextZoom = (zoom - 1).clamp(minZoom, maxZoom);
                      mapController.move(camera.center, nextZoom);
                    },
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}
