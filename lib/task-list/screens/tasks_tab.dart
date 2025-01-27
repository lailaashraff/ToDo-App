import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/my_theme.dart';
import 'package:todo/providers/list_provider.dart';
import 'package:todo/task-list/widgets/task_widget.dart';
import '../../providers/app_config_provider.dart';
import '../../providers/authentication_provider.dart';

class TasksTab extends StatefulWidget {


  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  DateTime selectedDate=DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var listProvider = Provider.of<ListProvider>(context);
    var authProvider = Provider.of<AuthenticationProvider>(context,listen: false);


    if(listProvider.taskList.isEmpty){
      listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
    }
    return Column(
      children: [
        CalendarTimeline(
          initialDate: listProvider.selectedDate,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) {
            listProvider.setNewSelectedDate(date,authProvider.currentUser!.id!);
          },
          leftMargin: 20,
          monthColor: MyTheme.blackColor,
          dayColor: MyTheme.blackColor,
          activeDayColor: MyTheme.whiteColor,
          activeBackgroundDayColor: MyTheme.primaryLightColor,
          locale: provider.appLanguage,
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TaskWidget(task: listProvider.taskList[index],);
            },
            itemCount: listProvider.taskList.length,

          ),
        )
      ],
    );
  }
}
