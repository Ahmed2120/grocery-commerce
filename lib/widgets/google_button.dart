import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery_commerce/consts/firebase_consts.dart';
import 'package:grocery_commerce/services/global_methods.dart';

import '../screens/btm_bar_screen.dart';
import 'text_widget.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  Future<void> _googleSignIn(context) async{
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if(googleUser == null) return;
      try{
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
        );
        authInstance.signInWithCredential(credential);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const BottomBarScreen()));

      }on FirebaseException catch(error){
        // GlobalMethods.errorDialog(subtitle: error.message!, context: context);
      }catch(error){

      }finally{

      }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: InkWell(
        onTap: () {_googleSignIn(context);},
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            color: Colors.white,
            child: Image.asset(
              'assets/images/google.png',
              width: 40.0,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          TextWidget(
              text: 'Sign in with google', color: Colors.white, textSize: 18)
        ]),
      ),
    );
  }
}
