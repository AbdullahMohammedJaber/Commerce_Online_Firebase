import 'package:kdr_store/inner_screens/categories_feeds.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  CategoryWidget({Key key, this.index}) : super(key: key);
  final int index;

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  List<Map<String, Object>> categories = [
    {
      'categoryName': 'Laptops',
      'categoryImagesPath': 'assets/images/laptop.jpg',
    },
    {
      'categoryName': 'CPU',
      'categoryImagesPath': 'assets/images/cpu.jpg',
    },
    {
      'categoryName': 'GPU',
      'categoryImagesPath': 'assets/images/gpu.jpg',
    },
    {
      'categoryName': 'RAM',
      'categoryImagesPath': 'assets/images/ram.jpg',
    },
    {
      'categoryName': 'motherboard',
      'categoryImagesPath': 'assets/images/mather.jpg',
    },
    {
      'categoryName': 'PC',
      'categoryImagesPath': 'assets/images/pc.jpg',
    },
    {
      'categoryName': 'keyboard',
      'categoryImagesPath': 'assets/images/kybord.jpg',
    },
    {
      'categoryName': 'mouse',
      'categoryImagesPath': 'assets/images/muse.jpeg',
    },
    {
      'categoryName': 'Hard HHD',
      'categoryImagesPath': 'assets/images/hardhhd.jpg',
    },
    {
      'categoryName': 'Hard SSD',
      'categoryImagesPath': 'assets/images/ssd.jpg',
    },
    {
      'categoryName': 'keyboard switch',
      'categoryImagesPath': 'assets/images/switch.jpg',
    },
    {
      'categoryName': 'LED PC',
      'categoryImagesPath': 'assets/images/led.jpg',
    },
    {
      'categoryName': 'Xbox',
      'categoryImagesPath': 'assets/images/xpox.jpg',
    },
    {
      'categoryName': 'USP',
      'categoryImagesPath': 'assets/images/usp.jpeg',
    },
    {
      'categoryName': 'monitors',
      'categoryImagesPath': 'assets/images/monitors.jpg',
    },
    {
      'categoryName': 'Table PC',
      'categoryImagesPath': 'assets/images/table.jpg',
    },
    {
      'categoryName': 'head phone',
      'categoryImagesPath': 'assets/images/head phone.jpg',
    },
    {
      'categoryName': 'Stand laptop',
      'categoryImagesPath': 'assets/images/standlap.jpg',
    },
    {
      'categoryName': 'Stand PC',
      'categoryImagesPath': 'assets/images/standpc.jpg',
    },
    {
      'categoryName': 'Microphone',
      'categoryImagesPath': 'assets/images/mic.jpg',
    },
    {
      'categoryName': 'Camera',
      'categoryImagesPath': 'assets/images/camera.jpg',
    },
    {
      'categoryName': 'Speacker',
      'categoryImagesPath': 'assets/images/speacker.jpg',
    },
    {
      'categoryName': 'mouse pad',
      'categoryImagesPath': 'assets/images/pad.jpg',
    },
    {
      'categoryName': 'accessories',
      'categoryImagesPath': 'assets/images/accessories.jpeg',
    },
    {
      'categoryName': 'Chair',
      'categoryImagesPath': 'assets/images/chair.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(CategoriesFeedsScreen.routeName,
                arguments: '${categories[widget.index]['categoryName']}');
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage(
                      categories[widget.index]['categoryImagesPath']),
                  fit: BoxFit.cover),
            ),
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 150,
            height: 150,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 10,
          right: 10,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            color: Theme.of(context).backgroundColor,
            child: Text(
              categories[widget.index]['categoryName'],
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Theme.of(context).textSelectionColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
/*
 {
      'categoryName': 'Laptops',
      'categoryImagesPath': 'assets/images/laptop.jpg',
    },
    {
      'categoryName': 'CPU',
      'categoryImagesPath': 'assets/images/cpu.jpg',
    },
    {
      'categoryName': 'GPU',
      'categoryImagesPath': 'assets/images/gpu.jpg',
    },
    {
      'categoryName': 'RAM',
      'categoryImagesPath': 'assets/images/ram.jpg',
    },
    {
      'categoryName': 'motherboard',
      'categoryImagesPath': 'assets/images/mather.jpg',
    },
    {
      'categoryName': 'PC',
      'categoryImagesPath': 'assets/images/pc.jpg',
    },
    {
      'categoryName': 'keyboard',
      'categoryImagesPath': 'assets/images/kybord.jpg',
    },
    {
      'categoryName': 'mouse',
      'categoryImagesPath': 'assets/images/muse.jpeg',
    },
    {
      'categoryName': 'Hard HHD',
      'categoryImagesPath': 'assets/images/hardhhd.jpg',
    },
    {
      'categoryName': 'Hard SSD',
      'categoryImagesPath': 'assets/images/ssd.jpg',
    },
    {
      'categoryName': 'keyboard switch',
      'categoryImagesPath': 'assets/images/switch.jpg',
    },
    {
      'categoryName': 'LED PC',
      'categoryImagesPath': 'assets/images/led.jpg',
    },
    {
      'categoryName': 'Xbox',
      'categoryImagesPath': 'assets/images/xpox.jpg',
    },
    {
      'categoryName': 'USP',
      'categoryImagesPath': 'assets/images/usp.jpeg',
    },
    {
      'categoryName': 'monitors',
      'categoryImagesPath': 'assets/images/monitors.jpg',
    },
    {
      'categoryName': 'Table PC',
      'categoryImagesPath': 'assets/images/table.jpg',
    },
    {
      'categoryName': 'head phone',
      'categoryImagesPath': 'assets/images/head phone.jpg',
    },
    {
      'categoryName': 'Stand laptop',
      'categoryImagesPath': 'assets/images/standlap.jpg',
    },
    {
      'categoryName': 'Stand PC',
      'categoryImagesPath': 'assets/images/standpc.jpg',
    },
    {
      'categoryName': 'Microphone',
      'categoryImagesPath': 'assets/images/mic.jpg',
    },
    {
      'categoryName': 'Camera',
      'categoryImagesPath': 'assets/images/camera.jpg',
    },
    {
      'categoryName': 'Speacker',
      'categoryImagesPath': 'assets/images/speacker.jpg',
    },
    {
      'categoryName': 'mouse pad',
      'categoryImagesPath': 'assets/images/pad.jpg',
    },
    {
      'categoryName': 'accessories',
      'categoryImagesPath': 'assets/images/accessories.jpeg',
    },
    {
      'categoryName': 'Chair',
      'categoryImagesPath': 'assets/images/chair.jpg',
    },

*/