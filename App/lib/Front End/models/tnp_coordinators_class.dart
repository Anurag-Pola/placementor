class TnPCoordinator {
  String id;
  String name;
  String department;
  String email;
  String phone;

  TnPCoordinator({
    required this.id,
    required this.name,
    required this.department,
    required this.email,
    required this.phone,
  });

  factory TnPCoordinator.fromJson(Map<String, dynamic> json) {
    return TnPCoordinator(
      id: json['id'],
      name: json['name'] as String,
      department: json['department'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'department': department,
      'email': email,
      'phone': phone,
    };
  }
}
