import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myproject/screens/paypal/paypal_payment.dart';
import 'package:myproject/service/firestore.dart';
import 'package:myproject/models/model.dart';

class CheckOutPage extends StatefulWidget {
  final List<MCartItem> myOrderList;

  CheckOutPage({this.myOrderList});
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOutPage> {
  FirestoreUser firestoreUser = FirestoreUser();
  @override
  Widget build(BuildContext context) {
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
      body: ListView(
        children: [
          delivery(),
          orderSummary(),
          modeOfPayment(),
          Container(
            height: 120,
            width: 400,
            child: Text('Total Payment'),
            decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10.0))),
          )
        ],
      ),
    );
  }

  Widget delivery() {
    return Card(
        child: Container(
      height: 150.0,
      width: 400.0,
      child: Text(
        'Deliver Addres',
        style: TextStyle(),
      ),
    ));
  }

  Widget orderSummary() {
    return Card(
        child: Container(
      height: 140.0,
      width: 400.0,
      child: Text('Order Summary'),
    ));
  }

  Widget modeOfPayment() {
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

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        PaypalPayment(onFinish: (number) async {
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
