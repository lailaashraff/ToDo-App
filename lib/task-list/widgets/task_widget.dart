import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/my_theme.dart';
import 'package:todo/task-list/screens/edit_task_screen.dart';

import '../../dialog_utils.dart';
import '../../models/task.dart';
import '../../providers/app_config_provider.dart';
import '../../providers/authentication_provider.dart';
import '../../providers/list_provider.dart';
import '../../toast_utils.dart';

class TaskWidget extends StatefulWidget {
  Task task;


  TaskWidget({
      required this.task});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var listProvider = Provider.of<ListProvider>(context);
    var authProvider = Provider.of<AuthenticationProvider>(context,listen: false);


    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(EditTaskScreen.routeName,
            arguments: TaskArguments(title: widget.task.title!,date: widget.task.dateTime!,desc: widget.task.description!,id: widget.task.id!)
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery
              .of(context)
              .size
              .width * 0.06,
          vertical: MediaQuery
              .of(context)
              .size
              .height * 0.02,
        ), // Keeps spacing between ListView items
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          // Matches the container's borderRadius
          child: Slidable(
            startActionPane: ActionPane(
              extentRatio: 0.25,
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),

                  ),
                  onPressed: (context) {
                    FirebaseUtils.deleteTask(widget.task, authProvider.currentUser!.id!)
                        .then((value) {
                      listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
                      ToastUtils.showToast(toastMessage: 'Todo deleted successfully',
                          toastColor: Colors.red);
                    },);
                    setState(() {

                    });

                  },
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.13,
              decoration: BoxDecoration(
                color: provider.isDarkMode() ? MyTheme.navy:MyTheme.whiteColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 10),
                  VerticalDivider(
                    color: widget.task.isDone!=null && widget.task.isDone! ? MyTheme.greenColor : MyTheme.primaryLightColor,
                    thickness: 4.5,
                    indent: 6,
                    endIndent: 6,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.task.title!,
                            style: widget.task.isDone!=null && widget.task.isDone! ?
                            Theme
                                .of(context)
                                .textTheme
                                .titleMedium?.copyWith(
                              color: MyTheme.greenColor
                            ) :
                            Theme
                                .of(context)
                                .textTheme
                                .titleMedium,
                          ),
                          Text(
                            widget.task.description!, style: Theme
                              .of(context)
                              .textTheme
                              .titleSmall,
                          ),

                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: widget.task.isDone!=null && widget.task.isDone! ?
                        Text("DONE! ", style:Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: MyTheme.greenColor
                        ),):
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery
                            .of(context)
                            .size
                            .width * 0.05,
                        vertical: MediaQuery
                            .of(context)
                            .size
                            .height * 0.008,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: MyTheme.primaryLightColor,
                      ),
                      child: InkWell(
                        child: Icon(
                          Icons.check,
                          color: MyTheme.whiteColor,
                          size: 30,
                        ),
                        onTap: (){
                          markTodoAsDone(widget.task);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void markTodoAsDone(Task task) {
    task.isDone=true;
    updateTaskChanges(task);

  }
  void updateTaskChanges(Task task) {

    var authProvider = Provider.of<AuthenticationProvider>(
        context, listen: false);

    FirebaseUtils.updateTask(task, authProvider.currentUser!.id!)
        .then((value) {
      listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
      ToastUtils.showToast(toastMessage: 'Todo completed successfully',
          toastColor: Colors.green);
    },);

    setState(() {

    });
  }
}


class TaskArguments {
  String title;
  String desc;
  DateTime date;
  String id;

  TaskArguments({required this.date,required this.title,required this.desc,required this.id});

}