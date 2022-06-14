class ChangeFavourites {
  bool? status;
  String? message;
  bool? wished;

  ChangeFavourites({this.status, this.message, this.wished});

  ChangeFavourites.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    wished = json['wished'];
  }
}