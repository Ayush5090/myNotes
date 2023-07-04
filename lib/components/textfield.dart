import 'package:flutter/material.dart';
import 'package:my_notes/provider/app_provider.dart';
import 'package:provider/provider.dart';

class mTextField extends StatelessWidget {
  String hint;
  TextEditingController controller;
  Icon prefixIcon;
  Icon? suffixIcon;
  mTextField({required this.hint, required this.controller, required this.prefixIcon,
  this.suffixIcon});
  @override
  Widget build(BuildContext context) {
    bool isObscure = context.watch<AppProvider>().getIsObscure();
    print(isObscure);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            spreadRadius: 1
          )
        ]
      ),
      child: TextFormField(
        controller: controller,
        obscureText: suffixIcon == null ? false : isObscure,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(13),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon == null ? null
              : InkWell(
              onTap: (){
                isObscure ? context.read<AppProvider>().setObscure(false)
                    : context.read<AppProvider>().setObscure(true);
              },
              child: Consumer<AppProvider>(
                builder: (ctx, provider, _) => isObscure ? Icon(Icons.visibility_off) : suffixIcon!,)),
          prefixIconColor: Colors.pink,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none
          ),
        ),
      ),
    );
  }
}
