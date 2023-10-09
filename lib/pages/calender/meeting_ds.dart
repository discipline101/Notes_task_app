
import 'dart:math';

import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:notes/pages/calender/meeting.dart';
import 'dart:ui';
Color getColoor() {
  int i = Random().nextInt(10);
  switch (i) {
    case 0:
      return Color(0xfffa7746); // Light Salmon (Slightly Darker, Contrast with white text)
    case 1:
      return Color(0xffFF6EB4); // A slightly darker Pink (Contrast with white text)
    case 2:
      return Color(0xffFFA500); // Orange (Slightly Darker, Contrast with white text)
    case 3:
      return Color(0xffFF6347); // Tomato (Slightly Darker, Contrast with white text)
    case 4:
      return Color(0xff90EE90); // Chocolate (Slightly Darker, Contrast with white text)
    case 5:
      return Color(0xff8A2BE2); // Blue Violet (Slightly Darker, Contrast with white text)
    case 6:
      return Color(0xffFF8C00); // Dark Orange (Slightly Darker, Contrast with white text)
    case 7:
      return Color(0xff9932CC); // Dark Orchid (Slightly Darker, Contrast with white text)
    case 8:
      return Color(0xff8181ff); // Sea Green (Slightly Darker, Contrast with white text)
    case 9:
      return Color(0xffFF1493); // Deep Pink (Slightly Darker, Contrast with white text)
    default:
      return Color(0xff0000ff); // Default to Blue
  }
}

class MeetingDataSource extends CalendarDataSource{
  MeetingDataSource(List<Meeting>? source){
    appointments = source;
  }

  @override
  DateTime getStartTime(int index){
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index){
    return appointments![index].to;
  }

  @override
  String getSubject(int index){
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index){
    return getColoor();
  }

  @override
  bool isAllDay(int index){
    return appointments![index].isAllDay;
  }

}