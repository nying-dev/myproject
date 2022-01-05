// ignore_for_file: unused_local_variable

import 'package:http/http.dart' as http;
import 'package:myproject/service/firestore.dart';

String host = "http://192.168.1.119:5000";
Uri uri;
String category = 'Food';
//get product
Future get_product(item) async {
  uri = Uri.parse("${host}/recommend?item=${item}");
  http.Response response = await http.get(uri);
  if (response.statusCode == 200) {
    return response.body;
  } else {
    print("server side error");
  }
}

//get the not recommended health food
Future get_health() async {
  print('health');
  FirestoreUser firestoreUser = FirestoreUser();
  final costumer = await firestoreUser.getUserInfo();
  print('Customer :${costumer}');
  var sick = costumer.medical.join(",");
  uri = Uri.parse("${host}/health?allergy=${sick}&category=${category}");
  print(uri);
  http.Response response = await http.get(uri);
  print("Response :${response.statusCode}");
  if (response.statusCode == 200) {
    return response.body;
  } else {
    print("server side error");
  }
}
