import 'package:flutter/material.dart';

final notifications = [
  Notification(
    type: NotificationType.productAddedToCart,
    message: 'Product added to cart',
  ),
  Notification(
    type: NotificationType.orderPlaced,
    message: 'Order placed successfully',
  ),
  Notification(
    type: NotificationType.orderDelivered,
    message: 'Order delivered on DD-MM-YYYY',
  ),
];

class Notification {
  final NotificationType type;
  final String message;

  Notification({required this.type, required this.message});
}

enum NotificationType {
  productAddedToCart,
  orderPlaced,
  orderDelivered,
}

class NotificationPage extends StatelessWidget {
  final List<Notification> notifications;

  NotificationPage({Key? key, required this.notifications}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 61, 59, 59), //
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          final icon = _getNotificationIcon(notification.type);
          final color = _getNotificationColor(notification.type);
          return ListTile(
            leading: Icon(icon, color: color),
            title: Text(notification.message),
            trailing: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                // TODO: Remove notification from list
              },
            ),
          );
        },
      ),
    );
  }

  IconData _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.productAddedToCart:
        return Icons.shopping_cart;
      case NotificationType.orderPlaced:
        return Icons.check_circle;
      case NotificationType.orderDelivered:
        return Icons.local_shipping;
      default:
        return Icons.notifications;
    }
  }

  Color _getNotificationColor(NotificationType type) {
    switch (type) {
      case NotificationType.productAddedToCart:
        return Colors.orange;
      case NotificationType.orderPlaced:
        return Colors.green;
      case NotificationType.orderDelivered:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
