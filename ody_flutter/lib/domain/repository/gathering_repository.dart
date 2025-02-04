import "package:ody_flutter/domain/model/gathering.dart";

abstract class GatheringRepository {
  Future<Gathering> createGathering(Gathering request);
  Future<Gathering> fetchGathering(int id);
}
