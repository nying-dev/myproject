// ignore_for_file: unused_local_variable

import 'package:http/http.dart' as http;
import "dart:io";

Future get_product(url) async {
  http.Response response = await http.get(url);
  if (response.statusCode == 200) {
    return response.body;
  } else {
    print("server side error");
  }
}
