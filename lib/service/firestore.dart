import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreUser {
  String userId;
  String fname;
  String lname;
  String birthdate;
  String province;
  String gender;
  String municipality;
  String barangay;
  List<String> medical = [];

  final FirebaseAuth auth = FirebaseAuth.instance;

  CollectionReference firestore =
      FirebaseFirestore.instance.collection('Users');
  Future<void> UserInfo({
    fname,
    lname,
    birthdate,
    province,
    municipality,
    baragay,
    medical,
    gender,
  }) async {
    final User user = auth.currentUser;
    final uid = user.uid;
    print(uid);
    print(
        '${fname},${lname},${gender},${birthdate},${province},${municipality},${barangay},${medical}');
    firestore
        .doc(uid)
        .set({
          'firstname': fname ?? '',
          'lastname': lname ?? '',
          'birtdate': birthdate ?? '',
          'medical': medical ?? '',
          'province': province ?? '',
          'municipality': municipality ?? '',
          'barangay': baragay ?? '',
          'gender': gender
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
