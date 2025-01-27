import 'package:flutter/material.dart';
import 'package:todo/my_theme.dart';

class DialogUtils {
  static void showLoading(BuildContext context, String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(
                  color: MyTheme.primaryLightColor,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  message,
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleSmall,
                ),
              ],
            ));
      },
    );
  }

  static void hideDialog(BuildContext context) {
    Navigator.of(context).pop();
  }


  static void showDialogMessage(BuildContext context,
      {required String message,
        String title = '',
        String? posActionName,
        String? negActionName,
        VoidCallback? posAction,
        VoidCallback? negAction,
        bool canDismiss=false
      }) {
    List<Widget> actions = [];
    if (posActionName != null) {
      actions.add(TextButton(onPressed: () {
        Navigator.pop(context);
        posAction?.call();
      },
        child: Text(posActionName,style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: MyTheme.primaryLightColor
        ),),),);
    }
    if (negActionName != null) {
      actions.add(TextButton(onPressed: () {
        Navigator.pop(context);
        negAction?.call();
      },
        child: Text(negActionName),),);
    }
    showDialog(
      barrierDismissible: canDismiss,
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: actions,
          title: Text(title),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
