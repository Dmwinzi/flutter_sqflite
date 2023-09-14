import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {
  var i  = 0;
  var title  = TextEditingController();
  var note  = TextEditingController();

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
                                 ElevatedButton(onPressed: (){},
                                   child: Text("Save",textDirection: TextDirection.ltr,),
                                   style: ElevatedButton.styleFrom(
                                     fixedSize: Size(200.0, 20.0),
                                     backgroundColor: Colors.amberAccent,
                                     textStyle: TextStyle(color: Colors.black),
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

      body: ListView.builder(itemCount: 20,itemBuilder: (BuildContext context,int index){

           return Column(
             children:[
               ListTile(
                 onTap: (){},
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
                 title:Text("Hello world",textDirection: TextDirection.ltr,),
                 trailing: IconButton(
                   onPressed: (){},
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
