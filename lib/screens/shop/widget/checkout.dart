import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myproject/screens/paypal/paypal_payment.dart';
import 'package:myproject/service/firestore.dart';
import 'package:myproject/models/model.dart';

class CheckOutPage extends StatefulWidget {
  final List<MCartItem> myOrderList;
  final String totalPrice;

  CheckOutPage({this.myOrderList, this.totalPrice});

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOutPage> {
  FirestoreUser firestoreUser = FirestoreUser();
  Future<Costumer> info;

  Future<Costumer> costumer() async {
    final getUser = await firestoreUser.getUserInfo();
    print('get user:${getUser.medical}');
    return getUser;
  }

  @override
  void initState() {
    super.initState();
    info = costumer();
  }

  @override
  Widget build(BuildContext context) {
    String totalprice = widget.totalPrice;
    return Scaffold(
        appBar: AppBar(
            title: Text('Check Out',
                style: TextStyle(fontSize: 20.0, color: Colors.white)),
            toolbarHeight: 60,
            centerTitle: true,
            backgroundColor: Colors.green,
            actions: [],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)))),
        body: FutureBuilder(
            future: info,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print('snapshot ${snapshot.data}');
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    delivery(
                        barangay: snapshot.data.baragay,
                        municipality: snapshot.data.municipality,
                        provice: snapshot.data.province),
                    orderSummary(),
                    modePayment(totalprice),
                    Container(
                      height: 120,
                      width: 400,
                      child: RichText(
                          text: TextSpan(children: <TextSpan>[
                        TextSpan(),
                      ])),
                      decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(10.0))),
                    )
                  ],
                );
              } else {
                return Container();
              }
            }));
  }

  Widget delivery({String barangay, String municipality, String provice}) {
    return Card(
        child: Container(
      height: 150.0,
      width: 400.0,
      child: Text('Delivery Address ${barangay},${municipality},${provice}'),
    ));
  }

  Widget orderSummary() {
    return Card(
        child: Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text('Order Summary'),
        ),
        Container(
          height: 140.0,
          width: 400.0,
          child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.vertical,
              itemCount: widget.myOrderList.length,
              itemBuilder: (BuildContext context, int index) {
                final sumitem = widget.myOrderList[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Image.network(
                            sumitem.item.url,
                            width: 100,
                            height: 100,
                          ),
                          Column(
                            children: [
                              RichText(
                                  text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: sumitem.item.name,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black)),
                                TextSpan(
                                    text: '\nPHP${sumitem.item.price}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xff0FA956))),
                              ])),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('x${sumitem.count}'),
                      ),
                    )
                  ],
                );
              }),
        ),
      ],
    ));
  }

//mode payment
  Widget modePayment(totalprice) {
    return Card(
        child: Container(
      height: 170.0,
      width: 400.0,
      child: Column(
        children: [
          Text('Mode Of Payment'),
          ElevatedButton(
              onPressed: () {
                //Make Paypal payment
                print('Checkout ${widget.totalPrice}');
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => PaypalPayment(
                        totalAmount: totalprice,
                        onFinish: (number) async {
                          //payment done
                          print('order id: ' + number);
                        }),
                  ),
                );
              },
              child: Text(
                'Pay with Paypal',
                textAlign: TextAlign.center,
              ))
        ],
      ),
    ));
  }
}
