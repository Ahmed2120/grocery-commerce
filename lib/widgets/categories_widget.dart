import 'package:flutter/material.dart';
import 'package:grocery_commerce/model/category.dart';
import 'package:grocery_commerce/screens/categories_screen.dart';
import '../inner_screens/prod_by_catScreen.dart';
import 'text_widget.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget(
      {Key? key,
      required this.category,
      required this.passedColor})
      : super(key: key);
  final Category category;
  final Color passedColor;
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    final themeState = Provider.of<DarkThemeProvider>(context);
    double _screenWidth = MediaQuery.of(context).size.width;
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(ProdByCatScreen.routeName, arguments: category.id); // categoryId
      },
      child: Container(
        // height: _screenWidth * 0.6,
        decoration: BoxDecoration(
          color: passedColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: passedColor.withOpacity(0.7),
            width: 2,
          ),
        ),
        child: Column(children: [
          // Container for the image
          Container(
            height: _screenWidth * 0.3,
            width: _screenWidth * 0.3,
            decoration:  BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                  category.image,
                  ),
                  fit: BoxFit.fill),
            ),
          ),
          // Category name
          TextWidget(
            text: category.name,
            color: color,
            textSize: 20,
            isTitle: true,
          ),
        ]),
      ),
    );
  }
}
