import "package:ody_flutter/data/entity/gathering/nudge_request.dart";
import "package:ody_flutter/domain/model/nudge.dart";

extension ToData on Nudge {
  NudgeRequest toEntity() => NudgeRequest(
        requestMateId: requestMateId,
        nudgedMateId: nudgedMateId,
      );
}
