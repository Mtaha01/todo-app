import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/core/utils/date_ex/date_ex.dart';
import 'package:todo_app/database_manager/model/todo_dm.dart';
import 'package:todo_app/presentation/home/tabs/tasks_tab/task_item/todo_item.dart';

import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/colors_manager.dart';
import '../../../../../database_manager/model/user_DM.dart';
import '../tasks_tab.dart';

class EditTask extends StatelessWidget {

  EditTask({super.key});


  @override
  Widget build(BuildContext context) {

    var allData=ModalRoute.of(context)!.settings.arguments as DataNeededToUpdate;
    var data=allData.todo;
    TextEditingController titleController = TextEditingController();
    titleController.text=data.title;
    TextEditingController descriptionController = TextEditingController();
    descriptionController.text=data.description;
    GlobalKey<TasksTabState> tasksTabKey = GlobalKey();

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.appTitle),),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            color: ColorsManager.blue,
            height: 90.h,
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              height: MediaQuery.of(context).size.height * .8,
              child:
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.editTask,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      AppLocalizations.of(context)!.enterTaskTitle,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextFormField(
                      validator: (input) {
                        if (input == null || input.trim().isEmpty) {
                          return AppLocalizations.of(context)!.please+AppLocalizations.of(context)!.enterTaskTitle;
                        }
                        return null;
                      },
                      onChanged: (value){
                        data.title=value;
                      },
                      controller: titleController,
                      decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.enterTaskTitle,
                          hintStyle: LightAppStyle.hint),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      AppLocalizations.of(context)!.enterTaskDescription,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextFormField(
                      validator: (input) {
                        if (input == null || input.trim().isEmpty) {
                          return AppLocalizations.of(context)!.please+AppLocalizations.of(context)!.enterTaskDescription;
                        }
                        if (input.length < 6) {
                          return 'Sorry, description should be at least 6 chars';
                        }
                        return null;
                      },
                      onChanged: (value){
                        data.description=value;
                      },
                      controller: descriptionController,
                      decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.enterTaskDescription,
                          hintStyle: LightAppStyle.hint),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      AppLocalizations.of(context)!.selectDate,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    InkWell(
                        onTap: () async{
                          DateTime selectedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            initialDate: data.dateTime,
                            lastDate: DateTime.now().add(const Duration(
                              days: 365,
                            )),
                          ) ??
                              data.dateTime;
                          data.dateTime=selectedDate;
                        },
                        child: Text(
                          data.dateTime.toFormattedDate,
                          textAlign: TextAlign.center,
                          style: LightAppStyle.hint,
                        )),
                    const SizedBox(height: 80,),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.onSecondary),
                        onPressed: () async{
                          await updateTask(data).then((onValue)async{
                          await allData.afterEdit();
                          Navigator.pop(context);
                          });
                        },
                        child:  Text(AppLocalizations.of(context)!.editTask))
                  ],
            
                ),
              ),
            ),
          )

        ],
      ),
    );
  }

  Future<void>updateTask(TodoDM taskToUpdate)async{
    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.currentUser!.id)
        .collection(TodoDM.collectionName);
    DocumentReference todoDoc = todoCollection.doc(taskToUpdate.id);
    todoDoc.update(taskToUpdate.toFireStore());
  }
}
