class ResourceClass {
  const ResourceClass({
    required this.title,
    required this.description,
    required this.link,
    required this.timestamp,
  });

  ResourceClass.fromJson(Map<String, Object?> json)
      : this(
          title: json['title']! as String,
          description: json['description']! as String,
          link: json['link'] as String,
          timestamp: json['timestamp']! as String,
        );

  final String title;
  final String description;
  final String link;
  final String timestamp;

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'description': description,
      'link': link,
      'timestamp': timestamp,
    };
  }
}
