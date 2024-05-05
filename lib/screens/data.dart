import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataForm extends StatefulWidget {
  const DataForm({super.key});

  @override
  State<DataForm> createState() => _DataFormState();
}

class _DataFormState extends State<DataForm> {
  CollectionReference collection_1 =
      FirebaseFirestore.instance.collection("mcq1");

  String fieldValue = "";
  List<String> fieldDataList = [];

  void prinnt() async {
    await collection_1.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot document) {
        print(document.id);
        CollectionReference collection_2 =
            collection_1.doc(document.id).collection("question");
        //collection two

        collection_2.get().then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            print(document);
            fieldValue = data['question'];
            fieldDataList.add(fieldValue);
            setState(() {
              fieldValue = fieldDataList[0];
            });
          });
        });
      });

      print(fieldValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(fieldValue),
            ElevatedButton(
                onPressed: () {
                  prinnt();
                },
                child: Text("print"))
          ],
        ),
      ),
    );
  }
}
