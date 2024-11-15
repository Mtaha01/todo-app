import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/date_ex/date_ex.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/utils/app_styles.dart';
import '../../../database_manager/model/todo_dm.dart';
import '../../../database_manager/model/user_DM.dart';


class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();

  static Future show(context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: AddTaskBottomSheet(),
          );
        });
  }
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate = DateTime.now();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  List<int> arr = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      height: MediaQuery.of(context).size.height * .5,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context)!.addingNewTask,
              textAlign: TextAlign.center,
              style: LightAppStyle.bottomSheetTitle,
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              validator: (input) {
                if (input == null || input.trim().isEmpty) {
                  return AppLocalizations.of(context)!.please+AppLocalizations.of(context)!.enterTaskTitle;
                }
                return null;
              },
              controller: titleController,
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.enterTaskTitle,
                  hintStyle: LightAppStyle.hint),
            ),
            const SizedBox(
              height: 8,
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
              controller: descriptionController,
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.enterTaskDescription,
                  hintStyle: LightAppStyle.hint),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Select date',
              style: LightAppStyle.date,
            ),
            InkWell(
                onTap: () {
                  showTaskDate(context);
                },
                child: Text(
                  selectedDate.toFormattedDate,
                  textAlign: TextAlign.center,
                  style: LightAppStyle.hint,
                )),
            const Spacer(),
            ElevatedButton(
                onPressed: () {
                  addTaskToFireStore();
                },
                child:  Text(AppLocalizations.of(context)!.addingNewTask))
          ],
        ),
      ),
    );
  }

  void showTaskDate(context) async {
    selectedDate = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          initialDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(
            days: 365,
          )),
        ) ??
        selectedDate;

    setState(() {});
  }

  void addTaskToFireStore() {
    // form is valid
    if (formKey.currentState!.validate() == false) return;

    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection(UserDM.collectionName);
    CollectionReference todoCollection = usersCollection
        .doc(UserDM.currentUser!.id)
        .collection(TodoDM.collectionName);
    DocumentReference documentReference = todoCollection.doc(); // auto id

    TodoDM todo = TodoDM(
        id: documentReference.id,
        title: titleController.text,
        description: descriptionController.text,
        dateTime: selectedDate.copyWith(
          second: 0,
          millisecond: 0,
          minute: 0,
          microsecond: 0,
          hour: 0,
        ),
        isDone: false);
    documentReference
        .set(todo.toFireStore())
        .then(
          (_) {
            if (context.mounted) {
              Navigator.pop(context);
            }
          },
        )
        .onError(
          (error, stackTrace) {},
        )
        .timeout(
          const Duration(seconds: 4),
          onTimeout: () {
            print('enter timeout');
            if (context.mounted) {
              Navigator.pop(context);
            }
          },
        );
  }
}
