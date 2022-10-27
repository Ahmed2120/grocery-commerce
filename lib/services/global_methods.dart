import 'package:flutter/material.dart';

import '../widgits/text_widget.dart';

class GlobalMethods {
 static  navigateTo({required BuildContext ctx, required String routeName}) {
    Navigator.pushNamed(ctx, routeName);
  }

  static void showMessageDialog({required String title, required String subTitle, required BuildContext context, required Function function, }){
   showDialog(context: context, builder: (ctx)=> AlertDialog(
     title: Text(title),
     content: Text(subTitle),
     actions: [
       TextButton(
         child: TextWidget(text: 'Cancel', textSize: 18, color: Colors.cyan,),
         onPressed: (){
           Navigator.of(context).pop(false);
         },
       ),
       TextButton(
         child: TextWidget(text: 'Ok', textSize: 18, color: Colors.red,),
         onPressed: ()=> function(),
       ),
     ],
   ));
 }
}
