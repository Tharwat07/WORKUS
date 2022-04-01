import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:talabat/constant/constants.dart';
import 'package:talabat/constant/constants.dart';
import 'package:talabat/screens/widgets/drawer.dart';
import 'package:talabat/screens/widgets/task_widget.dart';

import 'widgets/workers_wedgit.dart';

class AllWorkers extends StatefulWidget {
  @override
  State<AllWorkers> createState() => _AllWorkersState();
}

class _AllWorkersState extends State<AllWorkers> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(

          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white,
            size: 20,
          ),
          elevation: 10,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "All Workers",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.data!.docs.isNotEmpty) {
                 return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return WorkerWedgit(
                          userID: snapshot.data!.docs[index]['id'],
                          userEmail: snapshot.data!.docs[index]['email'],
                          userName: snapshot.data!.docs[index]['name'],
                          phoneNumber: snapshot.data!.docs[index]['phoneNumber'],
                          image:snapshot.data!.docs[index]['userImage'] ,
                          positionCompany: snapshot.data!.docs[index]['positionCompany'],


                        );
                      });
                } else {
                  return Center(
                    child: Text('There is no users  !'),
                  );
                }
              }
              return Center(child: Text("Wrong"));
            }));
  }
}
