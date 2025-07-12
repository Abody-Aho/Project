import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterfire/components/customBottom.dart';
import 'package:flutterfire/components/textformfied.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController myfield = TextEditingController();
  CollectionReference StudyLisen =
      FirebaseFirestore.instance.collection('StudyLisen');

  addUser() async{
    if(formstate.currentState!.validate()){
      try{
        DocumentReference respond = await StudyLisen.add({"name" : myfield.text});
        Navigator.of(context).pushReplacementNamed("Home");
      }catch(e){
        print("Error : $e");
      }
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("أضافة الدروس"),
      ),
      body: Form(
        key: formstate,
        child: ListView(
          children: [
            Container(
                margin: const EdgeInsets.all(20),
                child: CoustomText(
                    text: "Enter The Name Of Lisen", myController: myfield)),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: CustomBottom(
                title: "Add",
                onPressed: () {
                  addUser();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
