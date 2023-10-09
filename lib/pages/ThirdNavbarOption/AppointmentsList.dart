import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';

import '../../db/calenderDB.dart';
import '../../db/db.dart';
// import 'package:notes/db/db.dart';
// import 'package:notes/pages/popup.dart';
// import 'package:notes/pages/popup2.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';




class AppointmentList extends StatefulWidget {
  const AppointmentList({super.key});

  @override
  State<AppointmentList> createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {

  int c= 0;


  List todolist=[
    [
      "apple is not honey... \nor is it",
      false,
      "date",
      "time1",
      "time2",
      "orderby",
    ]
  ];




  final box2 = Hive.box("box2");
  calenDB calendb = calenDB();


@override
  void initState() {
    // TODO: implement initState
  if(calendb.initialiseappointments()!=null  && c==0) {
    // todolist=[];
    todolist = calendb.initialiseappointments();
    print(calendb.initialiseappointments());
    todolist.sort((a,b)=>
        a[5].compareTo(b[5])
    );
    c=1;
    print(c);
  }
 //sorting the list


    super.initState();
  }




  //
  // final box = Hive.box("box");
  // Tododb db = Tododb();
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //
  //   super.initState();
  // }
  //
  //


  final _clr = Colors.blueAccent;
  final _bgclr = Colors.blue[50];

  // final _clr = Colors.lightBlue.shade800;
  final _cntrl = TextEditingController();
  final _cntrl2 = TextEditingController();



  void checkbox(bool? value, int index){
    setState(() {
      todolist[index][1] = !todolist[index][1];
    });
    // db.updatedb();
  }

  void popup(){
    showDialog(
        context: context,
        builder: (context){
          return Popupboxx(
            cancle: ()=>Navigator.of(context).pop(),
            controller: _cntrl,
            save: ()=>{
              save(),
              Navigator.of(context).pop()
            },
          );
        }
    );
  }

  void save(){
    setState(() {
      if(_cntrl.text==""){}else {
        todolist.add([_cntrl.text, false]);
      }
    });
    _cntrl.text="";
    // db.updatedb();

  }




  void popup2(index){
    showDialog(
        context: context,
        builder: (context){
          return Popupboxx2(
            cancle: ()=>Navigator.of(context).pop(),
            controller: _cntrl2,
            save: ()=> {save2(index),
              Navigator.of(context).pop()
            },
          );
        }
    );
  }

  void save2(index){
    setState(() {
      if(_cntrl2.text==""){}else {
        setState(() {
          todolist[index][0]=_cntrl2.text;
          calendb.meetings3[index].eventName=_cntrl2.text;
          calendb.updatedb2();
        });

      }
    });
    _cntrl2.text="";
    // db.updatedb();

  }



  // void delpopup(index){
  //   showDialog(context: context,
  //       builder: (context){
  //     return Areyousure(index: index,);
  //       }
  //   );
  // }


  void deltask(index){

    setState(() {

      print(calendb.meetings3.length);
      for(int i= 0;i<calendb.meetings3.length;i++){
        if ( calendb.meetings3[i].eventName==todolist[index][0]  && calendb.meetings3[i].from.toString()==todolist[index][5] ){

          calendb.delete(i);
          todolist.removeAt(index);
          calendb.updatedb2();
        }
      }

    });

    // db.updatedb();
        ()=>Navigator.of(context).pop();
  }


  // int completed(){
  // int i,c=0;
  // for(i=0;i<db.todolist.length;i++){
  // if(db.todolist[i][1]){c++;}
  // }
  // return c;
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _bgclr,
      child: Scaffold(
        appBar:AppBar(
          elevation: 0,
          backgroundColor: const Color(0xff6499E9),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text("SCHEDULE",style: TextStyle(fontSize: 22,color: Colors.white),)),
              Text(""),
            ],
          ),),

        backgroundColor: Colors.transparent,

        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Color(0xff6499E9),
        //   child: Icon(CupertinoIcons.add),
        //   onPressed: popup,
        //
        // ),





        body: Container(
          child: ListView.builder(

            //i want to display all items in array
            itemCount: todolist.length,
            itemBuilder: (context,index){
              return Card(
                taskname: todolist[index][0],
                taskcompleted: todolist[index][1],
                onChanged: (value)=>checkbox(value, index),
                edittaskfunction: (context)=> popup2(index),
                deltaskfunction: (context)=>showDialog(context: context, builder: (context)=>AlertDialog(
                  backgroundColor: Colors.blue[100],
                  content: Container(
                    height: 110,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(height: 50 ,
                          child: Text("PROCEED WITH DELETION?",style: TextStyle(color: Colors.black,
                            fontSize: 17,
                            fontFamily: 'fira-M',
                          ),

                          ),

                        ),

                        SizedBox(height: 2,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(onPressed: ()=>Navigator.of(context).pop(), child: Text("NO"),),

                            SizedBox(width: 20,),
                            ElevatedButton(onPressed: (){ deltask(index);Navigator.of(context).pop();}, child: Text("YES"),),

                          ],
                        )
                      ],
                    ),
                  ),
                )),

                date:  todolist[index][2],
                time1: todolist[index][3],
                time2: todolist[index][4],

                color: _clr,
              );
            },

          ),
        ),
      ),
    );
  }
}










//ACB4C7

