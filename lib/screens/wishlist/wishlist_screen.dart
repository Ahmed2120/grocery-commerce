import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_commerce/widgits/empty_screen.dart';
import '../../services/global_methods.dart';
import '../../services/utils.dart';
import '../../widgits/back_widget.dart';
import '../../widgits/text_widget.dart';
import 'wishlist_widget.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = "/WishlistScreen";

  const WishlistScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    bool isEmpty = true;

    return isEmpty
        ? const EmptyScreen(
            imagePath: 'assets/images/wishlist.png',
            title: 'Your Wishlist Is Empty',
            subtitle: 'Explore more and shortlist more items',
            buttonText: 'Add a wish')
        : Scaffold(
            appBar: AppBar(
                centerTitle: true,
                leading: const BackWidget(),
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title: TextWidget(
                  text: 'Wishlist (2)',
                  color: color,
                  isTitle: true,
                  textSize: 22,
                ),
                actions: [
                  IconButton(
                    onPressed: () => GlobalMethods.showMessageDialog(
                        title: 'Empty Your Wishlist',
                        subTitle: "Are you sure?",
                        context: context,
                        function: () {}),
                    icon: Icon(
                      IconlyBroken.delete,
                      color: color,
                    ),
                  ),
                ]),
            body: MasonryGridView.count(
              crossAxisCount: 2,
              // mainAxisSpacing: 16,
              // crossAxisSpacing: 20,
              itemBuilder: (context, index) {
                return const WishlistWidget();
              },
            ));
  }
}
