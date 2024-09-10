import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/db/db.dart';
import 'package:notes/pages/popup/popup.dart';
import 'package:notes/pages/popup/popup2.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';




class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  //referencinf the box
  final box = Hive.box("box");
  Tododb db = Tododb();

@override
  void initState() {
    // TODO: implement initState
  if(box.get("TODOLIST")==null){

    db.initd();
  }else{
    db.loaddb();
  }
    super.initState();
  }



  final _clr = Colors.blueAccent;
  final _bgclr = Colors.blue[50];

  // final _clr = Colors.lightBlue.shade800;
  final _cntrl = TextEditingController();
  final _cntrl2 = TextEditingController();



  void checkbox(bool? value, int index){
  setState(() {
    db.todolist[index][1] = !db.todolist[index][1];
  });
  db.updatedb();
}

void popup(){
  showDialog(
      context: context,
      builder: (context){
        return Popupboxx(
cancle: () { Navigator.of(context).pop();
_cntrl.text="";
},
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
        db.todolist.add([_cntrl.text, false]);
      }
    });
    _cntrl.text="";
    db.updatedb();

  }




void popup2(index){
  for (int i =0;i<db.todolist.length;i++){
      setState(() {
        _cntrl2.text= db.todolist[index][0];
      });



  }

  showDialog(
        context: context,
        builder: (context){
          return Popupboxx2(
            cancle: ()=>Navigator.of(context).pop(),
            controller: _cntrl2,
            save: ()=> {save2(index),    Navigator.of(context).pop()
          },
          );
        }
    );
  }

  void save2(index){

    setState(() {
      if(_cntrl2.text==""){}else {
        db.todolist[index][0]=_cntrl2.text;
      }
    });
    _cntrl2.text="";
    db.updatedb();

  }



  void deltask(index){
  setState(() {
    db.todolist.removeAt(index);
  });
  db.updatedb();
  ()=>Navigator.of(context).pop();
}


int completed(){
    int i,c=0;
    for(i=0;i<db.todolist.length;i++){
      if(db.todolist[i][1]){c++;}
    }
    return c;
}

  @override
  Widget build(BuildContext context) {
    return Container(
color: _bgclr,


      child: Scaffold(
        appBar:AppBar(
          elevation: 0,
          backgroundColor: const Color(0xff6499E9),
          // backgroundColor: Colors.blue.shade300,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 35,
                height: 10,
              ),
              Center(child: Text("TASKS",style: GoogleFonts.exo(fontSize: 22,color: Colors.white),)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                    child: Text("${completed()}/${db.todolist.length}")),
              ),
            ],
          ),),

        backgroundColor: Colors.transparent,

        // backgroundColor: _clr,
        floatingActionButton: FloatingActionButton(
          onPressed: popup,
          backgroundColor: Color(0xff6499E9),
          child: Icon(CupertinoIcons.add),
        ),
        body: SingleChildScrollView(
          child: Column(
              children: <Widget>[
                ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                      //i want to display all items in array
                  itemCount: db.todolist.length,
                  itemBuilder: (context,index){
                    return TaskCard(
                      taskname: db.todolist[index][0],
                      taskcompleted: db.todolist[index][1],
                      onChanged: (value)=>checkbox(value, index),
                      deltaskfunction: (context)=> showDialog(context: context, builder: (context)=>AlertDialog(
                        backgroundColor: Colors.blue[100],
                        content: Container(
                          height: 110,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(height: 50 ,
                                child: Text("PROCEED WITH DELETION?",style: GoogleFonts.exo(color: Colors.black,
                                  fontSize: 17,

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
                      edittaskfunction: (context)=> popup2(index),
                      color: _clr,
                    );
                  },

                ),


                //BOTTOM 3 INVISIBLE BOXES
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 10, 4, 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: 60,
                          width: 60,
                          color: Colors.transparent,



                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 10, 4, 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: 60,
                          width: 60,
                          color: Colors.transparent,


                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 10, 4, 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: 60,
                          width: 60,
                          color: Colors.transparent,


                        ),
                      ),
                    ),


                  ],
                ),
              ],
            ),
        ),

      ),
    );
  }
}










