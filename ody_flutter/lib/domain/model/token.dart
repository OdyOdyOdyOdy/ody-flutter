class Token {
  Token({
    this.device,
});

  String? device;

  Map<String, dynamic> toMap() => {
      "device": device,
    };
}
