import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/firebase_utils.dart';

import '../models/task.dart';

class ListProvider extends ChangeNotifier {

  List<Task> taskList = [];
  DateTime selectedDate = DateTime.now();



  void getAllTasksFromFireStore(String uid) async {
    QuerySnapshot<Task> querySnapshot = await FirebaseUtils.getTasksCollectionName(uid)
        .get();
    taskList = querySnapshot.docs.map(
          (doc) {
        return doc.data();
      },
    ).toList();

    taskList= taskList.where(
          (task) {
        if (task.dateTime?.day == selectedDate.day
            && task.dateTime?.month == selectedDate.month &&
            task.dateTime?.year == selectedDate.year
        ){
          return true;
        }
        return false;
      },
    ).toList();
    taskList.sort(
      (task1, task2) {
        return task1.dateTime!.compareTo(task2.dateTime!);
      },
    );
    notifyListeners();
  }

  void setNewSelectedDate(DateTime newDate,String uid){
    selectedDate=newDate;
    getAllTasksFromFireStore(uid);
  }
}