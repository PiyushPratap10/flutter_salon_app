import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/screens/tabs.dart';


class NumberLogin extends StatefulWidget {
  const NumberLogin({super.key});

  static String verify = '';
  @override
  State<NumberLogin> createState() {
    return _NumberLoginState();
  }
}

class _NumberLoginState extends State<NumberLogin> {
  final TextEditingController _numberController = TextEditingController();
  var _error = '';
  var number = '';
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
                          height: 30,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: _numberController,
                          decoration: const InputDecoration(
                              labelText: 'Enter your number',
                              suffixIcon: Icon(Icons.phone_in_talk_outlined)),
                        ),
                        Text(
                          _error,
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 45),
                        InkWell(
                          onTap: () {
                            number = _numberController.text;
                            _error = _numberController.text.length != 10
                                ? "Enter a valid number"
                                : "";
                            if (_error == '') {
                              setState(() async {
                                await FirebaseAuth.instance.verifyPhoneNumber(
                                  phoneNumber: '+91$number',
                                  verificationCompleted:
                                      (PhoneAuthCredential credential) {},
                                  verificationFailed:
                                      (FirebaseAuthException e) {},
                                  codeSent: (String verificationId,
                                      int? resendToken) {
                                    NumberLogin.verify = verificationId;
                                    Navigator.pushReplacementNamed(context, 'otp');
                                  },
                                  codeAutoRetrievalTimeout:
                                      (String verificationId) {},
                                );
                              });
                            } else {
                              setState(() {});
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
                        Icons.account_circle,
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
