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
    this.addressName,
    this.x,
    this.y,
  );

  factory LocationResponseData.fromJson(Map<String, dynamic> json) =>
      LocationResponseData(
        json["place_name"] as String?,
        json["address_name"] as String?,
        json["x"] as double?,
        json["y"] as double?,
      );

  String? placeName;
  String? addressName;
  double? x;
  double? y;
}

class LocationResponseDataWithStringCoord {
  LocationResponseDataWithStringCoord(
    this.placeName,
    this.addressName,
    this.x,
    this.y,
  );

  factory LocationResponseDataWithStringCoord.fromJson(
    Map<String, dynamic> json,
  ) =>
      LocationResponseDataWithStringCoord(
        json["place_name"] as String?,
        json["address_name"] as String?,
        json["x"] as String?,
        json["y"] as String?,
      );

  String? placeName;
  String? addressName;
  String? x;
  String? y;
}
