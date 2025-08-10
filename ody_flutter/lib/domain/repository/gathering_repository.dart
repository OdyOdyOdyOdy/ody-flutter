import "package:ody_flutter/data/entity/gathering/gathering_request.dart";
import "package:ody_flutter/domain/model/gathering.dart";
import "package:ody_flutter/domain/model/gathering2.dart";
import "package:ody_flutter/domain/model/gathering_detail.dart";

abstract class GatheringRepository {
  Future<Gathering> createGathering(GatheringRequest request);

  Future<GatheringDetail> fetchGathering(int id);

  Future<List<Gathering2>> fetchGatherings();

  Future<void> exitMeeting(int meetingId);
}
