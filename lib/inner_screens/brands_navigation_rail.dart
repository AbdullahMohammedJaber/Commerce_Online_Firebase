// ignore: duplicate_ignore
// ignore: duplicate_ignore
// ignore_for_file: duplicate_import, duplicate_ignore, duplicate_ignore

// ignore_for_file: duplicate_import
// ignore: duplicate_import
// ignore: duplicate_import

// ignore_for_file: duplicate_import

// ignore_for_file: duplicate_import

import 'package:kdr_store/provider/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:kdr_store/provider/products.dart';
import 'package:provider/provider.dart';

import 'brands_rail_widget.dart';

class BrandNavigationRailScreen extends StatefulWidget {
  BrandNavigationRailScreen({Key key}) : super(key: key);

  static const routeName = '/brands_navigation_rail';
  @override
  _BrandNavigationRailScreenState createState() =>
      _BrandNavigationRailScreenState();
}

class _BrandNavigationRailScreenState extends State<BrandNavigationRailScreen> {
  int _selectedIndex = 0;
  final padding = 8.0;
  String routeArgs;
  String brand;
  @override
  void didChangeDependencies() {
    routeArgs = ModalRoute.of(context).settings.arguments.toString();
    _selectedIndex = int.parse(
      routeArgs.substring(1, 2),
    );
    print(routeArgs.toString());
    if (_selectedIndex == 0) {
      setState(() {
        brand = 'msi';
      });
    }
    if (_selectedIndex == 1) {
      setState(() {
        brand = 'core';
      });
    }
    if (_selectedIndex == 2) {
      setState(() {
        brand = 'hp';
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: NavigationRail(
                      minWidth: 56.0,
                      groupAlignment: 1.0,
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (int index) {
                        setState(() {
                          _selectedIndex = index;
                          if (_selectedIndex == 0) {
                            setState(() {
                              brand = 'msi';
                            });
                          }
                          if (_selectedIndex == 1) {
                            setState(() {
                              brand = 'core';
                            });
                          }
                          if (_selectedIndex == 2) {
                            setState(() {
                              brand = 'hp';
                            });
                          }

                          print(brand);
                        });
                      },
                      labelType: NavigationRailLabelType.all,
                      leading: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: CircleAvatar(
                              radius: 16,
                              backgroundImage: NetworkImage(
                                  "https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg"),
                            ),
                          ),
                          SizedBox(
                            height: 80,
                          ),
                        ],
                      ),
                      selectedLabelTextStyle: TextStyle(
                        color: Color(0xffffe6bc97),
                        fontSize: 20,
                        letterSpacing: 1,
                        decoration: TextDecoration.underline,
                        decorationThickness: 2.5,
                      ),
                      unselectedLabelTextStyle: TextStyle(
                        fontSize: 15,
                        letterSpacing: 0.8,
                      ),
                      destinations: [
                        buildRotatedTextRailDestination('msi', padding),
                        buildRotatedTextRailDestination("core", padding),
                        buildRotatedTextRailDestination("hp", padding),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          // This is the main content.

          ContentSpace(context, brand)
        ],
      ),
    );
  }
}

NavigationRailDestination buildRotatedTextRailDestination(
    String text, double padding) {
  return NavigationRailDestination(
    icon: SizedBox.shrink(),
    label: Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: RotatedBox(
        quarterTurns: -1,
        child: Text(text),
      ),
    ),
  );
}

class ContentSpace extends StatelessWidget {
  // final int _selectedIndex;

  final String brand;
  ContentSpace(BuildContext context, this.brand);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context, listen: false);
    final productsBrand = productsData.findByBrand(brand);
    if (brand == 'All') {
      for (int i = 0; i < productsData.products.length; i++) {
        productsBrand.add(productsData.products[i]);
      }
    }
    // print('productsBrand ${productsBrand[0].imageUrl}');
    print('brand $brand');
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 0, 0),
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: productsBrand.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Feather.database,
                      size: 80,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'No products related to this brand',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: productsBrand.length,
                  itemBuilder: (BuildContext context, int index) =>
                      ChangeNotifierProvider.value(
                          value: productsBrand[index],
                          child: BrandsNavigationRail()),
                ),
        ),
      ),
    );
  }
}
