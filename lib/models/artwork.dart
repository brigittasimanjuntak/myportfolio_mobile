import 'package:json_annotation/json_annotation.dart';

part 'artwork.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Artwork {
  const Artwork({
    required this.title,
    required this.description,
    required this.artist,
    required this.medium,
    this.imageUrl = '',
    this.id,
  });

  factory Artwork.fromJson(Map<String, dynamic> json) => _$ArtworkFromJson(json);

  @JsonKey(includeToJson: false)
  final String? id;
  
  final String title;
  final String description;
  final String artist;
  final String medium;
  
  @JsonKey(defaultValue: '')
  final String imageUrl;

  Map<String, dynamic> toJson() => _$ArtworkToJson(this);
}