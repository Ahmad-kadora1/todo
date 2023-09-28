//import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:todo/shared/componants/componants.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/staets.dart';

class HomeLayout extends StatelessWidget {
  var titlecontroler = TextEditingController();
  var timecontroler = TextEditingController();
  var datecontroler = TextEditingController();

  var scafoldkay = GlobalKey<ScaffoldState>();
  var formkay = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..creatDB(),
      child: BlocConsumer<AppCubit, Appsteats>(
        builder: (BuildContext context, Appsteats state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            key: scafoldkay,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Center(
                child: Text(
                  cubit.titele1[cubit.x],
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                  ),
                ),
              ),
            ),
            body: ConditionalBuilder(
              condition: true,
              builder: (context) => cubit.screen[cubit.x],
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.grey[500],
              onPressed: () {
                if (cubit.isbottunshett) {
                  if (formkay.currentState!.validate()) {
                    cubit.insertToDB(
                      title: titlecontroler.text,
                      time: timecontroler.text,
                      data: datecontroler.text,
                    );
                    //   .then((value) {
                    // cubit.getdata(cubit.database).then((value) {

                    //   //setState(() {
                    //   //isbottunshett = false;
                    //   //iconedat = Icons.edit;

                    //   //tasks = value;
                    //   //});
                    // });
                    // });
                  }
                } else {
                  scafoldkay.currentState
                      ?.showBottomSheet(
                        (context) => Container(
                          color: Colors.grey[500],
                          padding: EdgeInsets.all(20.0),
                          child: Form(
                            key: formkay,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defultfromfild(
                                    controller: titlecontroler,
                                    type: TextInputType.text,
                                    fin1: (context) {},
                                    valdidate: (value) {
                                      if (value!.isEmpty) {
                                        return 'title must not be emty ';
                                      }
                                      return null;
                                    },
                                    text: 'Taske Title',
                                    prfix: Icons.title),
                                SizedBox(
                                  height: 20.0,
                                ),
                                defultfromfild(
                                    ontap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((value) {
                                        timecontroler.text =
                                            value!.format(context).toString();
                                      });
                                    },
                                    controller: timecontroler,
                                    type: TextInputType.datetime,
                                    fin1: (context) {},
                                    valdidate: (value) {
                                      if (value!.isEmpty) {
                                        return 'time must not be emty ';
                                      }
                                      return null;
                                    },
                                    text: 'Time data ',
                                    prfix: Icons.watch_later_outlined),
                                SizedBox(
                                  height: 20.0,
                                ),
                                defultfromfild(
                                    controller: datecontroler,
                                    type: TextInputType.datetime,
                                    ontap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse('2022-12-03'),
                                      ).then((value) {
                                        datecontroler.text =
                                            DateFormat.yMMMd().format(value!);
                                      });
                                    },
                                    fin1: (context) {},
                                    valdidate: (value) {
                                      if (value!.isEmpty) {
                                        return 'date must not be emty ';
                                      }
                                      return null;
                                    },
                                    text: ' task  date ',
                                    prfix: Icons.calendar_today),
                              ],
                            ),
                          ),
                        ),
                      )
                      .closed
                      .then((value) {
                    cubit.changeBottomShett(isshow: false, icon: Icons.edit);
                  });
                  cubit.changeBottomShett(isshow: true, icon: Icons.add);
                }
              },
              child: Icon(cubit.iconedat),
            ),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: AppCubit.get(context).x,
                onTap: (index) {
                  AppCubit.get(context).changeIndex(index);
                  //setState(() {
                  //x = index;
                  //});
                },
                backgroundColor: Colors.grey[500],
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.black87,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu),
                      label: 'Tasks',
                      backgroundColor: Colors.black),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.check_circle_outline),
                      label: 'Done',
                      backgroundColor: Colors.black),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive_outlined),
                      label: 'Archived',
                      backgroundColor: Colors.black)
                ]),
          );
        },
        listener: (BuildContext context, Appsteats state) {
          if (state is AppInsertDataBeassteats) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  Future<String> getname() async {
    return 'ahmad kadora';
  }
}
