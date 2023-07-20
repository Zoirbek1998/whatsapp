import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watsapp/common/widgets/error.dart';
import 'package:watsapp/features/auth/screens/login_screen.dart';
import 'package:watsapp/features/auth/screens/otp_screen.dart';
import 'package:watsapp/features/auth/screens/user_information_screen.dart';
import 'package:watsapp/features/select_contacys/screens/select_contacs_screen.dart';
import 'package:watsapp/features/chat/screens/mobile_chat_screen.dart';
import 'package:watsapp/features/status/screens/confirm_status_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      );
    case OTPScreen.routeName:
      final verificationId = settings.arguments;
      return MaterialPageRoute(
        builder: (_) => OTPScreen(verificationId: verificationId.toString()),
      );
    case UserInformationScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const UserInformationScreen(),
      );
    case SelectContactsScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const SelectContactsScreen(),
      );
    case MobileChatScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments["name"];
      final uid = arguments["uid"];
      return MaterialPageRoute(
        builder: (_) => MobileChatScreen(
          name: name,
          uid: uid,
        ),
      );
    case ConfirmStatusScreen.routeName:
      final file = settings.arguments as File;
      return MaterialPageRoute(
        builder: (_) => ConfirmStatusScreen(file: file),
      );

    default:
      return MaterialPageRoute(
          builder: (_) => const ErrorScreen(
                error: "This page doesn't exist",
              ));
  }
}
