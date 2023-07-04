import 'package:flutter/cupertino.dart';

class AppProvider extends ChangeNotifier{
  bool isObscure = false;

  bool getIsObscure(){
    return isObscure;
  }
  setObscure(bool value){
    isObscure = value;
    notifyListeners();
  }
}