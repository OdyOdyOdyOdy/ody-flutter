import "package:ody_flutter/data/entity/gathering/gathering_request.dart";
import "package:ody_flutter/domain/model/gathering.dart";
import "package:ody_flutter/domain/model/gathering2.dart";

abstract class GatheringRepository {
  Future<Gathering> createGathering(GatheringRequest request);
  Future<Gathering> fetchGathering(int id);
  Future<List<Gathering2>> fetchGatherings();
}
