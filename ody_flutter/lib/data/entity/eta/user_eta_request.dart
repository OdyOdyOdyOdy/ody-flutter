class EtaRequest {
  const EtaRequest({
    required this.isMissing,
    required this.currentLatitude,
    required this.currentLongitude,
  });

  final bool isMissing;
  final double currentLatitude;
  final double currentLongitude;

  Map<String, dynamic> toJson() => {
        "isMissing": isMissing,
        "currentLatitude": "$currentLatitude",
        "currentLongitude": "$currentLongitude",
      };
}
