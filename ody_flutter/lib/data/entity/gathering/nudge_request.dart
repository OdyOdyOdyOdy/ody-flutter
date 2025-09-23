class NudgeRequest {
  NudgeRequest({
    this.requestMateId,
    this.nudgedMateId,
  });

  NudgeRequest.fromJson(Map<String, dynamic> json) {
    if (json["requestMateId"] is int) {
      requestMateId = json["requestMateId"];
    }
    if (json["nudgedMateId"] is int) {
      nudgedMateId = json["nudgedMateId"];
    }
  }

  int? requestMateId;
  int? nudgedMateId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["requestMateId"] = requestMateId;
    data["nudgedMateId"] = nudgedMateId;
    return data;
  }
}
