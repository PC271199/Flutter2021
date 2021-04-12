import 'package:mongo_dart/mongo_dart.dart';

class User {
  final ObjectId user_id;
  final String email;
  final String password;
  final String role;
  final String fullName;

  User(this.user_id, this.email, this.password, this.role, this.fullName);
}