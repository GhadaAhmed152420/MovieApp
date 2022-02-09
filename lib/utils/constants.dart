import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

Database? db;
List<Map> movies = [];

void createDB() async {
  db = await openDatabase(
    'movies.db',
    version: 1,
    onCreate: (database, version) {
      print('Database Created!');
      database
          .execute(
              'CREATE TABLE movies (id INTEGER PRIMARY KEY, poster BLOB, title Text)')
          .then((value) {
        print('table created!');
      }).catchError((error) {
        print('error when creating table ${error.toString()}');
      });
    },
    onOpen: (database) {
      getDataFromDB(database).then((value) {
        movies = value;
      });
    },
  );
}

Future insertIntoDB({@required String? poster, @required String? title}) async {
  return await db?.transaction((txn) => txn
          .rawInsert(
              'INSERT INTO movies (poster, title) VALUES ("$poster", "$title")')
          .then((value) {
        print('$value inserted successfully!');
        getDataFromDB(db);
      }).catchError((error) {
        print('Error when inserting new record ${error.toString()}');
      }));
}

Future<List<Map>> getDataFromDB(database) async {
  return await database.rawQuery('SELECT * FROM movies');
}

Future deleteFromDB({required int id}) async {
  return await db?.rawDelete('DELETE FROM movies WHERE id = ?', [id]).then((value) {
    getDataFromDB(db);
  });
}
