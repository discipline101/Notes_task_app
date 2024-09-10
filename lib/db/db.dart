import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Tododb{
List todolist = [];

//reference box
final box = Hive.box("box");

//init
void initd(){
  todolist = [
    ["Slide to Right --->",false]
  ];
}


void loaddb(){
  todolist = box.get("TODOLIST");
}

void updatedb(){
  box.put("TODOLIST", todolist);
}

}


