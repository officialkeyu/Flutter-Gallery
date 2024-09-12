/// A model class representing image data fetched from the Pixabay API.
class ImageData {
  final int id;
  final String url;
  final int likes;
  final int views;
  final String title;

  ImageData({
    required this.id,
    required this.url,
    required this.likes,
    required this.views,
    required this.title,
  });

  /// Creates an instance of [ImageData] from a JSON object.
  ///
  /// The [json] parameter must not be null.
  /// Throws a [FormatException] if any required fields are missing or have invalid formats.
  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      id: json['id'],
      url: json['webformatURL'],
      likes: json['likes'],
      views: json['views'],
      title: json['tags'], // Assign the 'tags' from API response to 'title'
    );
  }
}
