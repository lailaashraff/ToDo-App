import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../providers/app_config_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

DateTime selectedDate = DateTime.now();
String formattedSelectedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
var formKey = GlobalKey<FormState>();

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      color: provider.isDarkMode()?MyTheme.navy : MyTheme.whiteColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context)!.addTaskTitle,
              style:provider.isDarkMode()? Theme
                  .of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: MyTheme.whiteColor): Theme
                  .of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: MyTheme.darkBlackColor),
            ),
          ),
          Form(
              key:formKey,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.pleaseEnterTitle;
                        }
                        return null;
                      },
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleSmall,
                      decoration: InputDecoration(hintText: AppLocalizations.of(context)!.enterTitle),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.pleaseEnterDesc;
                        }
                        return null;
                      },
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleSmall,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.enterDesc,
                      ),
                      maxLines: 4,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(AppLocalizations.of(context)!.selectDate,
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleSmall),
                    InkWell(
                      onTap: () {
                        showCalender();
                      },
                      child: Text(
                        formattedSelectedDate,
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: MyTheme.darkBlackColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(onPressed: () {
                      addTask();
                    },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyTheme.primaryLightColor,
                      ),
                      child: Text(AppLocalizations.of(context)!.addTask,
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                            color: MyTheme.whiteColor
                        )
                        ,),)
                  ],
                ),
              ))
        ],
      ),
    );
  }

  void showCalender() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      selectedDate = chosenDate;
      formattedSelectedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
    }
    else {
      formattedSelectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    }
    setState(() {});
  }

  void addTask() {
    if(formKey.currentState?.validate()==true){
      print('success');
      setState(() {

      });
    }
  }
}
