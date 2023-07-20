import 'package:flutter/material.dart';
import 'package:watsapp/colors.dart';
import 'package:watsapp/common/widgets/custom_button.dart';
import 'package:watsapp/features/auth/screens/login_screen.dart';
import 'package:watsapp/generated/assets.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  void navigateToLoginScreen(BuildContext context){
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Text(
              "Welcome to Whatsapp",
              style: TextStyle(fontSize: 33, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: size.height / 9),
            Image.asset(
              Assets.assetsBg,
              height: size.height / 3,
              width: size.height / 3,
              color: tabColor,
            ),
            SizedBox(height: size.height / 9),
            const Padding(
              padding:  EdgeInsets.all(15.0),
              child: Text(
                "Read our Privacy Policy. Tap Agree and continue to accont the Terme of Service",
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
                width: size.width*0.75,
                child: CustomButton(text: "AGREE AND CONTINUE",ontap: ()=> navigateToLoginScreen(context),))
          ],
        ),
      ),
    );
  }
}
