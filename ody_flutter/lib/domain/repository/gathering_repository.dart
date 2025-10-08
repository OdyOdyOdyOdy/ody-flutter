import "package:dio/dio.dart";
import "package:ody_flutter/data/entity/gathering/enter_gathering_request.dart";
import "package:ody_flutter/data/entity/gathering/gathering_request.dart";
import "package:ody_flutter/domain/model/gathering.dart";
import "package:ody_flutter/domain/model/gathering_detail.dart";
import "package:ody_flutter/domain/model/new_gathering.dart";
import "package:ody_flutter/domain/model/nudge.dart";

abstract class GatheringRepository {
  Future<NewGathering> createGathering(GatheringRequest request);

  Future<GatheringDetail> fetchGathering(int id);

  Future<List<Gathering>> fetchGatherings();

  Future<bool> enterGathering(EnterGatheringRequest request);

  Future<bool> validateInvitationCode(String inviteCode);

  Future<void> exitMeeting(int meetingId);

  Future<Response<void>> postNudge(Nudge nudge);
}
