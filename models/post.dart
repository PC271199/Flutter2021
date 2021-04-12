
import 'package:mongo_dart/mongo_dart.dart';

import  './comment.dart';

class Post {
  final ObjectId _id;
  final ObjectId author_id;
  final String title;
  final String content;
  final int like;

  Post(this._id, this.author_id, this.title, this.content, this.like);
}