class Card extends StatelessWidget {
  final String taskname;
  final bool taskcompleted;
  final color;
  Function(bool?)? onChanged;
  Function(BuildContext)? deltaskfunction;
  Function(BuildContext)? edittaskfunction;
  final date;
  final time1;
  final time2;

  Card({
    super.key,
    required this.taskcompleted,
    required this.taskname,
    required this.onChanged,
    required this.deltaskfunction,
    required this.edittaskfunction,
    required this.color,

    required this.date,
    required this.time1,
    required this.time2
  });

  @override
  Widget build(BuildContext context) {
    return   Column(
      children: [
// Container(height: 0.1,color: Colors.white,),
        Padding(

          padding: const EdgeInsets.fromLTRB(20, 7, 20, 0),

          child: ClipRRect(
            borderRadius: BorderRadius.circular(3.0),


            child: Slidable(
              startActionPane: ActionPane(
                extentRatio: 0.2,
                motion: StretchMotion(),
                children: [
                  SlidableAction(
                    onPressed: edittaskfunction,
                    icon: Icons.edit,
                    backgroundColor: Colors.black,
                  )
                ],
              ),
              endActionPane: ActionPane(
                extentRatio: 0.2,
                motion: StretchMotion(),
                children: [
                  SlidableAction(
                    onPressed: deltaskfunction,
                    icon: Icons.delete,
                    backgroundColor: Colors.black,
                  )
                ],
              ),

              child: Container(
                constraints: BoxConstraints(
                    minHeight: 50
                ),


                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12, 10, 12),
                  child: Column(
                    children: [


                      Padding(

                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: Container(
                                color: Colors.blue,
                                constraints: BoxConstraints(
                                    minWidth: 70
                                ),

                                child: Padding(
                                  padding:EdgeInsets.fromLTRB(3, 2, 3, 2),
                                  child: Container(
                                    child: Center(child: Text("${date}",style: TextStyle(color: Colors.white))),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),


                      Row(
                        children: [
                          Checkbox(value: taskcompleted,
                            onChanged: onChanged,
                            activeColor: Colors.blue.shade800,


                          ),


                          Flexible(
                            child: Text(taskname,
                              softWrap: true,
                              style: TextStyle(color: Color(0xff000000),
                                  fontSize: 13.5,
                                  fontFamily: 'fira-M',

                                  decoration: taskcompleted? TextDecoration.lineThrough:TextDecoration.none
                              ),),
                          )

                        ],
                      ),


                      Padding(

                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: Container(
                                color: Colors.blue,
                                constraints: BoxConstraints(
                                    minWidth: 50
                                ),

                                child: Padding(
                                  padding:EdgeInsets.fromLTRB(3, 2, 3, 2),
                                  child: Container(
                                    child: Center(child: Text("${time1}",style: TextStyle(color: Colors.white))),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(child: Container(color: Colors.blue,height: 1,)),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: Container(
                                color: Colors.blue,
                                constraints: BoxConstraints(
                                    minWidth: 50
                                ),

                                child: Padding(
                                  padding:EdgeInsets.fromLTRB(3, 2, 3, 2),
                                  child: Container(
                                    child: Center(child: Text("${time2}",style: TextStyle(color: Colors.white),)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),




                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.blueAccent.shade100,
                        Colors.blue.shade200

                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight
                  ),
                  // color: Colors.transparent,
                  // color: color,
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}


// import 'package:flutter/material.dart';

class Popupboxx extends StatelessWidget {
  final controller;
  VoidCallback save;
  VoidCallback cancle;

  Popupboxx({super.key,
    required this.cancle,
    required this.controller,
    required this.save,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue[100],
      content: Container(
        height: 190,
        child: Column(
          children: [
            Container(height: 50 ,
              child: Text("ADD TASK",style: TextStyle(color: Colors.black,
                fontSize: 20,
     
              ),

              ),

            ),
            TextField(controller: controller,decoration: InputDecoration(border: OutlineInputBorder(),hintText: "Write a task...",),cursorColor: Colors.black,),

            SizedBox(height: 24,),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(onPressed: cancle, child: Text("cancle"),),
                SizedBox(width: 20,),
                ElevatedButton(onPressed: save, child: Text("save"),),


              ],
            )
          ],
        ),
      ),
    );
  }
}


//
// class Areyousure extends StatelessWidget {
//   final index;
//   const Areyousure({super.key,
//   required this.index
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ;
//   }
// }


// import 'package:flutter/material.dart';

class Popupboxx2 extends StatelessWidget {
  final controller;
  VoidCallback save;
  VoidCallback cancle;

  Popupboxx2({super.key,
    required this.cancle,
    required this.controller,
    required this.save,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue[100],
      content: Container(
        height: 190,
        child: Column(
          children: [
            Container(height: 50 ,
              child: Text("EDIT TASK",style: TextStyle(color: Colors.black,
                fontSize: 20,
                fontFamily: 'fira-M',
              ),

              ),

            ),
            TextField(controller: controller,decoration: InputDecoration(border: OutlineInputBorder(),hintText: "Write...",),cursorColor: Colors.black,),

            SizedBox(height: 24,),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(onPressed: cancle, child: Text("cancle"),),

                SizedBox(width: 20,),
                ElevatedButton(onPressed: save, child: Text("save"),),

              ],
            )
          ],
        ),
      ),
    );
  }
}







