// ignore_for_file: unused_local_variable

import 'package:http/http.dart' as http;
import "dart:io";

String host = "http://192.168.1.114:5000/";
Uri uri;
//get product
Future get_product(item) async {
  uri = Uri.parse("${host}recommend?item=${item}");
  http.Response response = await http.get(uri);
  if (response.statusCode == 200) {
    return response.body;
  } else {
    print("server side error");
  }
}

//get the not recommended health food
Future get_health(String sick) async {
  uri = Uri.parse("${host}health?allergy=${sick}");
  http.Response response = await http.get(uri);
  if (response.statusCode == 200) {
    return response.body;
  } else {
    print("server side error");
  }
}
