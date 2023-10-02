import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:notes/db/db.dart';
import 'package:notes/pages/popup.dart';
import 'package:notes/pages/popup2.dart';
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
        db.todolist.add([_cntrl.text, false]);
      }
    });
    _cntrl.text="";
    db.updatedb();

  }




void popup2(index){
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
          title: Row(
            children: [
              SizedBox(width: 135,),
              Center(child: Text("TASKS",style: TextStyle(fontSize: 20,color: Colors.white),)),
              SizedBox(width: 90,),
              Text("${completed()}/${db.todolist.length}"),
            ],
          ),),

        backgroundColor: Colors.transparent,

        // backgroundColor: _clr,
        floatingActionButton: FloatingActionButton(
          onPressed: popup,
backgroundColor: Color(0xff6499E9),
          child: Icon(CupertinoIcons.add),
        ),
        body: Container(
          child: ListView.builder(

                //i want to display all items in array
            itemCount: db.todolist.length,
            itemBuilder: (context,index){
              return Card(
                taskname: db.todolist[index][0],
                taskcompleted: db.todolist[index][1],
                onChanged: (value)=>checkbox(value, index),
                deltaskfunction: (context)=> deltask(index),
                edittaskfunction: (context)=> popup2(index),
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

   Card({
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
                  padding: const EdgeInsets.fromLTRB(0, 7, 10, 7),
                  child: Row(
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
