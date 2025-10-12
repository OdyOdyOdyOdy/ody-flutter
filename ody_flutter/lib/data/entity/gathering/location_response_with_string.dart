class LocationResponseWithString {
  LocationResponseWithString(this.documents);

  factory LocationResponseWithString.fromJson(Map<String, dynamic> json) =>
      LocationResponseWithString(
        (json["documents"] as List<dynamic>?)
            ?.map(
              (e) => LocationResponseDataWithStringCoord.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList(),
      );

  List<LocationResponseDataWithStringCoord>? documents;
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
