import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:kdr_store/consts/colors.dart';
import 'package:kdr_store/provider/cart_provider.dart';

import 'package:kdr_store/server/PaypalPayment.dart';

import 'package:kdr_store/services/global_method.dart';

import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:uuid/uuid.dart';

class Paypal extends StatefulWidget {
  static const routeName = '/Check';

  @override
  _PaypalState createState() => _PaypalState();
}

class _PaypalState extends State<Paypal> {
  final _formKey = GlobalKey<FormState>();

  var _name = '';
  var _street = '';
  var _hai = '';
  var _city = '';
  var _phone = '';

  GlobalMethods _globalMethods = GlobalMethods();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  File _pickedImage;
  bool _isLoading = false;
  String url;
  var uuid = Uuid();

  showAlertDialog(BuildContext context, String title, String body) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: [
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _trySubmit(cartProvider, total) async {
    final alirt = AlertDialog(
      title: Text('Complet Ceckout'),
      content: Container(
        height: 150,
        child: Column(
          children: [
            Divider(
              color: Colors.black,
            ),
            Text(
                "Do you want to buy products while buying them will be booked and sent to you?"),
            Divider(
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // ignore: deprecated_member_use
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {
                    Toast.show("the request has been canceled", context,
                        duration: 4,
                        backgroundColor: Colors.red,
                        textColor: Colors.black);
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  color: Colors.red[400],
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () async {
                    final isValid = _formKey.currentState.validate();
                    FocusScope.of(context).unfocus();

                    if (isValid) {
                      _formKey.currentState.save();
                      try {
                        if (_pickedImage != null) {
                          _globalMethods.authErrorHandle(
                              'Please pick an image', context);
                        } else {
                          setState(() {
                            _isLoading = true;
                          });

                          setState(() {
                            cartProvider.clearCart();
                          });

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => PaypalPayment(
                                onFinish: (number) async {
                                  // payment done
                                  print('order id: ' + number);
                                },
                              ),
                            ),
                          );
                          Toast.show(
                              "The request has been successfully", context,
                              duration: 4,
                              backgroundColor: Colors.green,
                              textColor: Colors.black);
                        }
                      } catch (error) {
                        _globalMethods.authErrorHandle(error.message, context);
                        print('error occured ${error.message}');
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'ok',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return alirt;
      },
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final sum =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    String control = sum['x'];
    // ignore: unused_local_variable
    double total = sum['subtotal'];

    return Scaffold(
      appBar: AppBar(
        // ignore: unnecessary_brace_in_string_interps
        title: Text("Check out"),
        backgroundColor: ColorsConsts.gradiendFEnd,
      ),
      bottomSheet: Container(
        height: kBottomNavigationBarHeight * 1.7,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorsConsts.white,
          border: Border(
            top: BorderSide(
              color: ColorsConsts.gradiendFEnd,
              width: 0.5,
            ),
          ),
        ),
        child: Material(
          color: Theme.of(context).backgroundColor,
          child: InkWell(
            onTap: () {
              _trySubmit(cartProvider, sum);
            },
            splashColor: ColorsConsts.gradiendFEnd,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: _isLoading
                      ? Center(
                          child: Container(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator()))
                      : Text('buy',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center),
                ),
                GradientIcon(
                  Feather.credit_card,
                  20,
                  LinearGradient(
                    colors: <Color>[
                      Colors.green,
                      Colors.yellow,
                      Colors.deepOrange,
                      Colors.orange,
                      Colors.yellow[800]
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        key: ValueKey('name'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'الإسم كاملاً',
                        ),
                        onSaved: (value) {
                          _name = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          key: ValueKey('city'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'city description is required';
                            }
                            return null;
                          },
                          //controller: this._controller,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            //  counterText: charLength.toString(),
                            labelText: 'المدينة',

                            border: OutlineInputBorder(),
                          ),
                          onSaved: (value) {
                            _city = value;
                          },
                          onChanged: (text) {
                            // setState(() => charLength -= text.length);
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          key: ValueKey('hai'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'hay description is required';
                            }
                            return null;
                          },
                          //controller: this._controller,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            //  counterText: charLength.toString(),
                            labelText: 'الحي ',

                            border: OutlineInputBorder(),
                          ),
                          onSaved: (value) {
                            _hai = value;
                          },
                          onChanged: (text) {
                            // setState(() => charLength -= text.length);
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        key: ValueKey('street'),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'street is missed';
                          }
                          return null;
                        },
                        inputFormatters: <TextInputFormatter>[],
                        decoration: InputDecoration(
                          labelText: 'الشارع ',
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (value) {
                          _street = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        key: ValueKey('Phone'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'phone is missed';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'رقم الجوال ',
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (value) {
                          _phone = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        height: 200,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                "ملاحظة : $control",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Divider(
                                  height: 15,
                                  thickness: 2,
                                  color: Colors.black),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "إجمالي الدفع  : \$$total",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GradientIcon extends StatelessWidget {
  GradientIcon(
    this.icon,
    this.size,
    this.gradient,
  );

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}
