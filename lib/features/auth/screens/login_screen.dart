import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watsapp/colors.dart';
import 'package:watsapp/common/utils/utils.dart';
import 'package:watsapp/common/widgets/custom_button.dart';
import 'package:watsapp/features/auth/controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  static const routeName = "/login-screen";

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  Country? country;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void pickCounter(){
    showCountryPicker(context: context, onSelect: (Country _country){
      setState(() {
        country = _country;
      });
    });
  }

  void sendPhoneNumber(){
    var phoneNumber = phoneController.text.trim();
    if(country !=null && phoneNumber.isNotEmpty){
      ref.read(authControllerProvider).signInWithPhone(context, "+${country?.phoneCode}$phoneNumber");
    }else{
      showSnackBar(context: context, content: "Fill out all the fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter your phone number"),
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("WhatsApp will need to verify phone number."),
              const SizedBox(height: 10),
              TextButton(onPressed: pickCounter, child: const Text("Pick Country")),
              Row(
                children: [
                  if(country!=null) Text("+${country!.phoneCode}"),
                 const SizedBox(height: 10),
                  SizedBox(
                    width: size.width * 0.7,
                    child: TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        hintText: "phone number",
                      ),
                    ),
                  )
                ],
              ),
              const Spacer(),
              SizedBox(child: CustomButton(text: "Next",ontap: sendPhoneNumber,))
            ],
          ),
        ),
      ),
    );
  }
}
