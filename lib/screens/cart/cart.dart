import 'package:fluttertoast/fluttertoast.dart';
import 'package:kdr_store/consts/colors.dart';
import 'package:kdr_store/consts/my_icons.dart';
import 'package:kdr_store/provider/cart_provider.dart';
import 'package:kdr_store/screens/cart/chexk.dart';
import 'package:kdr_store/screens/cart/paypal_methoe.dart';

import 'package:kdr_store/services/global_method.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'cart_empty.dart';
import 'cart_full.dart';

class CartScreen extends StatefulWidget {
  //To be known 1) the amount must be an integer 2) the amount must not be double 3) the minimum amount should be less than 0.5 $
  static const routeName = '/CartScreen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var response;
  bool _isLoading = false;
  GlobalMethods globalMethods = GlobalMethods();
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return cartProvider.getCartItems.isEmpty
        ? Scaffold(body: CartEmpty())
        : Scaffold(
            bottomSheet: checkoutSection(context, cartProvider.totalAmount),
            appBar: AppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              title: Text('Cart (${cartProvider.getCartItems.length})'),
              actions: [
                IconButton(
                  onPressed: () {
                    globalMethods.showDialogg(
                        'Clear cart!',
                        'Your cart will be cleared!',
                        () => cartProvider.clearCart(),
                        context);
                    // cartProvider.clearCart();
                  },
                  icon: Icon(MyAppIcons.trash),
                )
              ],
            ),
            body: Container(
              margin: EdgeInsets.only(bottom: 60),
              child: ListView.builder(
                  itemCount: cartProvider.getCartItems.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return ChangeNotifierProvider.value(
                      value: cartProvider.getCartItems.values.toList()[index],
                      child: CartFull(
                        productId:
                            cartProvider.getCartItems.keys.toList()[index],
                        // id:  cartProvider.getCartItems.values.toList()[index].id,
                        // productId: cartProvider.getCartItems.keys.toList()[index],
                        // price: cartProvider.getCartItems.values.toList()[index].price,
                        // title: cartProvider.getCartItems.values.toList()[index].title,
                        // imageUrl: cartProvider.getCartItems.values.toList()[index].imageUrl,
                        // quatity: cartProvider.getCartItems.values.toList()[index].quantity,
                      ),
                    );
                  }),
            ),
          );
  }

  Widget checkoutSection(BuildContext ctx, double subtotal) {
    String array1 = ' التوصيل مجاني ولقد حصلت على خصم 5% من إجمالي الدفع';
    String array2 =
        'سيتم فرض ضريبة التوصيل عند الاستلام وتم خصم 10% من إجمالي الدفع ';
    String paid = 'سيتم فرض ضريبة التوصيل عند الاستلام';
    String x = '';
    if (subtotal >= 1000) {
      setState(() {
        subtotal -= 5;
        x = array1;
      });
    } else if (subtotal >= 500 && subtotal < 1000) {
      setState(() {
        subtotal -= 10;
        x = array2;
      });
    } else if (subtotal < 500) {
      setState(() {
        subtotal -= 0;
        x = paid;
        // ignore: unnecessary_statements
      });
    }
    // ignore: unused_local_variable
    final cartProvider = Provider.of<CartProvider>(context);
    // ignore: unused_local_variable
    var uuid = Uuid();
    // ignore: unused_local_variable
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            /// mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(colors: [
                      ColorsConsts.gradiendLStart,
                      ColorsConsts.gradiendLEnd,
                    ], stops: [
                      0.0,
                      0.7
                    ]),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: _isLoading
                        ? CircularProgressIndicator()
                        : InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () async {
                              /*  User user = _auth.currentUser;
                              final _uid = user.uid;
                              cartProvider.getCartItems
                                  .forEach((key, orderValue) async {
                                final orderId = uuid.v4();
                                try {
                                  await FirebaseFirestore.instance
                                      .collection('order')
                                      .doc(orderId)
                                      .set({
                                    'orderId': orderId,
                                    'userId': _uid,
                                    'userName': user.displayName,
                                    'userPhone': user.phoneNumber.toString(),
                                    'userEmail': user.email,
                                    'orders': [
                                      for (int i = 0;
                                          i < cartProvider.getCartItems.length;
                                          i++)
                                        {
                                          'productId': cartProvider
                                              .getCartItems.values
                                              .toList()[i]
                                              .id,
                                          'title': cartProvider
                                              .getCartItems.values
                                              .toList()[i]
                                              .title,
                                          'price':
                                              // orderValue.price * orderValue.quantity,
                                              cartProvider.getCartItems.values
                                                      .toList()[i]
                                                      .price *
                                                  cartProvider
                                                      .getCartItems.values
                                                      .toList()[i]
                                                      .quantity,
                                          'imageUrl': cartProvider
                                              .getCartItems.values
                                              .toList()[i]
                                              .imageUrl,
                                          'quantity': cartProvider
                                              .getCartItems.values
                                              .toList()[i]
                                              .quantity,
                                        }
                                    ],
                                    'orderDate': Timestamp.now(),
                                  });
                                } catch (err) {
                                  print('error occured $err');
                                }
                              });
                              setState(() {
                                cartProvider.clearCart();
                              });*/

                              /*  Navigator.pushNamed(context, Check.routeName,
                                  arguments: {
                                    'subtotal': subtotal,
                                    'x': x,
                                  });*/
                              final alirt = AlertDialog(
                                title: Text('payment method'),
                                content: Container(
                                  height: 150,
                                  child: Column(
                                    children: [
                                      Divider(
                                        color: Colors.black,
                                      ),
                                      Text("Choose your payment method"),
                                      Divider(
                                        color: Colors.black,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          // ignore: deprecated_member_use
                                          RaisedButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, Paypal.routeName,
                                                  arguments: {
                                                    'subtotal': subtotal,
                                                    'x': x,
                                                  });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                'Paypal',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            color: Colors.blue[400],
                                          ),
                                          // ignore: deprecated_member_use
                                          RaisedButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, Check.routeName,
                                                  arguments: {
                                                    'subtotal': subtotal,
                                                    'x': x,
                                                  });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                'cash',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            color: Colors.blue[400],
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
                              );
                              //******************************* */
                            },
                            splashColor: Theme.of(ctx).splashColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Checkout',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Theme.of(ctx).textSelectionColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              Spacer(),
              Text(
                'Total:',
                style: TextStyle(
                    // ignore: deprecated_member_use
                    color: Theme.of(ctx).textSelectionColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'US ${subtotal.toStringAsFixed(3)}',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ));
  }
}
