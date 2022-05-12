class PreviouslyPlacedContactDetailsClass {
  const PreviouslyPlacedContactDetailsClass({
    required this.name,
    required this.rollNo,
    required this.email,
    required this.phone,
    required this.linkedin,
  });

  PreviouslyPlacedContactDetailsClass.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          rollNo: json['rollNo']! as String,
          email: json['email']! as String,
          phone: json['phone']! as String,
          linkedin: json['linkedin']! as String,
        );

  final String name;
  final String rollNo;
  final String email;
  final String phone;
  final String linkedin;

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'rollNo': rollNo,
      'email': email,
      'phone': phone,
      'linkedin': linkedin,
    };
  }
}
