import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../dialog_utils.dart';
import '../../firebase_utils.dart';
import '../../models/task.dart';
import '../../my_theme.dart';
import '../../providers/app_config_provider.dart';
import '../../providers/authentication_provider.dart';
import '../../providers/list_provider.dart';
import '../../toast_utils.dart';
import '../widgets/task_widget.dart';

class EditTaskScreen extends StatefulWidget {
  static const String routeName = 'edit-task-screen';

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

TextEditingController titleController = TextEditingController();

TextEditingController descController = TextEditingController();
late String taskId;

late DateTime selectedDate ;
String formattedDate = "";
var formKey = GlobalKey<FormState>();
late ListProvider listProvider;


class _EditTaskScreenState extends State<EditTaskScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var args = ModalRoute.of(context)?.settings.arguments as TaskArguments;
    listProvider = Provider.of(context);

    receiveArguments(args);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: MyTheme.whiteColor),
        title: Text(
          AppLocalizations.of(context)!.todoTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.12,
          horizontal: MediaQuery.of(context).size.width * 0.04,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: provider.isDarkMode()
              ? MyTheme.navy
              : MyTheme.whiteColor,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppLocalizations.of(context)!.editTask,
                style: provider.isDarkMode()
                    ? Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: MyTheme.whiteColor)
                    : Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: MyTheme.darkBlackColor),
              ),
            ),
            Expanded(
              child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: titleController,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.enterTitle,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .pleaseEnterTitle;
                            }
                            return null;
                          },
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.enterDesc,
                          ),
                          controller: descController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!.enterDesc;
                            }
                            return null;
                          },
                          style: Theme.of(context).textTheme.titleSmall,
                          maxLines: 4,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(AppLocalizations.of(context)!.selectDate,
                            style: Theme.of(context).textTheme.titleSmall),
                        InkWell(
                          onTap: () {
                            showCalender();
                          },
                          child: Text(
                            formattedDate.isNotEmpty ? formattedDate : DateFormat.yMd().format(args.date),
                            style: provider.isDarkMode()
                                ? Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(color: MyTheme.whiteColor)
                                : Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(color: MyTheme.darkBlackColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Spacer(),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.08,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              saveTaskChanges();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: MyTheme.primaryLightColor,
                                minimumSize: const Size.fromHeight(60)),
                            child: Text(
                              AppLocalizations.of(context)!.saveChanges,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: MyTheme.whiteColor),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  void receiveArguments(var args) {
    titleController.text = args.title;
    descController.text = args.desc;
    selectedDate=args.date;
    taskId=args.id;
  }

  void showCalender() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      selectedDate = chosenDate;
      formattedDate = DateFormat.yMd().format(selectedDate); // Proper formatting
    }

    setState(() {});
  }

  void saveTaskChanges() {
    Task task = Task(
        title:titleController.text,id: taskId , dateTime: selectedDate, description:   descController.text);

    var authProvider = Provider.of<AuthenticationProvider>(
        context, listen: false);

    DialogUtils.showLoading(context, "Loading...");
    FirebaseUtils.updateTask(task, authProvider.currentUser!.id!)
        .then((value) {
      DialogUtils.hideDialog(context);
      listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
      Navigator.of(context).pop();
      ToastUtils.showToast(toastMessage: 'Todo updated successfully',
          toastColor: MyTheme.primaryLightColor);
    },);

    setState(() {

    });
  }
}
