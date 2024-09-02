class Location {
  final String id;

  final double lat;
  final double lon;
  final String name;
  final String country;
  final String? state;

  const Location({
    required this.id,
    required this.lat,
    required this.lon,
    required this.name,
    required this.country,
    required this.state,
  });

  @override
  String toString() {
    return "Location($name, $lat, $lon, $country, $state)";
  }
}
