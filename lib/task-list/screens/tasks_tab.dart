import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/my_theme.dart';
import 'package:todo/task-list/widgets/task_widget.dart';

import '../../providers/app_config_provider.dart';

class TasksTab extends StatefulWidget {

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  DateTime selectedDate=DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Column(
      children: [
        CalendarTimeline(
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) => print(date),
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
                return TaskWidget(taskTitle: 'title$index',taskDesc: 'desc$index',taskDate: '04/1/24',);
              },
            itemCount: 20,

          ),
        )
      ],
    );
  }
}
