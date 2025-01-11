
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/firebase_utils.dart';

import '../models/task.dart';

class ListProvider extends ChangeNotifier{

  List<Task> taskList=[];

  void getAllTasksFromFireStore() async {
    QuerySnapshot<Task> querySnapshot=await FirebaseUtils.getCollectionName().get();
    taskList=querySnapshot.docs.map(
      (doc) {
        return doc.data();
      },
    ).toList();
    notifyListeners();
  }
}