import "package:ody_flutter/domain/model/gathering.dart";
import "package:ody_flutter/domain/model/gathering2.dart";

abstract class GatheringRepository {
  Future<Gathering> createGathering(Gathering request);
  Future<Gathering> fetchGathering(int id);
  Future<List<Gathering2>> fetchGatherings();
}
