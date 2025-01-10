import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/my_theme.dart';

import '../../providers/app_config_provider.dart';
import '../widgets/language_bottom_sheet.dart';
import '../widgets/theme_bottom_sheet.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.06,
          vertical: MediaQuery.of(context).size.height * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context)!.language,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: provider.isDarkMode()
                      ? MyTheme.whiteColor
                      : MyTheme.blackColor),
            ),
          ),
          InkWell(
            onTap: () {
              showLanguageBottomSheet();
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: MyTheme.whiteColor,
                border: Border.all(color: MyTheme.primaryLightColor, width: 2),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.english,
                    style: provider.isDarkMode()
                        ? Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: MyTheme.primaryLightColor)
                        : Theme.of(context).textTheme.titleSmall,
                  ),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context)!.theming,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: provider.isDarkMode()
                      ? MyTheme.whiteColor
                      : MyTheme.blackColor),
            ),
          ),
          InkWell(
            onTap: () {
              showThemeBottomSheet();
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: MyTheme.whiteColor,
                border: Border.all(color: MyTheme.primaryLightColor, width: 2),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.lightTheme,
                    style: provider.isDarkMode()
                        ? Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: MyTheme.primaryLightColor)
                        : Theme.of(context).textTheme.titleSmall,
                  ),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showLanguageBottomSheet() {

    showModalBottomSheet(

        context: context,
        builder: (context) => LanguageBottomSheet());
  }

  void showThemeBottomSheet() {

    showModalBottomSheet(

        context: context,
        builder: (context) => ThemeBottomSheet());
  }
}
