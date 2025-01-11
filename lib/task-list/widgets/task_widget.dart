import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/my_theme.dart';
import 'package:todo/task-list/screens/edit_task_screen.dart';

import '../../models/task.dart';
import '../../providers/app_config_provider.dart';
import '../../providers/list_provider.dart';

class TaskWidget extends StatelessWidget {
  Task task;


  TaskWidget({
      required this.task});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var listProvider = Provider.of<ListProvider>(context);

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(EditTaskScreen.routeName,
            arguments: TaskArguments(title: task.title!,date: task.dateTime.toString(),desc: task.description!)
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
                    FirebaseUtils.deleteTask(task).timeout(
                      Duration(milliseconds: 500),
                      onTimeout: () {
                        listProvider.getAllTasksFromFireStore();
                      },
                    );
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
                    color: MyTheme.primaryLightColor,
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
                            task.title!,
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleMedium,
                          ),
                          Text(
                            task.description!, style: Theme
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
                    child: Container(
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
                      child: Icon(
                        Icons.check,
                        color: MyTheme.whiteColor,
                        size: 30,
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
}


class TaskArguments {
  String title;
  String desc;
  String date;

  TaskArguments({required this.date,required this.title,required this.desc});

}