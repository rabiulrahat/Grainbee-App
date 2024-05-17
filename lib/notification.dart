import 'package:flutter/material.dart';

class Notification {
  final NotificationType type;
  final String message;
  final DateTime timestamp;

  Notification({required this.type, required this.message})
      : timestamp = DateTime.now();
}

enum NotificationType {
  orderPlaced,
}
