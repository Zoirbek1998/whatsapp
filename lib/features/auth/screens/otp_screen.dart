import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watsapp/features/auth/controller/auth_controller.dart';

import '../../../colors.dart';

class OTPScreen extends ConsumerWidget {
  static const String routeName = "/otp-screen";
  final String verificationId;

  const OTPScreen({super.key, required this.verificationId});

  void verifyOTP(WidgetRef ref, BuildContext context, String userOTP) {
    ref
        .read(authControllerProvider)
        .verifyOTP(context, verificationId, userOTP);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verifiying your number"),
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text('We have sent an SMS with a code.'),
          Center(
            child: SizedBox(
              width: size.width * 0.5,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: '- - - - - -',
                  hintStyle: TextStyle(fontSize: 30),
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  if(val.length==6){
                    verifyOTP(ref, context, val.trim());
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
