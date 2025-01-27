import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/my_user.dart';

import 'models/task.dart';

class FirebaseUtils{


  static CollectionReference<Task> getTasksCollectionName(String uid){
    return getUserCollectionName().doc(uid).collection(Task.collectionName).withConverter<Task>(
fromFirestore: (snapshot, options) => Task.fromFireStore(snapshot.data()!),
      toFirestore:(task, options) => task.toFireStore()
    );
  }

  static Future<void> addTaskToFireBase(Task task, String uid){
    var taskCollection=getTasksCollectionName(uid);
   var taskDocRef= taskCollection.doc();
   task.id=taskDocRef.id;
   return taskDocRef.set(task);
  }

  static Future <void> deleteTask(Task task,String uid){
    return getTasksCollectionName(uid).doc(task.id).delete();
  }
  static Future<void> updateTask(Task task, String uid){
   return  getTasksCollectionName(uid).doc(task.id).update(task.toFireStore());
  }

  static CollectionReference<MyUser> getUserCollectionName(){
    return FirebaseFirestore.instance.collection(MyUser.collectionName).withConverter<MyUser>(
        fromFirestore: (snapshot, options) => MyUser.fromFireStore(snapshot.data()!),
        toFirestore:(user, options) => user.toFireStore()
    );
  }

  static Future<void> addUserToFireBase(MyUser user){
   return getUserCollectionName().doc(user.id).set(user);

  }

  static Future<MyUser?> readUserFromFireStore(String uid) async {
    var snapshot= await getUserCollectionName().doc(uid).get();
    return snapshot.data();
  }


}