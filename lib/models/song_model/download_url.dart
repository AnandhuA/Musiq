import 'package:hive/hive.dart';

part 'download_url.g.dart'; // Required for Hive code generation

@HiveType(typeId: 2) // Assign a unique typeId for the DownloadUrl class
class DownloadUrl {
  @HiveField(0)
  final String link;

  @HiveField(1)
  final String quality;

  // Constructor for DownloadUrl class
  DownloadUrl({
    required this.link,
    required this.quality,
  });

  // Factory constructor to create an instance from JSON
  factory DownloadUrl.fromJson(Map<String, dynamic> json) {
    // Check if JSON contains 'url' or 'link' and 'quality'
    if ((json.containsKey('url') || json.containsKey('link')) &&
        json.containsKey('quality')) {
      return DownloadUrl(
        link: json['url'] ?? json['link'], // Handle both 'url' and 'link'.
        quality: json['quality'], // Extract the 'quality' value
      );
    } else {
      throw UnimplementedError('DownloadUrl: Invalid JSON structure');
    }
  }

  // Method to convert DownloadUrl instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'link': link, // Normalize the link to 'link' when converting to JSON
      'quality': quality,
    };
  }
}
