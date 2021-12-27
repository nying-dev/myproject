import 'dart:core';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:myproject/service/paypal.dart';

class PaypalPayment extends StatefulWidget {
  final Function onFinish;
  final String totalAmount;
  PaypalPayment({this.onFinish, this.totalAmount});

  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentState();
  }
}

//convert mycart to for item

class PaypalPaymentState extends State<PaypalPayment> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var checkoutUrl;
  var executeUrl;
  var accessToken;
  PaypalServices services = PaypalServices();
  //you can chage default currency according to your need
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "PHP ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "PHP"
  };

  bool isEnableShipping = true;
  bool isEnableAddress = true;

  String returnURL = "return.example.com";
  String cancelURL = "cancel.example.com";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      try {
        accessToken = await services.getAccessToken();
        final transaction = getOrderParams(widget.totalAmount);
        final res =
            await services.createPaypalPayment(transaction, accessToken);
        print('paypal total :${widget.totalAmount}');
        if (res != null) {
          setState(() {
            checkoutUrl = res["approvalUrl"];
            executeUrl = res["executeUrl"];
          });
        }
      } catch (e) {
        print('exception: ' + e.toString());
        final snackBar = SnackBar(
          content: Text(e.toString()),
          duration: Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              //some code to undo the change.
              Navigator.pop(context);
            },
          ),
        );
        //ignore:deprecated_member_use
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    });
  }

  //item name,price and quatity

  //convert my cart

  Map<String, dynamic> getOrderParams(String total) {
    String totalAmount = total;
    String subTotalAmount = total;
    String shippingCost = '0';
    int shippingDiscountCost = 0;
    //name
    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": totalAmount,
            "currency": defaultCurrency["currency"],
            "details": {
              "subtotal": subTotalAmount,
              "shipping": shippingCost,
              "shipping_discount": ((-1.0) * shippingDiscountCost).toString()
            }
          },
          "description": "The payment transaction description.",
          "payment_option": {"allowed_payment_method": "INSTAN_FUNDING_SOURCE"},
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    print(checkoutUrl);
    if (checkoutUrl != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: WebView(
          initialUrl: checkoutUrl,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains(returnURL)) {
              final uri = Uri.parse(request.url);
              final payerID = uri.queryParameters['PlayerID'];
              if (payerID != null) {
                services
                    .executePayment(executeUrl, payerID, accessToken)
                    .then((id) {
                  widget.onFinish(id);
                  Navigator.of(context).pop();
                });
              } else {
                Navigator.of(context).pop();
              }
              Navigator.of(context).pop();
            }
            if (request.url.contains(cancelURL)) {
              Navigator.of(context).pop();
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.black12,
          elevation: 0.0,
        ),
        body: Center(child: Container(child: CircularProgressIndicator())),
      );
    }
  }
}
