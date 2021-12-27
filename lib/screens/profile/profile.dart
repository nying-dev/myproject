import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myproject/service/firestore.dart';

class Profile extends StatelessWidget {
  FirestoreUser firestoreUser = FirestoreUser();

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: FutureBuilder(
                future: firestoreUser.getUserInfo(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: height - 50,
                        color: Color(0xFFf2f0f0),
                        child: Column(
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: const Align(
                                      alignment: Alignment.topCenter,
                                      child: Icon(
                                        Icons.account_circle_sharp,
                                        size: 70,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${snapshot.data.fname} ${snapshot.data.lname}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: Text('Edit profile'),
                                          style: TextButton.styleFrom(
                                              backgroundColor:
                                                  Color(0xfffaeb89)),
                                        )
                                      ],
                                    ),
                                  ),
                                ]),
                            Container(
                              padding: EdgeInsets.all(20),
                              color: Colors.white,
                              width: width - 40,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    child: const Text('Dilivery Status',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        )),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: const [
                                          Icon(Icons.payment),
                                          Text('To pay')
                                        ],
                                      ),
                                      Column(
                                        children: const [
                                          Icon(Icons.local_shipping),
                                          Text('To ship')
                                        ],
                                      ),
                                      Column(
                                        children: const [
                                          Icon(Icons.drive_file_move_rounded),
                                          Text('To deliver')
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                margin: EdgeInsets.symmetric(vertical: 20),
                                color: Colors.white,
                                width: width - 40,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 10),
                                        child: const Text('Buy Again',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            )),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Image.asset(
                                                "assets/google.png",
                                                width: 50,
                                                height: 50,
                                              ),
                                              Container(
                                                width: 90,
                                                child: const Text(
                                                    'Name of the product',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 10)),
                                              ),
                                              const Text(
                                                'Php. 0.00',
                                                style: TextStyle(
                                                    color: Color(0xFF51aa58)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ])),
                            Container(
                              padding: EdgeInsets.all(20),
                              color: Colors.white,
                              width: width - 40,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: const Text(
                                      'Account Setting',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: const Text(
                                      'Help and Support',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  Container(
                                      child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor: Color(0xFFc0c0c0)),
                                        onPressed: () {
                                          FirebaseAuth.instance.signOut();
                                        },
                                        child: const Text('Log Out',
                                            style: TextStyle(
                                                color: Colors.white))),
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ));
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          )),
    );
  }
}
