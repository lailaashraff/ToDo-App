import 'package:flutter/material.dart';
import 'package:todo/settings/screens/settings_tab.dart';
import 'package:todo/task-list/screens/tasks_tab.dart';
import 'package:todo/task-list/widgets/add_task_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../my_theme.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabs = [TasksTab(),SettingsTab() ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.todoTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        color: MyTheme.whiteColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon:  Icon(
                Icons.list,size: 30,
              ),
              onPressed: () {
                selectedIndex=0;
                setState(() {

                });
              },
              color: selectedIndex==1 ? MyTheme.grayColor : MyTheme.primaryLightColor,

            ),
            IconButton(
              icon:  Icon(
                Icons.settings,size: 30,
              ),
              onPressed: () {
                selectedIndex=1;
                setState(() {

                });
              },
              color: selectedIndex==0 ? MyTheme.grayColor : MyTheme.primaryLightColor,
            ),

          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddBottomSheet();
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: tabs[selectedIndex],
    );
  }
  void showAddBottomSheet() {
    showModalBottomSheet(context: context,
        builder: (context)=>AddTaskBottomSheet());

  }
}


