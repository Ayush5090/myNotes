import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/components/circular_container.dart';
import 'package:my_notes/ui_helper/ui_helper.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  late FirebaseFirestore firestore;
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width*0.05, vertical: size.height*0.017),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                        child: CircularContainer(icon: Icon(Icons.arrow_back, color: Colors.white,))),
                    Spacer(),
                    CircularContainer(icon: Icon(Icons.favorite_border, color: Colors.white,)),
                    SizedBox(width: size.width*0.03,),
                    InkWell(
                      onTap: (){
                        if(titleController.text.isEmpty || desController.text.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please enter both the fields first'))
                          );
                        } else {
                          firestore.collection('users').doc(currentUser!.email).collection('notes').add({
                            'title' : titleController.text.toString(),
                            'des' : desController.text.toString()
                          }).then((value){
                            titleController.clear();
                            desController.clear();
                            Navigator.pop(context);
                          });
                        }
                      },
                      child: Container(
                        width: size.width*0.25, height: size.height*0.07,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text('Save', style: mTextStyle15(color: Colors.white),),
                      ),
                    )
                  ],
                ),
                TextField(
                  controller: titleController,
                  minLines: 1,
                  maxLines: 2,
                  cursorColor: Colors.black,
                  style: TextStyle(fontSize: 35,),
                  decoration: InputDecoration(
                    hintText: 'Note Title',
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none
                    )
                  ),
                ),
                SizedBox(height: size.height*0.02,),
                Divider(color: Colors.grey[400]),
                SizedBox(height: size.height*0.02,),
                TextField(
                  controller: desController,
                  minLines: 1,
                  maxLines: null,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none
                    ),
                    hintText: 'Note Here',
                    hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400)
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
