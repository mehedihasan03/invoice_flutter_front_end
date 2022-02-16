class User{
  late String name;
  late String username;
  late String email;
  late String password;

//<editor-fold desc="Data Methods">

  User({
    required this.name,
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          username == other.username &&
          email == other.email &&
          password == other.password);

  @override
  int get hashCode =>
      name.hashCode ^ username.hashCode ^ email.hashCode ^ password.hashCode;

  @override
  String toString() {
    return 'User{' +
        ' name: $name,' +
        ' username: $username,' +
        ' email: $email,' +
        ' password: $password,' +
        '}';
  }

  User copyWith({
    String? name,
    String? username,
    String? email,
    String? password,
  }) {
    return User(
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'username': this.username,
      'email': this.email,
      'password': this.password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

//</editor-fold>
}