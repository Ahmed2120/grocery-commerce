import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_commerce/screens/viewed_recently/viewed_widget.dart';
import 'package:provider/provider.dart';

import '../../provider/viewed_prod_provider.dart';
import '../../services/global_methods.dart';
import '../../services/utils.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/empty_screen.dart';
import '../../widgets/text_widget.dart';

class ViewedRecentlyScreen extends StatefulWidget {
  static const routeName = '/ViewedRecentlyScreen';

  const ViewedRecentlyScreen({Key? key}) : super(key: key);

  @override
  _ViewedRecentlyScreenState createState() => _ViewedRecentlyScreenState();
}

class _ViewedRecentlyScreenState extends State<ViewedRecentlyScreen> {
  bool check = true;
  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).color;
    // Size size = Utils(context).getScreenSize;
    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    final viewedItemsList = viewedProdProvider.getWishlistItems;

    return viewedItemsList.isEmpty
        ? const EmptyScreen(
        imagePath: 'assets/images/history.png',
        title: "Your History Is Empty",
        subtitle: 'Now Product has been viewed yet!',
        buttonText: 'shop now')
        : Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              GlobalMethods.showMessageDialog(
                  title: 'Empty your history?',
                  subTitle: 'Are you sure?',
                  function: () => viewedProdProvider.removeAllItems(),
                  context: context);
            },
            icon: Icon(
              IconlyBroken.delete,
              color: color,
            ),
          )
        ],
        leading: const BackWidget(),
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: TextWidget(
          text: 'History',
          color: color,
          textSize: 24.0,
        ),
        backgroundColor:
            Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
      ),
      body: ListView.builder(
          itemCount: viewedItemsList.length,
          itemBuilder: (ctx, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
              child: ChangeNotifierProvider.value(
                  value: viewedItemsList[index],
                  child: const ViewedRecentlyWidget()),
            );
          }),
    );
  }
}
