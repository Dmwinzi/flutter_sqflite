import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/Services/DatabaseHelper.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Model/Note.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {
  var i  = 0;
  var title  = TextEditingController();
  var note  = TextEditingController();
  List<Note> notes  = List.empty(growable: true);

  bool? isloading  = false;

  //fetch all data from the database

  void refreshnotes() async{
     final data  = await DatabaseHelper.Read();
     setState(() {
        notes  = data!;
        isloading  = false;
     });
  }

  //load all the data when the app starts
  @override
  void initState() {
       super.initState();
       refreshnotes();
  }

  @override
  Widget build(BuildContext context) {
    bool? check  = false;
    return Scaffold(
       appBar: AppBar(title: Text("MEMOIX",textDirection: TextDirection.ltr,),backgroundColor: Colors.amberAccent,),
       floatingActionButton: FloatingActionButton(
             backgroundColor: Colors.amberAccent,
             onPressed: () {
                 showModalBottomSheet(context: context,
                     isScrollControlled: true,
                      isDismissible: false,
                     barrierColor: Colors.black.withOpacity(0.5)
                     ,builder: (BuildContext context){
                       return Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                           child: Container(
                         height: 300.0,
                         child: Column(
                           children: [
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Padding(padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),child:
                                 Text("Add Note",textDirection: TextDirection.ltr,),),
                                 IconButton(
                                   onPressed: (){
                                     Navigator.pop(context);
                                   },
                                   icon: Icon(Icons.cancel),
                                   color: Colors.red,
                                 ),
                               ],
                             ),
                             Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 SizedBox(height: 25.0),
                                 Padding(padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0), child:
                                 TextField(
                                   controller: title,
                                   maxLines: 1,
                                   decoration: InputDecoration(
                                       label: Text("Title"),
                                       focusedBorder: OutlineInputBorder(
                                           borderSide: BorderSide(width: 2),
                                           borderRadius: BorderRadius.circular(10.0)
                                       ),
                                       enabledBorder:  OutlineInputBorder(
                                         borderSide: BorderSide(width: 2),
                                         borderRadius: BorderRadius.circular(10.0),
                                       )
                                   ),
                                 ),),

                                 SizedBox(height: 20.0),

                                 Padding(padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                                   child: TextField(
                                     controller: note,
                                     decoration: InputDecoration(
                                         label: Text("Enter Note"),
                                         focusedBorder: OutlineInputBorder(
                                             borderSide: BorderSide(width: 2),
                                             borderRadius: BorderRadius.circular(10.0)
                                         )
                                         ,
                                         enabledBorder: OutlineInputBorder(
                                             borderSide: BorderSide(width: 2),
                                             borderRadius: BorderRadius.circular(10.0)
                                         )
                                     ),
                                   ),),
                                 SizedBox(height: 20.0),
                                 ElevatedButton(onPressed: () async{
                                     String head  = title.text.trim();
                                     String nte  = note.text;
                                     if(head.isEmpty || nte.isEmpty){
                                         Fluttertoast.showToast(msg: "All fields are required",toastLength: Toast.LENGTH_LONG,
                                             gravity: ToastGravity.BOTTOM,backgroundColor: Colors.black12);
                                     } else {
                                         isloading = true;
                                         final note  = new Note(title: head,note: nte);
                                         if(note.id == null){
                                           try{
                                             await DatabaseHelper.Create(note);
                                             isloading = false;
                                             Fluttertoast.showToast(msg: "Note saved",backgroundColor: Colors.black26,
                                              gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_LONG
                                             );
                                             refreshnotes();
                                           }catch(e){
                                             isloading = false;
                                             Fluttertoast.showToast(msg: e.toString(),backgroundColor: Colors.black26,
                                                 gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_LONG
                                             );
                                             print(e.toString());
                                           }
                                         } else {
                                           isloading  = true;
                                           try{
                                             await DatabaseHelper.Update(note,note.id!);
                                             isloading = false;
                                             Fluttertoast.showToast(msg: "Note Updated",backgroundColor: Colors.black26,
                                                 gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_LONG
                                             );
                                             refreshnotes();
                                           }catch(e){
                                             isloading = false;
                                             Fluttertoast.showToast(msg: e.toString(),backgroundColor: Colors.black26,
                                                 gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_LONG
                                             );
                                             print(e.toString());
                                           }
                                         }
                                     }
                                 },
                                   child: Text("Save",textDirection: TextDirection.ltr,),
                                   style: ElevatedButton.styleFrom(
                                     fixedSize: Size(200.0, 20.0),
                                     backgroundColor: Colors.amberAccent,
                                     textStyle: TextStyle(color: Colors.black),
                                     shape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(20.0)
                                     ),
                                   ),
                                 )
                               ],
                             )
                           ],
                         ),
                       )
                       );
                 });
             },
             child: Icon(Icons.add),
       ),
      body: notes.isEmpty ? Center(child: Text("ADD NOTES",textDirection: TextDirection.ltr,style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.black26),),) :
      ListView.builder(itemCount: notes.length,itemBuilder: (BuildContext context,int index){
           return  Column(
             children:[
               ListTile(
                 onTap: (){
                   showModalBottomSheet(context: context,
                       isScrollControlled: true,
                       isDismissible: false,
                       barrierColor: Colors.black.withOpacity(0.5)
                       ,builder: (BuildContext context){
                         return Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                             child: Container(
                               height: 300.0,
                               child: Column(
                                 children: [
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Padding(padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),child:
                                       Text("Add Note",textDirection: TextDirection.ltr,),),
                                       IconButton(
                                         onPressed: (){
                                           Navigator.pop(context);
                                         },
                                         icon: Icon(Icons.cancel),
                                         color: Colors.red,
                                       ),
                                     ],
                                   ),
                                   Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       SizedBox(height: 25.0),
                                       Padding(padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0), child:
                                       TextField(
                                         controller: title,
                                         maxLines: 1,
                                         decoration: InputDecoration(
                                             label: Text(notes[index].title),
                                             focusedBorder: OutlineInputBorder(
                                                 borderSide: BorderSide(width: 2),
                                                 borderRadius: BorderRadius.circular(10.0)
                                             ),
                                             enabledBorder:  OutlineInputBorder(
                                               borderSide: BorderSide(width: 2),
                                               borderRadius: BorderRadius.circular(10.0),
                                             )
                                         ),
                                       ),),

                                       SizedBox(height: 20.0),

                                       Padding(padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                                         child: TextField(
                                           controller: note,
                                           decoration: InputDecoration(
                                               label: Text(notes[index].note),
                                               focusedBorder: OutlineInputBorder(
                                                   borderSide: BorderSide(width: 2),
                                                   borderRadius: BorderRadius.circular(10.0)
                                               )
                                               ,
                                               enabledBorder: OutlineInputBorder(
                                                   borderSide: BorderSide(width: 2),
                                                   borderRadius: BorderRadius.circular(10.0)
                                               )
                                           ),
                                         ),),
                                       SizedBox(height: 20.0),
                                       ElevatedButton(onPressed: () async{
                                         String head  = title.text.trim();
                                         String nte  = note.text;
                                         if(head.isEmpty || nte.isEmpty){
                                           Fluttertoast.showToast(msg: "All fields are required",toastLength: Toast.LENGTH_LONG,
                                               gravity: ToastGravity.BOTTOM,backgroundColor: Colors.black12);
                                         } else {
                                           isloading = true;
                                           final note  = new Note(id: notes[index].id!,title: head,note: nte);
                                             try{
                                               await DatabaseHelper.Update(note,notes[index].id!);
                                               isloading = false;
                                               Fluttertoast.showToast(msg: "Succesfully updated note",backgroundColor: Colors.black26,
                                                   gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_LONG
                                               );
                                               refreshnotes();
                                             }catch(e){
                                               isloading = false;
                                               Fluttertoast.showToast(msg: e.toString(),backgroundColor: Colors.black26,
                                                   gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_LONG
                                               );
                                               print(e.toString());
                                             }
                                         }
                                       },
                                         child: Text("Update",textDirection: TextDirection.ltr,),
                                         style: ElevatedButton.styleFrom(
                                           fixedSize: Size(200.0, 20.0),
                                           backgroundColor: Colors.amberAccent,
                                           textStyle: TextStyle(color: Colors.black),
                                           shape: RoundedRectangleBorder(
                                               borderRadius: BorderRadius.circular(20.0)
                                           ),
                                         ),
                                       )
                                     ],
                                   )
                                 ],
                               ),
                             )
                         );
                       });
                 },
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                 leading: Container(
                   child: Checkbox(
                     value: check,
                     activeColor: Colors.blue,
                     onChanged: (values){
                       setState(() {
                         check  = values;
                       });
                     },
                   ),
                 ),
                 title:Text(notes[index].id.toString()+"  "+notes[index].title,textDirection: TextDirection.ltr,),
                 trailing: IconButton(
                   onPressed: () async {
                     try{
                        await  DatabaseHelper.Delete(notes[index].id!);
                        refreshnotes();
                        Fluttertoast.showToast(msg: "Succesfully deleted note!!",toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.black12
                        );
                     } catch(e){
                        Fluttertoast.showToast(msg: e.toString(),toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.CENTER,
                             backgroundColor: Colors.black12
                        );
                     }
                   },
                   icon: Icon(Icons.delete),
                   color: Colors.red,
                 ),
               ),
               Divider()
             ],
           );
      },),

    );
  }
}



