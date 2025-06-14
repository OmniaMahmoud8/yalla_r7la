class Image {
  String? imageId;
  String? imagePath;

  Image({this.imageId, this.imagePath});

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    imageId: json['imageId'] as String?,
    imagePath: json['imagePath'] as String?,
  );

  Map<String, dynamic> toJson() => {'imageId': imageId, 'imagePath': imagePath};
}
