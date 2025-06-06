import "package:ody_flutter/data/entity/gathering/location_response.dart";
import "package:ody_flutter/domain/model/location.dart";

extension ToDomain on LocationResponse {
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
