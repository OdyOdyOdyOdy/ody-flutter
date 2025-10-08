import "package:ody_flutter/data/entity/gathering/gatherings_response.dart";
import "package:ody_flutter/domain/model/gathering.dart";

extension ToDomain on GatheringsResponse {
  List<Gathering> toModel() => GatheringsResponse(meetings: meetings)
      .meetings
      .map(
        (meeting) => Gathering(
          id: meeting.id,
          name: meeting.name,
          date: meeting.date,
          time: meeting.time,
          targetAddress: meeting.targetAddress,
          originAddress: meeting.originAddress,
          durationMinutes: meeting.durationMinutes,
        ),
      )
      .toList();
}
