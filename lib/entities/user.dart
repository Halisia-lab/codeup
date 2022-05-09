class User {
  final int id;
  final String email;
  final String password;
  final String username;
  final String firstname;
  final String lastname;

  const User(this.id, this.email, this.password, this.username, this.firstname, this.lastname);

factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'],
      json['email'],
      json['password'],
      json['username'],
      json['firstname'],
      json['lastname'],
    );
  }
 @override
  String toString() {
    return "{id: ${this.id}, email: ${this.email}, password: ${this.password}, username: ${this.username}, firstname: ${this.firstname}, lastname: ${this.lastname}}";
  }
}