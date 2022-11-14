import 'package:flutter/material.dart';

import '../widgets/text_widget.dart';

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
           Navigator.of(context).pop();
         },
       ),
       TextButton(
         child: TextWidget(text: 'Ok', textSize: 18, color: Colors.red,),
         onPressed: (){ function();
         Navigator.of(context).pop();
           },
       ),
     ],
   ));
 }

 static Future<void> errorDialog({

   required String subtitle,

   required BuildContext context,
 }) async {
   await showDialog(
       context: context,
       builder: (context) {
         return AlertDialog(
           title: Row(children: [
             Image.asset(
               'assets/images/warning-sign.png',
               height: 20,
               width: 20,
               fit: BoxFit.fill,
             ),
             const SizedBox(
               width: 8,
             ),
             const Text('An Error occurred'),
           ]),
           content: Text(subtitle),
           actions: [
             TextButton(
               onPressed: () {
                 if (Navigator.canPop(context)) {
                   Navigator.pop(context);
                 }
               },
               child: TextWidget(
                 color: Colors.cyan,
                 text: 'Ok',
                 textSize: 18,
               ),
             ),

           ],
         );
       });
 }
}
