import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/utils/colors_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsTab extends StatefulWidget {

  SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  TextEditingController selectedTheme= TextEditingController();
  TextEditingController selectedLanguage=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.theme,
            style: LightAppStyle.settingsTabLabel,
          ),
          SizedBox(height: 4,),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 8,right: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              border: Border.all(
                width: 1,
                color: ColorsManager.blue,
              ),
            ),
            child: DropdownMenu(
              dropdownMenuEntries: [
                DropdownMenuEntry(value: 'light', label: AppLocalizations.of(context)!.lightTheme),
                DropdownMenuEntry(value: 'dark', label: AppLocalizations.of(context)!.darkTheme),
              ],
              textStyle: LightAppStyle.selectedItemLabel,
              initialSelection:"light",
              width: double.infinity,
              inputDecorationTheme: InputDecorationTheme(
                border: InputBorder.none,
              ),
              controller: selectedTheme,
              onSelected: (value){
              } ,
            ),
          ),
          SizedBox(height: 10,),
          Text(
            AppLocalizations.of(context)!.language,
            style: LightAppStyle.settingsTabLabel,
          ),
          SizedBox(height: 4,),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 8,right: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              border: Border.all(
                width: 1,
                color: ColorsManager.blue,
              ),
            ),
            child: DropdownMenu(
              dropdownMenuEntries: [
                DropdownMenuEntry(value: 'en', label: 'English'),
                DropdownMenuEntry(value: 'ar', label: 'العربية'),
              ],
              textStyle: LightAppStyle.selectedItemLabel,
              initialSelection:"en",
              width: double.infinity,
              inputDecorationTheme: InputDecorationTheme(
                border: InputBorder.none,
              ),
              controller: selectedLanguage,
              onSelected: (value){

              } ,
            ),
          ),
        ],
      ),
    );
  }
}
