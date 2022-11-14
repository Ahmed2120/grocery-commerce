import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_commerce/widgets/text_widget.dart';

class NewListTile extends StatelessWidget {
  const NewListTile({
    Key? key, required this.title, this.subTitle, required this.icon, required this.function,
  }) : super(key: key);

  final String title;
  final String? subTitle;
  final IconData icon;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextWidget(text: title, textSize: 22, isTitle: true,),
      subtitle: TextWidget(text: subTitle ?? '', textSize: 18),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: ()=> function(),
    );
  }
}