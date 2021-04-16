import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:blog/utils/headerData.dart';

String url = 'https://ancient-cliffs-67475.herokuapp.com/api/v1/viewers';

class CrudMethods {



  Future<dynamic> deleteViewer(viewerId) async {
    try {
      var token = await HeaderData.getToken();
      var response = await http.delete(Uri.tryParse('$url/$viewerId'),
          headers: {"Accept": "application/json" , 'Authorization': 'Bearer $token'});
      var result = jsonDecode(response.body);
      return result;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getViewers() async {
    try {
      var response = await http
          .get(Uri.tryParse(url), headers: {"Accept": "application/json" ,} );
      var result = jsonDecode(response.body);
      return result;
    } catch (e) {}
  }

}
