import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/components/elevated_btn.dart';
import 'package:my_notes/components/textfield.dart';
import 'package:my_notes/screens/home_screen.dart';
import 'package:my_notes/screens/user_onboard/signup_screen.dart';
import 'package:my_notes/ui_helper/ui_helper.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width*0.075, vertical: size.height*0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/login.jpg',
                width: size.width, height: size.height*0.37, fit: BoxFit.fitHeight,),
              SizedBox(height: size.height*0.02,),
              Text('Welcome', style: mTextStyle25(fontWeight: FontWeight.w700),),
              Text('Login here to continue', style: mTextStyle12(color: Colors.grey[700]),),
              SizedBox(height: size.height*0.05,),
              mTextField(hint: 'Email', controller: emailController, prefixIcon: Icon(Icons.email)),
              SizedBox(height: size.height*0.025,),
              mTextField(hint: 'Password', controller: passController, prefixIcon: Icon(Icons.lock), suffixIcon: Icon(Icons.visibility),),
              SizedBox(height: size.height*0.055,),
              AppBtn(childText: 'Login', onPressed: () async{
                try{
                  UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text.trim().toString(), password: passController.text.trim().toString());
                  if(user != null) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                } on FirebaseAuthException catch(e){
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.message.toString()))
                  );
                }
              },),
              SizedBox(height: size.height*0.015,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen(),)),
                    child: RichText(text: TextSpan(text: 'Don\'t have an account ', style: mTextStyle15(fontWeight: FontWeight.w400),
                    children: [
                      TextSpan(text: 'Create', style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.w700)),
                    ]),),
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
