import "package:ody_flutter/data/entity/gathering/gathering_request.dart";
import "package:ody_flutter/domain/model/gathering.dart";

abstract class GatheringRepository {
  Future<Gathering> createGathering(GatheringRequest request);
  Future<Gathering> fetchGathering(int id);
}
