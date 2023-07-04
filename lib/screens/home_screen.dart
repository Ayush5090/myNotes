import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/components/notes_container.dart';
import 'package:my_notes/screens/add_notes_screen.dart';
import 'package:my_notes/screens/user_onboard/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late FirebaseFirestore firestore;
  late CollectionReference<Map<String, dynamic>> notes;
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
    notes = firestore.collection('users').doc(currentUser!.email).collection('notes');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffcf6f1),
      appBar: AppBar(
        title: Text('Notes'),
        actions: [
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
          }, icon: Icon(Icons.logout, color: Colors.pinkAccent,))
        ],
      ),
      body: StreamBuilder(
        stream: notes.snapshots(),
        builder: (ctx, snapshot) {
          if(snapshot.hasData && snapshot.data!.docs.isNotEmpty && snapshot.data != null){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return NotesContainer(title: snapshot.data!.docs[index].get('title').toString(), description: snapshot.data!.docs[index].get('des').toString(),
                deleteCallback: (){
                  notes.doc(snapshot.data!.docs[index].id).delete();
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Note Deleted'), duration: Duration(milliseconds: 700),)
                  );
                },);
              },);
          } else if(snapshot.hasError){
            return Center(child: Text('${snapshot.error.toString()}'),);
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotes(),));
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}
