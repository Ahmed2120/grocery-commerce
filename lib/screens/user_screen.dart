import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_commerce/screens/auth/login.dart';
import 'package:grocery_commerce/screens/viewed_recently/viewed_recently.dart';
import 'package:grocery_commerce/screens/wishlist/wishlist_screen.dart';
import 'package:grocery_commerce/services/global_methods.dart';
import 'package:provider/provider.dart';

import '../consts/firebase_consts.dart';
import '../provider/dark_theme_provider.dart';
import '../widgets/newListTile.dart';
import '../widgets/text_widget.dart';
import 'orders/orders_screen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final User? user = authInstance.currentUser;

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              RichText(
                  text: TextSpan(
                      text: 'Hi,  ',
                      style: const TextStyle(
                          fontSize: 27,
                          color: Colors.cyan,
                          fontWeight: FontWeight.bold),
                      children: [
                    TextSpan(
                      text: 'Name',
                      style: TextStyle(
                          fontSize: 27,
                          color: color,
                          fontWeight: FontWeight.bold),
                    )
                  ])),
              const SizedBox(
                height: 5,
              ),
              TextWidget(text: 'ahmad@gmail.com', textSize: 20),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(
                height: 15,
              ),
              NewListTile(
                title: 'Address',
                subTitle: 'sdsd',
                icon: IconlyLight.profile,
                function: () => showAddressDialog(),
              ),
              NewListTile(
                title: 'Orders',
                icon: IconlyLight.bag,
                function: ()=> GlobalMethods.navigateTo(
                  ctx: context, routeName: OrdersScreen.routeName),
              ),
              NewListTile(
                title: 'Wishlist',
                icon: IconlyLight.heart,
                function: () {
                  if(user == null){
                    GlobalMethods.errorDialog(subtitle: 'Please login first.', context: context);
                    return;
                  }
                  GlobalMethods.navigateTo(
                    ctx: context, routeName: WishlistScreen.routeName);},
              ),
              NewListTile(
                title: 'Viewed',
                icon: IconlyLight.show,
                function: () {
                  if(user == null){
                    GlobalMethods.errorDialog(subtitle: 'Please login first.', context: context);
                    return;
                  }
                  GlobalMethods.navigateTo(
                    ctx: context, routeName: ViewedRecentlyScreen.routeName);},
              ),
              NewListTile(
                title: 'Change password',
                icon: IconlyLight.unlock,
                function: () {},
              ),
              SwitchListTile(
                title: TextWidget(
                  text: 'Theme mode',
                  textSize: 24,
                  isTitle: true,
                ),
                secondary: Icon(themeState.getDarkTheme
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined),
                onChanged: (bool value) {
                  setState(() {
                    themeState.setDarkTheme = value;
                  });
                },
                value: themeState.getDarkTheme,
              ),
              NewListTile(
                title: user == null ? 'Login' : 'Logout',
                icon: user == null ? IconlyLight.login : IconlyLight.logout,
                function: () {
                  if(user == null) {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const LoginScreen()));
                  }
                  else{
                  GlobalMethods.showMessageDialog(
                    title: 'Logout',
                    subTitle: "Do you want to logout?",
                    context: context,
                    function: () {
                      authInstance.signOut();
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const LoginScreen()));
                    });}
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showAddressDialog() {
    final GlobalKey<FormState> formKey = GlobalKey();
    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(IconlyBold.location),
        title: const Text('Edit Address'),
        content: SingleChildScrollView(
          child: SizedBox(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(hintText: 'your address'),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Type a correct address';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      child: const Text('update'), onPressed: () => {})
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}