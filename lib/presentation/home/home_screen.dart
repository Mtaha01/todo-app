import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/colors_manager.dart';
import 'package:todo_app/presentation/home/tabs/settings_tab/settings_tab.dart';
import 'package:todo_app/presentation/home/tabs/tasks_tab/tasks_tab.dart';
import 'add_task_bottom_sheet/add_task_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<TasksTabState> tasksTabKey = GlobalKey();
  int currentIndex = 0;
  List<Widget> tabs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabs = [
      TasksTab(
        key: tasksTabKey,
      ),
      SettingsTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: buildFab(),
      bottomNavigationBar: buildBottomNavBar(),
      body: tabs[currentIndex],
    );
  }

  Widget buildBottomNavBar() => ClipRRect(
    clipBehavior: Clip.antiAlias,
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(15),
      topRight: Radius.circular(15),
    ),
    child: BottomAppBar(
      notchMargin: 8,
      child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (tappedIndex) {
            currentIndex = tappedIndex;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(icon: const Icon(Icons.list), label: AppLocalizations.of(context)!.tasksTab),
            BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: AppLocalizations.of(context)!.settingsTitle),
          ]),
    ),
  );

  Widget buildFab() => FloatingActionButton(
        onPressed: () async {
          await AddTaskBottomSheet.show(context); // 2
          // access reading data from firestore
          tasksTabKey.currentState?.getTodosFromFireStore();
        },
        child: Icon(Icons.add,color: ColorsManager.white,),
      );
}
