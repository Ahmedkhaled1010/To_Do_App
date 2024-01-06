

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled4/shared/components/components.dart';
import 'package:untitled4/shared/cubit/states.dart';

import '../../modules/todo_app/archive_tasks/ArchiveTask_screen.dart';
import '../../modules/todo_app/done_tasks/DoneTask_screen.dart';
import '../../modules/todo_app/new_tasks/newTask_screen.dart';
import '../../shared/components/constants.dart';
import '../../shared/cubit/cubit.dart';
class Home_layout extends StatelessWidget  {


  var scaffoldKey = GlobalKey<ScaffoldState>();
  var titleKey =GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();


  @override

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener:(context,state){
          if(state is AppInsertDatabaseState)
            {
            Navigator.pop(context);
            }
        },
        builder: (context,state)
        {
          AppCubit cubit =AppCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.cyan,
            title: Text(
              cubit.title[cubit.current_index],
              style: TextStyle(

                color: Colors.white,
              ),
            ),
          ),
          body: cubit.screen[cubit.current_index],

          floatingActionButton: FloatingActionButton(
            onPressed: ()
            {
              if(cubit.isButtomShow) {
                if (titleKey.currentState!.validate()) {

                  cubit.insertDatabase(title: titleController.text,
                      date: dateController.text,
                      time: timeController.text);
                  // insertDatabase(
                  //   title: titleController.text,
                  //   time: timeController.text,
                  //   date: dateController.text,
                  // ).then((value)
                  // {
                  //   getDatabase(database).then(
                  //           (value)
                  //       {
                  //         Navigator.pop(context);
                  //         // setState(() {
                  //         //
                  //         //   isButtomShow = false;
                  //         //
                  //         //   fabIcon = Icons.edit;
                  //         //
                  //         //   tasks = value ;
                  //         //   print(tasks[0]);
                  //         // });
                  //
                  //       });
                  //
                  //
                  //
                  // });
                }
              }
              else {
                scaffoldKey.currentState!.showBottomSheet(
                      (context) =>
                      Container(
                        color: Colors.grey[200],
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: titleKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: titleController,
                                  validator: (value)
                                  {

                                    if(value!.isEmpty)
                                    {
                                      return "Title must no be empty";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Task Title",
                                    border:  OutlineInputBorder(),
                                    prefixIcon: Icon(
                                      Icons.title,
                                    ),

                                  ),


                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                TextFormField(
                                  controller: timeController,


                                  onTap: ()
                                  {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value)
                                    {
                                      timeController.text=value!.format(context);
                                      print(value!.format(context));
                                    });



                                    print("time on tapped");
                                  },
                                  validator: (value)
                                  {

                                    if(value!.isEmpty)
                                    {
                                      return "Time must no be empty";
                                    }
                                    return null;
                                  },


                                  decoration: InputDecoration(
                                    labelText: "Time Title",
                                    border:  OutlineInputBorder(),
                                    prefixIcon: Icon(
                                      Icons.watch_later_outlined,
                                    ),

                                  ),


                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                TextFormField(
                                  controller: dateController,

                                  onTap: ()
                                  {
                                    showDatePicker(
                                        context: context,
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse("2023-12-30")).then(
                                            (value)
                                        {
                                          if(value != null){
                                            print(DateFormat.yMMMd().format(value));
                                            dateController.text = DateFormat.yMMMd().format(value);
                                          }
                                        });



                                    print("Date on tapped");
                                  },
                                  validator: (value)
                                  {

                                    if(value!.isEmpty)
                                    {
                                      return "Date must no be empty";
                                    }
                                    return null;
                                  },


                                  decoration: InputDecoration(
                                    labelText: "date Title",
                                    border:  OutlineInputBorder(),
                                    prefixIcon: Icon(
                                      Icons.calendar_today,
                                    ),

                                  ),


                                ),



                              ],
                            ),
                          ),
                        ),
                      ),
                ).closed.then((value)
                {

                  cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);

                });
                cubit.changeBottomSheetState(isShow: true, icon: Icons.add);

              }
            },
            child: Icon(
              cubit.fabIcon,
            ),

          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.current_index ,
            onTap: (index)
            {
              cubit.changeIndex(index);
              print(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.menu,

                ),
                label: "Menu",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.check,

                ),
                label: "check",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.archive_outlined,

                ),
                label: "archive",
              ),

            ],
          ),
        );
        },

      ),
    );
  }

  Future<String> getName() async
  {
    return "Ahmed Khaled";
  }


}


