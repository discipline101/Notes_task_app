import 'package:flutter/material.dart';

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




