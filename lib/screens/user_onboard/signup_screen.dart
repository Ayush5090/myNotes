import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../components/elevated_btn.dart';
import '../../components/textfield.dart';
import '../../ui_helper/ui_helper.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confPassController = TextEditingController();

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
              Image.asset('assets/images/signup.png',
                width: size.width, height: size.height*0.25, fit: BoxFit.fitHeight,),
              Text('Welcome', style: mTextStyle25(fontWeight: FontWeight.w700),),
              Text('Create account here', style: mTextStyle12(color: Colors.grey[700]),),
              SizedBox(height: size.height*0.05,),
              mTextField(hint: 'Email', controller: emailController, prefixIcon: Icon(Icons.email)),
              SizedBox(height: size.height*0.025,),
              mTextField(hint: 'Password', controller: passController, prefixIcon: Icon(Icons.lock), suffixIcon: Icon(Icons.visibility)),
              SizedBox(height: size.height*0.025,),
              mTextField(hint: 'Confirm Password', controller: confPassController, prefixIcon: Icon(Icons.lock), suffixIcon: Icon(Icons.visibility)),
              SizedBox(height: size.height*0.055,),
              AppBtn(childText: 'Create Account', onPressed: () async{
                if(emailController.text.isEmpty || passController.text.isEmpty || confPassController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter all the fields'))
                  );
                } else if(passController.text.trim() == confPassController.text.trim()){
                    try{
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: emailController.text.trim().toString(), password: passController.text.trim().toString());
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Account Created login to continue'))
                      );
                    } on FirebaseAuthException catch(e){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.message.toString()))
                      );
                    }
                  } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Password do not match'))
                  );
                }
                }
              ),
              SizedBox(height: size.height*0.015,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: ()=> Navigator.pop(context),
                    child: RichText(text: TextSpan(text: 'Already have an account ', style: mTextStyle15(fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(text: 'Login', style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.w700)),
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
