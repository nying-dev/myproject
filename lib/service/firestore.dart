import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myproject/models/model.dart';

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
  String Uid() {
    User user = auth.currentUser;
    String uid = user.uid;
    return uid;
  }

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
    String uid = Uid() as String;
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

  // ignore: unused_element
  Future<void> UploadMyCartToFirebase({MCartItem myCart}) async {
    print(Uid() as String);
    String uid = Uid() as String;
    print(uid);

    await firestore
        .doc(uid)
        .collection('Cart')
        .doc(myCart.item.name)
        .set(myCart.toJson())
        .then((value) => print('add to cart'))
        .catchError((e) => print(e));
  }
}
