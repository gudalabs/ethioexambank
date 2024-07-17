class SignUpModel {
 
  final String email;
  final String username;
  final String password;
  final String confirmPassword;

  SignUpModel( {
    required this.email,
    required this.username,
    required this.password,
    required this.confirmPassword,
  });
}
