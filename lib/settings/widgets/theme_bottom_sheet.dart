import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_config_provider.dart';
import '../../my_theme.dart';

class ThemeBottomSheet extends StatefulWidget {
  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Container(
      color: provider.isDarkMode() ? MyTheme.navy : MyTheme.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: () {
                provider.changeTheme(MyTheme.lightTheme);
              },
              child: !provider.isDarkMode()
                  ? getSelectedItemWidget(
                      AppLocalizations.of(context)!.lightTheme)
                  : getUnselectedItemWidget(
                      AppLocalizations.of(context)!.lightTheme)),
          InkWell(
            onTap: () {
              provider.changeTheme(MyTheme.darkTheme);
            },
            child: provider.isDarkMode()
                ? getSelectedItemWidget(AppLocalizations.of(context)!.darkTheme)
                : getUnselectedItemWidget(
                    AppLocalizations.of(context)!.darkTheme),
          ),
        ],
      ),
    );
  }

  Widget getSelectedItemWidget(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.height * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: MyTheme.primaryLightColor),
          ),
          Icon(
            Icons.check,
            color: MyTheme.primaryLightColor,
            size: 35,
          )
        ],
      ),
    );
  }

  Widget getUnselectedItemWidget(String text) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.03,
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Text(
        text,
        style: provider.isDarkMode()? Theme.of(context)
            .textTheme
            .titleSmall:Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(color: MyTheme.navy),
      ),
    );
  }
}
