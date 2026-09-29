/// A signed-in passenger.
///
/// [phone] is always stored in international format, for example
/// "+93701234567". [email] is optional because many users in Afghanistan
/// register with a phone number only.
class AppUser {
  const AppUser({
    required this.id,
    required this.fullName,
    required this.phone,
    this.email,
  });

  final String id;
  final String fullName;
  final String phone;
  final String? email;

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'fullName': fullName,
    'phone': phone,
    'email': email,
  };
}
