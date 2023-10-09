

import 'package:get/get.dart';

class TapController extends GetxController{
  //private variables
    DateTime? _date;
    String? _time1,_time2;

    int? _speed;


    //this is how we access them from outside
    DateTime? get aa=>_date;
    String? get bb=>_time1;
    String? get cc=>_time2;

    int? get spd=>_speed;

    save(DateTime? x){
      _date=x;
      update();
    }
    save1(String? x){
      _time1=x;
      update();
    }
    save2(String? x){
      _time2 =x;
      update();
    }
    save3(int? x){
      _speed=x;
      update();
}



}