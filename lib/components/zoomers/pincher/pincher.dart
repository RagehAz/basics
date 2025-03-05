import 'package:flutter/material.dart';
import 'package:pinch_zoom_release_unzoom/pinch_zoom_release_unzoom.dart';

class Pincher extends StatelessWidget {
  // --------------------------------------------------------------------------
    const Pincher({
        required this.child,
        this.maxScale = 5,
        this.minScale = 0.5,
        super.key
    });
    // --------------------
    final double maxScale;
    final double minScale;
    final Widget child;
    // --------------------------------------------------------------------------
    @override
    Widget build(BuildContext context) {
        // --------------------
        return PinchZoomReleaseUnzoomWidget(
            maxScale: 5,
            minScale: 0.5,

            // fingersRequiredToPinch: ,
            // boundaryMargin: ,
            // clipBehavior: ,
            // key: ,
            // log: ,
            // maxOverlayOpacity: ,
            // overlayColor: ,
            // resetCurve: ,
            // resetDuration: ,
            // rootOverlay: ,
            // twoFingersOff: (){},
            // twoFingersOn: (){},
            // useOverlay: ,
            // zoomChild: ,
            child: child,
        );
        // --------------------
    }
    // --------------------------------------------------------------------------
}
