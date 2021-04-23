import 'dart:convert';
import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:blog/utils/headerData.dart';

String url = 'https://ancient-cliffs-67475.herokuapp.com/api/v1/posts';
// String url = 'http://localhost/api/v1/posts';

class CrudMethods {
  Future<dynamic> createPost(blogData) async {
    try {
      var token = await HeaderData.getToken();
      var response =
          await http.post(Uri.tryParse(url), body: blogData, headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      });
      var result = jsonDecode(response.body);
      return result;
    } catch (e) {
      print(e);
      // return
    }
  }

  Future<dynamic> updatePost(postId, blogData) async {
    try {
      var token = await HeaderData.getToken();
      var response = await http.patch(Uri.tryParse("$url/$postId"),
          body: blogData,
          headers: {
            "Accept": "application/json",
            'Authorization': 'Bearer $token'
          });
      var result = jsonDecode(response.body);
      print("check update");
      print(result);
      return result;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> deletePost(postId) async {
    try {
      var token = await HeaderData.getToken();
      var response = await http.delete(Uri.tryParse('$url/$postId'), headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      });
      var result = jsonDecode(response.body);
      return result;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getPosts() async {
    try {
      var response = await http.get(Uri.tryParse(url), headers: {
        "Accept": "application/json",
      });
      var result = jsonDecode(response.body);
      return result;
    } catch (e) {}
  }

  Future<dynamic> getPost(postId) async {
    try {
      var response = await http.get(Uri.tryParse('$url/$postId'), headers: {
        "Accept": "application/json",
      });
      var result = jsonDecode(response.body);
      return result;
    } catch (e) {}
  }

  Future<dynamic> getBloggerPosts() async {
    try {
      var token = await HeaderData.getToken();

      var response = await http.get(Uri.tryParse('$url/blogger'), headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      });
      var result = jsonDecode(response.body);
      return result;
    } catch (e) {}
  }

  Future<dynamic> postComment(postId, content) async {
    try {
      Map<String, dynamic> data = {"content": content};
      var token = await HeaderData.getToken();

      var response = await http.patch(Uri.tryParse('$url/$postId/comment'),
          body: data,
          headers: {
            "Accept": "application/json",
            'Authorization': 'Bearer $token'
          });
      var result = jsonDecode(response.body);
      return result;
    } catch (e) {}
  }
}
