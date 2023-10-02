import 'dart:ui';

import 'package:hive/hive.dart';
part 'meeting.g.dart';
//register as adapter ----------------------------------------https://www.youtube.com/watch?v=7pKx1DHSTkU

@HiveType(typeId: 33)
class Meeting{
  Meeting(
      this.from,
      this.to,
      this.eventName,
      // this.background,
      this.isAllDay,
      );
  @HiveField(0)
  String eventName;
  @HiveField(1)
  DateTime from;
  @HiveField(2)
  DateTime to;
  // @HiveField(3)
  // String background;
  @HiveField(3)
  bool isAllDay;


}