import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/task.dart';

class FirebaseUtils{


  static CollectionReference<Task> getCollectionName(){
    return FirebaseFirestore.instance.collection(Task.collectionName).withConverter<Task>(
fromFirestore: (snapshot, options) => Task.fromFireStore(snapshot.data()!),
      toFirestore:(task, options) => task.toFireStore()
    );
  }

  static Future<void> addTaskToFireBase(Task task){
    var taskCollection=getCollectionName();
   var taskDocRef= taskCollection.doc();
   task.id=taskDocRef.id;
   return taskDocRef.set(task);
  }

  static Future <void> deleteTask(Task task){
    return getCollectionName().doc(task.id).delete();
  }

}