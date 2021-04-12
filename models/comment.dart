import 'package:mongo_dart/mongo_dart.dart';

class Comment {
  final ObjectId _id;
  final ObjectId user_id;
  final ObjectId post_id;
  final String content;

  Comment(this._id, this.user_id, this.post_id, this.content);
}