class DeviceToken {
  DeviceToken({
    this.device,
  });

  String? device;

  Map<String, dynamic> toMap() => {
        "device": device,
      };
}
