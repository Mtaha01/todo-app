import 'package:flutter/material.dart';
import 'package:todo_app/presentation/home/add_task_bottom_sheet/add_task_bottom_sheet.dart';
import 'package:todo_app/presentation/home/tabs/settings_tab/settings_tab.dart';
import 'package:todo_app/presentation/home/tabs/tasks_tab/tasks_tab.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [
    TasksTab(),
    SettingsTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo App"),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius:BorderRadius.only(topLeft:Radius.circular(20),topRight:Radius.circular(20)),
        child: BottomAppBar(
          notchMargin: 10,
          child: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (idx) {
                currentIndex = idx;
                setState(() {});
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.list), label: "List"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings_outlined), label: "Settings"),
              ]),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          tabs[currentIndex],
          Spacer(),
          AddTaskBottomSheet(),
          SizedBox(height: 10,)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
