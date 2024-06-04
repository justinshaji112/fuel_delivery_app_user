// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserEntity {
  String? uid;
  String email;
  String password;
  String phoneNumber;
  String name;
  UserEntity({
    this.uid,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.name,
  });
}
