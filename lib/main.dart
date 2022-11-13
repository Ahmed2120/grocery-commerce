import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grocery_commerce/provider/dark_theme_provider.dart';
import 'package:grocery_commerce/screens/auth/login.dart';
import 'package:grocery_commerce/screens/btm_bar_screen.dart';
import 'package:grocery_commerce/screens/home_page.dart';
import 'package:grocery_commerce/screens/orders/orders_screen.dart';
import 'package:grocery_commerce/screens/viewed_recently/viewed_recently.dart';
import 'package:grocery_commerce/screens/wishlist/wishlist_screen.dart';
import 'package:provider/provider.dart';

import 'consts/theme_data.dart';
import 'inner_screens/feeds_screen.dart';
import 'inner_screens/on_sale_screen.dart';
import 'inner_screens/prod_by_catScreen.dart';
import 'inner_screens/product_details.dart';
import 'provider/cart_provider.dart';
import 'provider/products_provider.dart';
import 'provider/viewed_prod_provider.dart';
import 'provider/wishlist_provider.dart';
import 'screens/auth/forget_pass.dart';
import 'screens/auth/register.dart';

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

  final _firebaseInitialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        else if(snapshot.hasError){
          const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('An error occurred'),
              ),
            ),
          );
        }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => darkThemeProvider),
            ChangeNotifierProvider(create: (_) => ProductsProvider()),
            ChangeNotifierProvider(create: (_) => CartProvider()),
            ChangeNotifierProvider(create: (_) => WishlistProvider()),
            ChangeNotifierProvider(create: (_) => ViewedProdProvider()),
          ],
          child: Consumer<DarkThemeProvider>(
            builder: (context, theme, child) => MaterialApp(
                title: 'Grocery Commerce',
                theme: Styles.themeData(theme.getDarkTheme, context),
                home: const BottomBarScreen(),
                routes: {
                  OnSaleScreen.routeName: (ctx) => const OnSaleScreen(),
                  FeedsScreen.routeName: (ctx) => const FeedsScreen(),
                  ProductDetails.routeName: (ctx) => const ProductDetails(),
                  WishlistScreen.routeName: (ctx) => const WishlistScreen(),
                  OrdersScreen.routeName: (ctx) => const OrdersScreen(),
                  ViewedRecentlyScreen.routeName: (ctx) =>
                      const ViewedRecentlyScreen(),
                  RegisterScreen.routeName: (ctx) => const RegisterScreen(),
                  LoginScreen.routeName: (ctx) => const LoginScreen(),
                  ForgetPasswordScreen.routeName: (ctx) =>
                      const ForgetPasswordScreen(),
                  ProdByCatScreen.routeName: (ctx) => const ProdByCatScreen(),
                }),
          ),
        );
      },
    );
  }
}
