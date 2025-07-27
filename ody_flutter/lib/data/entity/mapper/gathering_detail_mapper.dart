import "package:ody_flutter/data/entity/gathering/gathering_detail_response.dart" as response;
import "package:ody_flutter/data/entity/gathering/gathering_detail_response.dart";
import "package:ody_flutter/domain/model/gathering_detail.dart";

extension ToDomain on response.GatheringDetailResponse {
  GatheringDetail toModel() => GatheringDetail(
    id: id,
    name: name,
    date: date,
    time: time,
    departureTime: departureTime,
    routeTime: routeTime,
    originAddress: originAddress,
    targetAddress: targetAddress,
    targetLatitude: targetLatitude,
    targetLongitude: targetLongitude,
    mateCount: mateCount,
    mates: mates?.map((e) => e.toModel()).toList(),
    inviteCode: inviteCode,
  );
}

extension MatesToDomain on ResponseMates {
  Mates toModel() => Mates(
    nickname: nickname,
    imageUrl: imageUrl,
  );
}
