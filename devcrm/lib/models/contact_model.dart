class Contact {
  int id;
  final String name;
  final String email;
  final String phone;
  final String company;

  Contact(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.company});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      company: json['company'] ?? '',
    );
  }
}
