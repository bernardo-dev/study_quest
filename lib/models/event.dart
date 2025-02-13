import 'package:flutter/material.dart';

class Event {
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final Color backgroundColor;
  final bool isAllDay;

  const Event({
    required this.from,
    required this.to,
    this.title = '(Sem título)',
    this.description = '',
    this.backgroundColor = Colors.blue,
    this.isAllDay = false,
  });
}
