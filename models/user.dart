import 'package:mongo_dart/mongo_dart.dart';

class User {
  final ObjectId user_id;
  final String username;
  final String password;
  final String role;
  final String displayed_name;

  User(this.user_id, this.username, this.password, this.role, this.displayed_name);
}