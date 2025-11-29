import "package:ody_flutter/data/entity/gathering/enter_gathering_response.dart";
import "package:ody_flutter/domain/model/enter_gathering.dart";
import "package:ody_flutter/utils/gathering_time_util.dart";

extension ToDomain on EnterGatheringResponse {
  EnterGathering toModel() => EnterGathering(
        gatheringId: gatheringId,
        dateTime: combineDateAndTimeToFullString(date, time),
      );
}
