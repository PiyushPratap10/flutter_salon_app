import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:salon_app/screens/phone.dart';
import 'package:salon_app/screens/tabs.dart';


class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});
  @override
  State<OtpScreen> createState() {
    return _OtpScreenState();
  }
}

class _OtpScreenState extends State<OtpScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var code;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (ctx) => const TabsScreen()));
              },
              child: const Text(
                'skip',
                style: TextStyle(
                    color: Colors.red,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.red),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Image(image: AssetImage('assets/images/logo.png')),
              const SizedBox(
                height: 70,
              ),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: Colors.black45),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 35,
                        ),
                        Pinput(
                          onChanged: (value) {
                            code = value;
                          },
                          length: 6,
                          pinputAutovalidateMode:
                              PinputAutovalidateMode.onSubmit,
                          showCursor: true,
                        ),
                        const SizedBox(height: 45),
                        InkWell(
                          onTap: () async {
                            try {
                              PhoneAuthCredential credential =
                                  PhoneAuthProvider.credential(
                                      verificationId: NumberLogin.verify,
                                      smsCode: code);

                              await auth.signInWithCredential(credential);
                              Navigator.pushNamedAndRemoveUntil(
                                  context, 'tab', (route) => false);
                            } catch (e) {
                              print('wrong otp');
                            }
                          },
                          child: Card(
                            child: Container(
                              height: 45,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 25, 21, 48),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: const Text(
                                'CONTINUE',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'By continuing you are agree to our',
                          style: TextStyle(fontSize: 13),
                        ),
                        const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Terms & Conditions ',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.blue),
                            ),
                            Text(
                              'and',
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              ' Privacy Policy',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.blue),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: -55,
                    child: Container(
                      width: 90,
                      color: Theme.of(context).canvasColor,
                      child: const Icon(
                        Icons.lock_outline,
                        size: 90,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
