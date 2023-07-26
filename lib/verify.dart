import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth/HomePage.dart';
import 'package:phone_auth/phone.dart';
import 'package:pinput/pinput.dart';

class MyVerify extends StatefulWidget {
  const MyVerify({super.key});

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {
  FirebaseAuth auth = FirebaseAuth.instance;
  var code = "";
  @override
  Widget build(BuildContext context) {

 final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle:const TextStyle(
    fontSize: 20,
    color: Color.fromRGBO(30,60,87,1),
    fontWeight: FontWeight.w600
  ),
  decoration: BoxDecoration(
    border: Border.all(color:const Color.fromRGBO(234,239,243,1)),
    borderRadius: BorderRadius.circular(20),
  )
 );

 final focushedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: const Color.fromRGBO(114,178,238,1)),
  borderRadius: BorderRadius.circular(8),
 );

 final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration?.copyWith(
    color: const Color.fromRGBO(234,239,243,1),
  )
 );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon:const Icon(Icons.arrow_back,color: Colors.black,),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/img2.png",
                width: 250,
                height: 250,
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Phone Verification",
                style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30,),

              Pinput(
                onChanged: (value) {
                  code = value;
                },
                length: 6,
                showCursor: true,
                onCompleted: (pin) => print(pin),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  onPressed: () async{
                    try {
                      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: Phone.verified1, smsCode: code);
                      await auth.signInWithCredential(credential);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
                      }catch(e) {print("Wrong OTP");}
                  },

                  child: const Text("Verify Phone Number",style: TextStyle(
                    fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold
                  ),),
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, 'phone', (route) => false);
                    },
                    child: const Text(
                      "Edit Phone Number?",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}