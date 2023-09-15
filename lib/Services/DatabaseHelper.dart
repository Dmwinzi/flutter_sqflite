import 'dart:async';
import 'dart:ffi';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/Note.dart';

class DatabaseHelper{

    static const int _version  = 1;
    static const String _dbname = "Notes.db";
    static const String tablename  = "notes";



    static Future<Database> _createdb() async {
        return openDatabase(join(await getDatabasesPath(),_dbname,),version: _version,onCreate : (db,version) async{
                await db.execute("CREATE TABLE $tablename (id INTEGER PRIMARY KEY,title TEXT,notes TEXT)");
           }

        );
    }


    static Future<int> Create(Note note) async{
         final db  = await _createdb();
         return await db.insert(tablename,note.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    }

    static Future<List<Note>?> Read() async{
         final db = await _createdb();
         final List<Map<String,dynamic>> data = await db.query(tablename);

         if(data.isEmpty){
             return null;
         } else {
           return List.generate(data.length, (index) => Note.fromJson(data[index]));
         }
    }

    static Future<int> Update(Note note) async{
        final db  = await _createdb();
        return await db.update(tablename,  note.toMap(), where: 'id = ?', whereArgs: [note.id],conflictAlgorithm: ConflictAlgorithm.replace);
    }

   static Future<int> Delete(Note note)  async{
      final db  = await _createdb();
      return await db.delete(tablename,where: 'id = ?', whereArgs: [note.id]);
   }


}