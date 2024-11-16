import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/routes_manager.dart';
import 'package:todo_app/presentation/home/tabs/tasks_tab/tasks_tab.dart';

import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/colors_manager.dart';
import '../../../../../database_manager/model/todo_dm.dart';
import '../../../../../database_manager/model/user_DM.dart';
import '../../../../../provider/setting_provider.dart';


class TodoItem extends StatelessWidget {
  TodoItem({super.key, required this.todo, required this.onDeletedTask});

  TodoDM todo;

  Function onDeletedTask;

  @override
  Widget build(BuildContext context) {
    var myProvider=Provider.of<SettingsProvider>(context);
    return Container(
      margin: REdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.onPrimary),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: .3,
          motion: BehindMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),
              flex: 2,
              onPressed: (context) {
                deleteTodoFromFireStore(todo);
                onDeletedTask();
              },
              backgroundColor: ColorsManager.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.deleteOption,
            ),
          ],
        ),
        endActionPane:
            ActionPane(extentRatio: 0.3, motion: DrawerMotion(), children: [
          SlidableAction(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15)),
            flex: 2,
            onPressed: (context) {Navigator.of(context).pushNamed(RoutesManager.editTask,arguments: DataNeededToUpdate(todo: todo, afterEdit: onDeletedTask));
              },
            backgroundColor: ColorsManager.blue,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label:AppLocalizations.of(context)!.editOption ,
          ),
        ]),
        child: Container(
          //padding: EdgeInsets.all(18),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Container(
                height: 62,
                width: 4,
                decoration: BoxDecoration(
                  color:todo.isDone?ColorsManager.green: ColorsManager.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(
                width: 7,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    todo.title,
                    style: todo.isDone?LightAppStyle.todoTitle.copyWith(color: ColorsManager.green):LightAppStyle.todoTitle,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    todo.description,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              Spacer(),
              InkWell(
                  child:todo.isDone ? Container(child: Text("is Done!",style: LightAppStyle.todoTitle.copyWith(color: ColorsManager.green,fontWeight: FontWeight.w900),),)
                  :
                  Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                      color: ColorsManager.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.check,
                    color: ColorsManager.white,
                  ),),
              onTap: ()async{
                    await taskIsDone(todo).then((onValue){onDeletedTask();});
                    
              },
              )
            ],
          ),
        ),
      ),
    );
  }

  void deleteTodoFromFireStore(TodoDM todo) async {
    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.currentUser!.id)
        .collection(TodoDM.collectionName); // todo
    DocumentReference todoDoc = todoCollection.doc(todo.id);
    await todoDoc.delete();
  }

  Future<void> taskIsDone(TodoDM todo) async {
    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.currentUser!.id)
        .collection(TodoDM.collectionName);
    DocumentReference todoDoc = todoCollection.doc(todo.id);
    await todoDoc.update({'isDone':!todo.isDone});
  }
}
class DataNeededToUpdate{
  TodoDM todo;
  Function afterEdit;
  DataNeededToUpdate({required this.todo,required this.afterEdit});
}