import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'package:weather_app/viewmodel/phone_auth_service.dart';
import 'package:weather_app/view/widgets/auth_page.dart';

class PhoneOtpPage extends StatelessWidget {
  PhoneOtpPage({super.key});
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneCtrl = TextEditingController();
    TextEditingController otpCtrl = TextEditingController();
    final provider = Provider.of<PhoneOtpAuth>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset("assets/Animation - 1723141875176.json",
                    fit: BoxFit.contain, width: 300),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: phoneCtrl,
                      decoration: const InputDecoration(
                        prefix: Text("+91"),
                        prefixIcon: Icon(Icons.phone),
                        labelText: "Enter Phone Number",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.length != 10) return "invalid phone number";
                        return null;
                      },
                    ),
                  ),
                ),
                const Gap(20),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        provider.sentOtp(
                            phone: phoneCtrl.text,
                            errorStep: () => ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                        content: Text(
                                  "Error in sending otp ",
                                ))),
                            nextStep: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("otp verification"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text("Enter 6 digit Otp"),
                                      const Gap(15),
                                      Form(
                                        key: formKey1,
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          controller: otpCtrl,
                                          decoration: const InputDecoration(
                                            labelText: "Enter Phone Number",
                                            border: OutlineInputBorder(),
                                          ),
                                          validator: (value) {
                                            if (value!.length != 6) {
                                              return "invalid otp number";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          if (formKey1.currentState!
                                              .validate()) {
                                            provider
                                                .loginWithOtp(otp: otpCtrl.text)
                                                .then((value) {
                                              if (value == "Success") {
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                  builder: (context) =>
                                                      const AuthPage(),
                                                ));
                                              }
                                            });
                                          }
                                        },
                                        child: const Text("Submit"))
                                  ],
                                ),
                              );
                            });
                      }
                    },
                    style: const ButtonStyle(
                        elevation: WidgetStatePropertyAll(25),
                        backgroundColor: WidgetStatePropertyAll(Colors.amber)),
                    child: const Text("Send Otp"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
