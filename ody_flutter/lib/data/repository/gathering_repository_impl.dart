import "package:ody_flutter/data/db/service/auth_token_service.dart";
import "package:ody_flutter/data/entity/gathering/gathering_request.dart";
import "package:ody_flutter/data/entity/mapper/gathering_detail_mapper.dart";
import "package:ody_flutter/data/entity/mapper/gathering_mapper.dart";
import "package:ody_flutter/data/entity/mapper/gatherings_mapper.dart";
import "package:ody_flutter/data/network/service/gathering_service_impl.dart";
import "package:ody_flutter/domain/model/gathering.dart";
import "package:ody_flutter/domain/model/gathering2.dart";
import "package:ody_flutter/domain/model/gathering_detail.dart";
import "package:ody_flutter/domain/repository/gathering_repository.dart";

class GatheringRepositoryImpl implements GatheringRepository {
  GatheringRepositoryImpl(this.gatheringService, this.authTokenService);

  final GatheringService gatheringService;
  final AuthTokenService authTokenService;

  @override
  Future<Gathering> createGathering(GatheringRequest request) async {
    try {
      final response = await gatheringService.createGathering(request);
      return response.toModel();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<GatheringDetail> fetchGathering(int id) async {
    try {
      final response = await gatheringService.fetchGathering(id);
      return response.toModel();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<Gathering2>> fetchGatherings() async {
    try {
      final response = await gatheringService.fetchGatherings();
      return response.toModel();
    } catch (_) {
      rethrow;
    }
  }
}
