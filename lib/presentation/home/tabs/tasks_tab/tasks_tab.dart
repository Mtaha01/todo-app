
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/utils/date_ex/date_ex.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/colors_manager.dart';
import '../../../../database_manager/model/todo_dm.dart';
import '../../../../database_manager/model/user_DM.dart';
import 'task_item/todo_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => TasksTabState();
}

class TasksTabState extends State<TasksTab> {
  DateTime calenderSelectedDate = DateTime.now(); //
  List<TodoDM> todosList = [];

  /// empty state

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTodosFromFireStore(); //
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              color: ColorsManager.blue,
              height: 90.h,
            ),
            buildCalender(),
          ],
        ),
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) {
            print(todosList.length);
            return TodoItem(
              todo: todosList[index],
              onDeletedTask: () {
                getTodosFromFireStore();
              },
            );
          },
          itemCount: todosList.length,
        ))
      ],
    );
  }

  Widget buildCalender() {
    return EasyInfiniteDateTimeLine(
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      focusDate: calenderSelectedDate,
      lastDate: DateTime.now().add(Duration(days: 365)),
      onDateChange: (selectedDate) {},
      itemBuilder: (context, date, isSelected, onTap) {
        return InkWell(
          onTap: () {
            calenderSelectedDate = date; // 2/11
            getTodosFromFireStore();
          },
          child: Card(
            elevation: 8,
            color: ColorsManager.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  date.getDayName(date, context),
                  style: isSelected
                      ? LightAppStyle.calenderSelectedDate
                      : LightAppStyle.calenderUnSelectedDate,
                ),
                Text(
                  '${date.day}',
                  style: isSelected
                      ? LightAppStyle.calenderSelectedDate
                      : LightAppStyle.calenderUnSelectedDate,
                )
              ],
            ),
          ),
        );
      },
      locale:Localizations.localeOf(context).toString() ,
    );
  }

  void getTodosFromFireStore() async {
    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.currentUser!.id)
        .collection(TodoDM.collectionName);

    QuerySnapshot collectionSnapShot = await todoCollection
        .where('dateTime',
            isEqualTo: calenderSelectedDate.copyWith(
              hour: 0,
              microsecond: 0,
              minute: 0,
              millisecond: 0,
              second: 0,
            ))
        .get();
    List<QueryDocumentSnapshot> documentsSnapShot = collectionSnapShot.docs;
    // get All todos
    todosList = documentsSnapShot.map(
      (docSnapShot) {
        Map<String, dynamic> json = docSnapShot.data() as Map<String, dynamic>;
        TodoDM todo = TodoDM.fromFireStore(json);
        return todo;
      },
    ).toList();
    // filter todos based selectedCalenderDate
    // todosList = todosList
    //     .where(
    //       (todo) =>
    //           todo.dateTime.day == calenderSelectedDate.day &&
    //           todo.dateTime.month == calenderSelectedDate.month &&
    //           todo.dateTime.year == calenderSelectedDate.year,
    //     )
    //     .toList();
    setState(() {});
  }
}
