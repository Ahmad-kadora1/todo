import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import 'package:todo/shared/cubit/staets.dart';

import '../../modules/archived_tasks/archived_taskes_screen.dart';
import '../../modules/done_tasks/done_taskes_screen.dart';
import '../../modules/new_tasks/new_taskes_screen.dart';

class AppCubit extends Cubit<Appsteats> {
  AppCubit() : super(AppInitialSteats());
  static AppCubit get(context) => BlocProvider.of(context);
  int x = 0;
  List<Map> tasks = [];

  List<Widget> screen = [
    NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen(),
  ];
  List<String> titele1 = [
    'New Taskes',
    'Done Taskes',
    'Archived Taskes',
  ];

  void changeIndex(int index) {
    x = index;
    emit(AppChangeBottomNavBarsteats());
  }

  Database? database;
  void creatDB() {
    openDatabase(
      'todo.db',
      version: 2,
      onCreate: (database, version) {
        print('DB  created');
        database
            .execute(
                'CREATE TABLE Tasks (id INTEGER PRIMARY KEY,title TEXT ,data TEXT,time TEXT,status TEXT )')
            .then((value) {
          print('created table ');
        }).catchError((error) {
          print('error when creting table ${error.toString()}');
        });
      },
      onOpen: (database) {
        print('DB   open  created');
        print(database);
      },
    ).then((value) => () {
          database = value;

          emit(AppCreatDataBasesteats());
        });
  }

  insertToDB({
    required String title,
    required String time,
    required String data,
  }) async {
    print(title);
    await database?.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO Tasks (title , data , time , status) VALUES ( "$title", "$data" , "$time" , "new")')
          .then((value) {
        print('$value inserted successfuly');
        emit(AppInsertDataBeassteats());
        getdata(database).then((value) {
          tasks = value;

          emit(AppGetDataBeassteats());
        });
      }).catchError((error) {
        print('erorr when inserting new record ${error.toString()}');
      });
    });
  }

  Future<List<Map>> getdata(database) async {
    return await database.rawQuery('SELECT * FROM Tasks ');
  }

  IconData iconedat = Icons.edit;
  bool isbottunshett = false;
  void changeBottomShett({
    required bool isshow,
    required IconData icon,
  }) {
    isbottunshett = isshow;
    iconedat = icon;
    emit(ChangeBottomSheetsteats());
  }
}
