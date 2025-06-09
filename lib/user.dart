class User {
  final int id;
  final String name;
  final String? profilePic;

  User({required this.id, required this.name, this.profilePic});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      profilePic: json['profilepic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'profilepic': profilePic};
  }
}
