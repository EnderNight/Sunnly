class Location {
  final String id;
  final DateTime delta;

  final double lat;
  final double lon;
  final String name;
  final String requestName;
  final String country;
  final String? state;

  const Location({
    required this.id,
    required this.delta,
    required this.lat,
    required this.lon,
    required this.name,
    required this.country,
    required this.state,
    required this.requestName,
  });

  @override
  String toString() {
    return "Location($name, $lat, $lon, $country, $state, $delta)";
  }
}
