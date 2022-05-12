class ExperienceTileClass {
  const ExperienceTileClass({
    required this.experience,
    required this.name,
    required this.batch,
    required this.rollNo,
  });

  ExperienceTileClass.fromJson(Map<String, Object?> json)
      : this(
          experience: json['experience']! as String,
          name: json['name']! as String,
          batch: json['batch']! as String,
          rollNo: json['rollNo']! as String,
        );

  final String experience;
  final String name;
  final String batch;
  final String rollNo;

  Map<String, Object?> toJson() {
    return {
      'experience': experience,
      'name': name,
      'batch': batch,
      'rollNo': rollNo,
    };
  }
}
