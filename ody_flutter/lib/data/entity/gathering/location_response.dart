class LocationResponse {
  LocationResponse(this.documents);

  factory LocationResponse.fromJson(Map<String, dynamic> json) =>
      LocationResponse(
        (json["documents"] as List<dynamic>?)
            ?.map(
              (e) => LocationResponseData.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );

  List<LocationResponseData>? documents;
}

class LocationResponseData {
  LocationResponseData(
    this.placeName,
    this.roadAddressName,
    this.x,
    this.y,
  );
  factory LocationResponseData.fromJson(Map<String, dynamic> json) =>
      LocationResponseData(
        json["place_name"],
        json["road_address_name"],
        json["x"],
        json["y"],
      );

  String? placeName;
  String? roadAddressName;
  String? x;
  String? y;
}
