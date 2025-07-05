import "package:ody_flutter/data/entity/gathering/location_response.dart";
import "package:ody_flutter/domain/model/location.dart";

extension LocationResponseToDomain on LocationResponse {
  List<LocationModel> toModel() =>
      documents
          ?.map(
            (document) => LocationModel(
              name: document.placeName,
              address: document.roadAddressName,
              latitude: double.parse(document.y ?? "0"),
              longitude: double.parse(document.x ?? "0"),
            ),
          )
          .toList() ??
      [];
}

extension LocationResponseDataToDomain on LocationResponseData {
  LocationModel toModel() => LocationModel(
        name: placeName,
        address: roadAddressName,
        latitude: double.parse(y ?? "0"),
        longitude: double.parse(x ?? "0"),
      );
}
