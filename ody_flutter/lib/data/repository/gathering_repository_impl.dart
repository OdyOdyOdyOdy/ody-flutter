import "package:ody_flutter/data/entity/mapper/gathering_mapper.dart";
import "package:ody_flutter/data/network/service/gathering_service_impl.dart";
import "package:ody_flutter/domain/model/gathering.dart";
import "package:ody_flutter/domain/repository/gathering_repository.dart";

class GatheringRepositoryImpl implements GatheringRepository {
  GatheringRepositoryImpl(this.gatheringService);

  final GatheringService gatheringService;

  @override
  Future<Gathering> createGathering(Gathering request) async {
    try {
      final response =
          await gatheringService.createGathering(request.toEntity());
      return response.toModel();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Gathering> fetchGathering(int id) async {
    try {
      final response = await gatheringService.fetchGathering(id);
      return response.toModel();
    } catch (_) {
      rethrow;
    }
  }
}
