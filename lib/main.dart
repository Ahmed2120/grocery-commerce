import 'package:flutter/material.dart';
import 'package:grocery_commerce/provider/dark_theme_provider.dart';
import 'package:grocery_commerce/screens/btm_bar_screen.dart';
import 'package:grocery_commerce/screens/home_page.dart';
import 'package:provider/provider.dart';

import 'consts/theme_data.dart';
import 'inner_screens/feeds_screen.dart';
import 'inner_screens/on_sale_screen.dart';
import 'inner_screens/product_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  DarkThemeProvider darkThemeProvider = DarkThemeProvider();

  getCurrentTheme() async {
    print('restarted');
    darkThemeProvider.setDarkTheme =
        await darkThemeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    super.initState();

    getCurrentTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> darkThemeProvider),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, theme, child)=> MaterialApp(
          title: 'Grocery Commerce',
          theme: Styles.themeData(theme.getDarkTheme, context),
          home: const BottomBarScreen(),
            routes: {
              OnSaleScreen.routeName: (ctx) => const OnSaleScreen(),
              FeedsScreen.routeName: (ctx) => const FeedsScreen(),
              ProductDetails.routeName: (ctx) => const ProductDetails(),
            }
        ),
      ),
    );
  }
}
