class Login {
  final String email;
  final String password;

  Login({
    required this.email,
    required this.password,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      email: json['Email'],
      password: json['Password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Email': email,
      'Password': password,
    };
  }
}
