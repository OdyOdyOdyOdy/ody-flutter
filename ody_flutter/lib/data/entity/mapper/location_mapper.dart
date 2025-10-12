import "package:ody_flutter/data/entity/gathering/location_response.dart";
import "package:ody_flutter/data/entity/gathering/location_response_with_string.dart"
    hide LocationResponseDataWithStringCoord;
import "package:ody_flutter/domain/model/location.dart";

extension LocationResponseToDomain on LocationResponse {
  List<LocationModel> toModel() =>
      documents
          ?.map(
            (document) => LocationModel(
              name: document.placeName,
              address: document.addressName,
              latitude: document.y,
              longitude: document.x,
            ),
          )
          .toList() ??
      [];
}

extension LocationResponseDataToDomain on LocationResponseData {
  LocationModel toModel() => LocationModel(
        name: placeName,
        address: addressName,
        latitude: y,
        longitude: x,
      );
}

extension LocationResponseWithStringToDomain on LocationResponseWithString {
  List<LocationModel> toModel() =>
      documents
          ?.map(
            (document) => LocationModel(
              name: document.placeName,
              address: document.addressName,
              latitude: double.tryParse(document.y ?? "0"),
              longitude:
                  document.x != null ? double.tryParse(document.x!) : null,
            ),
          )
          .toList() ??
      [];
}

extension LocationResponseDataWithStringToDomain
    on LocationResponseDataWithStringCoord {
  LocationModel toModel() => LocationModel(
        name: placeName,
        address: addressName,
        latitude: double.tryParse(y ?? "0"),
        longitude: x != null ? double.tryParse(x!) : null,
      );
}
