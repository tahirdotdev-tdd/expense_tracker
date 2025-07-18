import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoogleSigninButton extends StatefulWidget {
  const GoogleSigninButton({super.key});

  @override
  State<GoogleSigninButton> createState() => _GoogleSigninButtonState();
}

class _GoogleSigninButtonState extends State<GoogleSigninButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        height:52 ,
        width: 363,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 1.5,color: Color(0xffCCCCCE))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/google_logo.png",height: 18,),
            const SizedBox(width: 8,),
            Text("Sign in with Google",style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600
            ),)
          ],
        ),
      ),
    );
  }
}
