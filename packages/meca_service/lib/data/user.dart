class User {
  final int id;
  final String userName;
  final String email;
  final bool blocked;

  User(this.id, this.userName, this.email, this.blocked);

  Map<String, dynamic> toJson() => {
        'data': {
          'id': id,
          'username': userName,
          'email': email,
          'blocked': blocked
        }
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['id'], json['username'], json['email'], json['blocked']);
  }
}
