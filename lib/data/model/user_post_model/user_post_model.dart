import 'dart:io';

class UserPostModel {
  final String? firstname;
  final String? lastName;
  final String? mobile;
  final String? email;
  final String? username;
  final String? countryCode;
  final String? country;
  final String? mobileCode;
  final File? avatar;
  final String? address;
  final String? state;
  final String? zip;
  final String? city;

  UserPostModel({
    this.firstname,
    this.lastName,
    this.mobile,
    this.email,
    this.username,
    this.countryCode,
    this.country,
    this.mobileCode,
    this.avatar,
    this.address,
    this.state,
    this.zip,
    this.city,
  });

  factory UserPostModel.fromMap(Map<String, dynamic> map) {
    return UserPostModel(
      firstname: map['firstname'] as String?,
      lastName: map['lastName'] as String?,
      mobile: map['mobile'] as String?,
      email: map['email'] as String?,
      username: map['username'] as String?,
      countryCode: map['countryCode'] as String?,
      country: map['country'] as String?,
      mobileCode: map['mobileCode'] as String?,
      avatar: map['avatar'] as File?,
      address: map['address'] as String?,
      state: map['state'] as String?,
      zip: map['zip'] as String?,
      city: map['city'] as String?,
    );
  }
}
