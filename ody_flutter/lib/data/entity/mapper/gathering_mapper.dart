import "package:ody_flutter/data/entity/gathering/gathering_request.dart";
import "package:ody_flutter/data/entity/gathering/gathering_response.dart";
import "package:ody_flutter/domain/model/new_gathering.dart";

extension ToData on NewGathering {
  GatheringRequest toEntity() => GatheringRequest(
        name: name,
        date: date,
        time: time,
        targetAddress: targetAddress,
        targetLatitude: targetLatitude,
        targetLongitude: targetLongitude,
      );
}

extension ToDomain on GatheringResponse {
  NewGathering toModel() => NewGathering(
        id: id,
        name: name,
        date: date,
        time: time,
        targetAddress: targetAddress,
        targetLatitude: targetLatitude,
        targetLongitude: targetLongitude,
        inviteCode: inviteCode,
      );
}
