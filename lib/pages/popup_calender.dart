
import 'package:flutter/material.dart';











class Popupboxx3 extends StatelessWidget {
  final controller;
  VoidCallback save;
  VoidCallback cancle;
  DateTime? date;

  Popupboxx3({super.key,
    required this.cancle,
    required this.controller,
    required this.save,
    required this.date,

  });



  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // backgroundColor: Colors.grey,
      content: Container(
        height: 300,
        child: Column(
          children: [
            Container(height: 50 ,
              child: Text("ADD TASK",style: TextStyle(color: Colors.black,
                fontSize: 20,
                fontFamily: 'fira-M',
              ),

              ),

            ),
            TextField(controller: controller,decoration: InputDecoration(border: OutlineInputBorder(),hintText: "Write a task...",),cursorColor: Colors.black,),
            MaterialButton(onPressed: ()async{

              date =  await  showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(3000));

            },child:const Text("Date")),

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



