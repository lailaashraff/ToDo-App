import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../my_theme.dart';
import '../../providers/app_config_provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
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
              provider.changeLanguage('en');
            },
            child: provider.appLanguage == 'en'
                ? getSelectedItemWidget(AppLocalizations.of(context)!.english)
                : getUnselectedItemWidget(
                    AppLocalizations.of(context)!.english),
          ),
          InkWell(
            onTap: () {
              provider.changeLanguage('ar');
            },
            child: provider.appLanguage == 'ar'
                ? getSelectedItemWidget(AppLocalizations.of(context)!.arabic)
                : getUnselectedItemWidget(AppLocalizations.of(context)!.arabic),
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
