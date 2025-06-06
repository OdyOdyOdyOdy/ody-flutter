class LocationModel {
  LocationModel({
    required this.name,
    required this.address,
    required this.longitude,
    required this.latitude,
  });

  factory LocationModel.init() => LocationModel(
        name: null,
        address: null,
        longitude: null,
        latitude: null,
      );

  final String? name;
  final String? address;
  final double? longitude;
  final double? latitude;
}
