part of universal_html;

abstract class Coordinates {
  num get accuracy;
  num get altitude;
  num get altitudeAccuracy;
  num get heading;
  num get latitude;
  num get longitude;
  num get speed;
}

abstract class Geolocation {
  Future<Geoposition> getCurrentPosition(
      {bool enableHighAccuracy, Duration timeout, Duration maximumAge});

  Stream<Geoposition> watchPosition(
      {bool enableHighAccuracy, Duration timeout, Duration maximumAge});
}

abstract class Geoposition {
  Coordinates get coords;

  int get timestamp;
}
