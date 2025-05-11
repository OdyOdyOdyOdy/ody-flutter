import "package:ody_flutter/data/entity/gathering/gatherings_response.dart";
import "package:ody_flutter/domain/model/gathering2.dart";

extension ToDomain on GatheringsResponse {
  List<Gathering2> toModel() => GatheringsResponse(meetings: meetings)
      .meetings
      .map(
        (meeting) => Gathering2(
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
