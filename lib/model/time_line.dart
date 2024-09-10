import 'package:flutter/material.dart';

class TimeLineModel {
  const TimeLineModel({
    required this.title,
    required this.subtitle_1,
    required this.subtitle_2,
    required this.time,
    required this.iconDescription,
  });

  final String title;
  final String subtitle_1;
  final String subtitle_2;
  final DateTime time;
  final Icon iconDescription;
}
