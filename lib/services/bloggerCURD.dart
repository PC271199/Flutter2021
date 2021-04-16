import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:blog/utils/headerData.dart';

String url = 'https://ancient-cliffs-67475.herokuapp.com/api/v1/blogger';

class CrudMethods {

  Future<dynamic> deleteBlogger(bloggerId) async {
    try {
      var token = await HeaderData.getToken();
      var response = await http.delete(Uri.tryParse('$url/$bloggerId'),
          headers: {"Accept": "application/json" , 'Authorization': 'Bearer $token'});
      var result = jsonDecode(response.body);
      return result;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getBloggers() async {
    try {
      var response = await http
          .get(Uri.tryParse(url), headers: {"Accept": "application/json" ,} );
      var result = jsonDecode(response.body);
      return result;
    } catch (e) {}
  }

}
