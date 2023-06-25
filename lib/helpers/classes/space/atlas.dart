import 'dart:math' as math;
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:basics/helpers/classes/strings/text_mod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Atlas {
  // -----------------------------------------------------------------------------

  const Atlas();

  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  static dynamic cipherGeoPoint({
    required GeoPoint? point,
    required bool toJSON,
  }) {

    dynamic _output;

    if (point != null) {

      if (toJSON == true) {
        final String lat = '${point.latitude}';
        final String lng = '${point.longitude}';
        _output = '${lat}_$lng';
      }

      else {
        _output = point;
      }

    }

    return _output;
  }
  // --------------------
  static GeoPoint? decipherGeoPoint({
    required dynamic point,
    required bool fromJSON,
  }) {
    GeoPoint? _output;

    if (point != null) {
      if (fromJSON == true) {

        final String? _latString = TextMod.removeTextAfterLastSpecialCharacter(
            text: point,
            specialCharacter: '_',
        );
        final double? _lat = Numeric.transformStringToDouble(_latString);
        final String? _lngString = TextMod.removeTextBeforeFirstSpecialCharacter(
            text: point,
            specialCharacter: '_',
        );
        final double? _lng = Numeric.transformStringToDouble(_lngString);

        if (_lat != null && _lng != null) {
          _output = GeoPoint(_lat, _lng);
        }

      }

      else {
        _output = point;
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DUMMIES

  // --------------------
  static GeoPoint dummyLocation() {
    return const GeoPoint(29.979174, 31.134264);
  }
  // -----------------------------------------------------------------------------

  /// HAVERSINE

  // --------------------
  /// TESTED : WORKS PERFECT
  static double haversineGeoPoints({
    required GeoPoint? pointA,
    required GeoPoint? pointB,
  }){

    double _distance = 0;

    if (pointA != null && pointB != null){

      final double _latA = pointA.latitude;
      final double _latB = pointB.latitude;

      final double _lngA = pointA.longitude;
      final double _lngB = pointB.longitude;

      final double? _dRadLat = Numeric.degreeToRadian(_latB - _latA);
      final double? _dRadLng = Numeric.degreeToRadian(_lngB - _lngA);

      final double? _radLatA = Numeric.degreeToRadian(_latA);
      final double? _radLatB = Numeric.degreeToRadian(_latB);

      if (_dRadLat != null && _dRadLng != null && _radLatA != null && _radLatB != null) {
        final num _a =
            math.pow(math.sin(_dRadLat / 2), 2)
                +
            math.pow(math.sin(_dRadLng / 2), 2) * math.cos(_radLatA) * math.cos(_radLatB);

        final double _c = 2 * math.asin(math.sqrt(_a));

        /// EARTH RADIUS IN KM
        const double _r = 6372.8; // In kilometers

        _distance = _r * _c;
      }
    }

    return _distance;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogGeoPoint({
    required GeoPoint? point,
    String invoker = 'GeoPoint',
  }){
    blog('$invoker : lat : ${point?.latitude} : lng : ${point?.longitude}');
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkCoordinateIsGood(double? coordinate) {
    return coordinate != null && coordinate >= -90 && coordinate <= 90;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkPointsAreIdentical({
    required GeoPoint? point1,
    required GeoPoint? point2,
  }){
    bool _identical = false;

    if (point1 == null && point2 == null){
      _identical = true;
    }

    else if (point1 != null && point2 != null){

      if (
          point1.latitude == point2.latitude &&
          point1.longitude == point2.longitude
      ){
        _identical = true;
      }

    }

    return _identical;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
    static bool objectIsGeoPoint(dynamic object) {
    return object?.runtimeType == GeoPoint;
  }
  // --------------------
}

/*
// ----------------------------------------------------------------------
const String GOOGLE_API_KEY = '';
// ----------------------------------------------------------------------
int zoom = 15;
String size = '600x1044';
String mapType = 'satellite'; //roadmap // satellite // hybrid // terrain
String color1 = 'red%7C';
String label = 'B%7C';
// ----------------------------------------------------------------------

  String generateLocationPreviewImage(double latitude, double longitude){
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=$zoom&size=$size&maptype=$mapType&markers=color:${color1}label:$label$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  Future<String> getPlaceAddressFromGoogleMaps({required double lat, required double lng}) async {
    final String _url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    Uri _uri = Uri.parse(_url);
    final http.Response response = await http.get(_uri);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }

  String getStaticMapImage(BuildContext context, double latitude, double longitude){

    int     zoomValue       = 15;
    int     widthValue      = (Scale.superScreenWidth(context) * 0.73).toInt();
    int     heightValue     = (widthValue * 1.74).toInt();
    double  scaleValue      = 1;
    String  mapTypeValue    = 'hybrid';
    String  iconPath        = 'https://i.ibb.co/f2mv77f/gi-flyer-pin-png.png|$latitude,$longitude';

    // String  center          = 'center=$latitude,$longitude';
    String  zoom            = 'zoom=$zoomValue';
    String  size            = '&size=${widthValue}x$heightValue';
    String  scale           = scaleValue == 1 ? '' : '&scale=$scaleValue';
    String  mapType         = '&maptype=$mapTypeValue';
    String  markers         = '&markers=icon:$iconPath';
    String  key             = '&key=$GOOGLE_API_KEY';
    String  parameters      = '$zoom$size$scale$mapType$markers$key';

    // https://staticmapmaker.com/google/
    // this website is awesome to test if the url custom marker link works or not
    // and used this https://imgbb.com/ to create the URL for the flyer_pin custom marker

    // this documentation explains all shits
    // https://developers.google.com/maps/documentation/maps-static/start

    //when we have several markers on the screen and want the map to assign
    // dynamically the perfect zoom for them

    // Implicit Positioning of the Map
    // Normally, you need to specify center and zoom URL parameters to define
    // the location and zoom level of your generated map. However, if you supply
    // markers, path, or visible parameters, you can instead let the Maps Static
    // API determine the correct center and zoom level implicitly, based on
    // evaluation of the position of these elements.
    // If supplying two or more elements, the Maps Static API will determine a
    // proper center and zoom level, providing generous margins for the elements
    // contained. The example below displays a map containing San Francisco,
    // Oakland, and San Jose, CA:
    // https://maps.googleapis.com/maps/api/staticmap?size=512x512&maptype=roadmap\
    // &markers=size:mid%7Ccolor:red%7CSan+Francisco,CA%7COakland,CA%7CSan+Jose,CA&key=YOUR_API_KEY

    return 'https://maps.googleapis.com/maps/api/staticmap?$parameters';
  }

// ----------------------------------------------------------------------
Completer<GoogleMapController> _controller = Completer();
Position loadedPosition;
Position currentUserPosition;
BitmapDescriptor customMarker;
LatLng aMarkerLatLng;
var aMarker;
// // ----------------------------------------------------------------------
Future<void> _goToTheLake() async {
  final GoogleMapController controller = await _controller.future;
  controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
}
// ----------------------------------------------------------------------
 */
