class MyUser{

  String? id;
  String? email;
  String? username;

  static const String collectionName='users';


  MyUser({required this.id,required this.email,required this.username});


  MyUser.fromFireStore(Map<String,dynamic> data):this(
      id: data['id'],
      username: data['username'],
      email: data['email']
  );

  Map<String,dynamic> toFireStore(){
    return {
      'id':id,
      'username':username,
      'email':email,

    };

  }
}