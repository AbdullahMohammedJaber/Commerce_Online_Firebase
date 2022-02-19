import 'package:kdr_store/consts/theme_data.dart';
import 'package:kdr_store/inner_screens/product_details.dart';
import 'package:kdr_store/provider/dark_theme_provider.dart';
import 'package:kdr_store/provider/orders_provider.dart';
import 'package:kdr_store/provider/products.dart';
import 'package:kdr_store/screens/SplashScreen.dart';
import 'package:kdr_store/screens/about.dart';
import 'package:kdr_store/screens/auth/admin.dart';
import 'package:kdr_store/screens/cart/chexk.dart';
import 'package:kdr_store/screens/cart/paypal_methoe.dart';
import 'package:kdr_store/screens/contact.dart';
import 'package:kdr_store/screens/wishlist/wishlist.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'inner_screens/brands_navigation_rail.dart';
import 'inner_screens/categories_feeds.dart';
import 'screens/auth/forget_password.dart';
import 'screens/orders/order.dart';
import 'screens/upload_product_form.dart';
import 'provider/cart_provider.dart';
import 'provider/favs_provider.dart';
import 'screens/auth/login.dart';
import 'screens/auth/sign_up.dart';
import 'screens/bottom_bar.dart';
import 'screens/cart/cart.dart';
import 'screens/feeds.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    print('abdullah ,qedar');
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  String url = "https://www.youtube.com/watch?v=tJ86L4FYD-M";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: Text('Error occured'),
                ),
              ),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) {
                return themeChangeProvider;
              }),
              ChangeNotifierProvider(
                create: (_) => Products(),
              ),
              ChangeNotifierProvider(
                create: (_) => CartProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => FavsProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => OrdersProvider(),
              ),
            ],
            child: Consumer<DarkThemeProvider>(
              builder: (context, themeChangeProvider, ch) {
                return MaterialApp(
                  title: 'Flutter Shop',
                  theme:
                      Styles.themeData(themeChangeProvider.darkTheme, context),
                  home: Splash(),
                  //initialRoute: '/',
                  routes: {
                    //   '/': (ctx) => LandingPage(),
                    BrandNavigationRailScreen.routeName: (ctx) =>
                        BrandNavigationRailScreen(),
                    CartScreen.routeName: (ctx) => CartScreen(),
                    Feeds.routeName: (ctx) => Feeds(),
                    WishlistScreen.routeName: (ctx) => WishlistScreen(),
                    ProductDetails.routeName: (ctx) => ProductDetails(),
                    CategoriesFeedsScreen.routeName: (ctx) =>
                        CategoriesFeedsScreen(),
                    LoginScreen.routeName: (ctx) => LoginScreen(),
                    SignUpScreen.routeName: (ctx) => SignUpScreen(),
                    BottomBarScreen.routeName: (ctx) => BottomBarScreen(),
                    UploadProductForm.routeName: (ctx) => UploadProductForm(),
                    ForgetPassword.routeName: (ctx) => ForgetPassword(),
                    OrderScreen.routeName: (ctx) => OrderScreen(),
                    Check.routeName: (ctx) => Check(),
                    Contact.routeName: (ctx) => Contact(),
                    About1.routeName: (ctx) => About1(),
                    Admin.routeName: (ctx) => Admin(),
                    Paypal.routeName: (ctx) => Paypal(),
                  },
                );
              },
            ),
          );
        });
  }
}
/*
String clientId =
      'AUelptlsYggZYlW2J77MQjpyT55qPD8-i8QDWEDRrE_wxxyosa6a1cEcKs4Vo9kSg-_SRcAVYi9I7qvr';
  String secret =
      'EIgibdTeRRdztZSHRKJon_A_HHurBl5ZLBo0W-wIWIP_uhMftkzVSH8rdBd60t9bmkKyXj8wjgr7p3jB';
*/