//ACB4C7

// class Card extends StatelessWidget {
//   final String taskname;
//   final bool taskcompleted;
//   final color;
//   Function(bool?)? onChanged;
//   Function(BuildContext)? deltaskfunction;
//   Function(BuildContext)? edittaskfunction;
//
//    Card({
//      super.key,
//      required this.taskcompleted,
//      required this.taskname,
//      required this.onChanged,
//      required this.deltaskfunction,
//      required this.edittaskfunction,
//      required this.color,
//    });
//
//   @override
//   Widget build(BuildContext context) {
//     return   Column(
//       children: [
// // Container(height: 0.1,color: Colors.white,),
//         Padding(
//
//           padding: const EdgeInsets.fromLTRB(20, 7, 20, 0),
//
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(3.0),
//
//
//             child: Slidable(
//               startActionPane: ActionPane(
//                 extentRatio: 0.2,
//                 motion: StretchMotion(),
//                 children: [
//                   SlidableAction(
//                     onPressed: edittaskfunction,
//                     icon: Icons.edit,
//                     backgroundColor: Colors.black,
//                   )
//                 ],
//               ),
//               endActionPane: ActionPane(
//                 extentRatio: 0.2,
//                 motion: StretchMotion(),
//                 children: [
//                   SlidableAction(
//                     onPressed: deltaskfunction,
//                     icon: Icons.delete,
//                     backgroundColor: Colors.black,
//                   )
//                 ],
//               ),
//
//               child: Container(
//                 constraints: BoxConstraints(
//                     minHeight: 50
//                   ),
//
//
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(0, 7, 10, 7),
//                   child: Row(
//                     children: [
//                       Checkbox(value: taskcompleted,
//                           onChanged: onChanged,
//                           activeColor: Colors.blue.shade800,
//
//
//                       ),
//
//
//                       Flexible(
//                         child: Text(taskname,
//                           softWrap: true,
//                           style: GoogleFonts.exo(color: Color(0xff000000),
//                             fontSize: 14,
//                               // fontFamily: 'fira-M',
//
//                           decoration: taskcompleted? TextDecoration.lineThrough:TextDecoration.none
//                           ),),
//                       )
//
//                     ],
//                   ),
//                 ),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Colors.blue.shade200,
//
//                       Colors.blueAccent.shade100,
//
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight
//                   ),
//                     // color: Colors.transparent,
//                     // color: color,
//                     ),
//               ),
//             ),
//           ),
//         ),
//
//       ],
//     );
//   }
// }


class TaskCard extends StatelessWidget {
  final String taskname;
  final bool taskcompleted;
  final Color color;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deltaskfunction;
  final Function(BuildContext)? edittaskfunction;

  TaskCard({
    super.key,
    required this.taskcompleted,
    required this.taskname,
    required this.onChanged,
    required this.deltaskfunction,
    required this.edittaskfunction,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Trigger the same function as Checkbox onChanged
        onChanged?.call(!taskcompleted);
      },
      child: Column(
        children: [
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
                      onPressed: (context) => edittaskfunction?.call(context),
                      icon: Icons.edit,
                      backgroundColor: Colors.black,
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  extentRatio: 0.2,
                  motion: StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) => deltaskfunction?.call(context),
                      icon: Icons.delete,
                      backgroundColor: Colors.black,
                    ),
                  ],
                ),
                child: Container(
                  constraints: BoxConstraints(minHeight: 50),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 7, 10, 7),
                    child: Row(
                      children: [
                        Checkbox(
                          value: taskcompleted,
                          onChanged: (bool? newValue) {
                            // Trigger the Checkbox's onChanged
                            onChanged?.call(newValue);
                          },
                          activeColor: Colors.blue.shade800,
                        ),
                        Flexible(
                          child: Text(
                            taskname,
                            softWrap: true,
                            style: GoogleFonts.exo(
                              color: Colors.black,
                              fontSize: 14,
                              decoration: taskcompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade200,
                        Colors.blueAccent.shade100,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    color: color,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
