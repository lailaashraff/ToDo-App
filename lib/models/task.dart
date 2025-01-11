class Task{

  static const String collectionName='tasks';
  String? id;
  String? title;
  String? description;
  DateTime? dateTime;
  bool? isDone;

  Task({
    required this.title,
    required this.dateTime,
    required this.description,
    this.id='',
    this.isDone=false
});

  Task.fromFireStore(Map<String,dynamic> data):this(
  title: data['title'],
    description: data['description'],
    dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
    isDone: data['isDone'],
    id: data['id']
  );

  Map<String,dynamic> toFireStore(){
   return {
     'id':id,
     'title':title,
     'isDone':isDone,
     'description':description,
     'dateTime':dateTime?.millisecondsSinceEpoch

   };

  }
}