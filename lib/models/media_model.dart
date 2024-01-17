import 'dart:convert';

class MediaModel {
  String id;
  String downloadUrl;
  String type;
  String thumbnail;
  String thumbnailId;
  String name;
  int size;
  MediaModel({
    required this.id,
    required this.downloadUrl,
    required this.type,
    required this.thumbnail,
    required this.thumbnailId,
    required this.name,
    required this.size,
  });

  MediaModel copyWith({
    String? id,
    String? downloadUrl,
    String? type,
    String? thumbnail,
    String? thumbnailId,
    String? name,
    int? size,
  }) {
    return MediaModel(
      id: id ?? this.id,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      type: type ?? this.type,
      thumbnail: thumbnail ?? this.thumbnail,
      thumbnailId: thumbnailId ?? this.thumbnailId,
      name: name ?? this.name,
      size: size ?? this.size,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'downloadUrl': downloadUrl,
      'type': type,
      'thumbnail': thumbnail,
      'thumbnailId': thumbnailId,
      'name': name,
      'size': size,
    };
  }

  factory MediaModel.fromMap(Map<String, dynamic> map) {
    return MediaModel(
      id: map['id'] as String,
      downloadUrl: map['downloadUrl'] as String,
      type: map['type'] as String,
      thumbnail: map['thumbnail'] as String,
      thumbnailId: map['thumbnailId'] as String,
      name: map['name'] as String,
      size: map['size'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory MediaModel.fromJson(String source) =>
      MediaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MediaModel(id: $id, downloadUrl: $downloadUrl, type: $type, thumbnail: $thumbnail, thumbnailId: $thumbnailId, name: $name, size: $size)';
  }
}
