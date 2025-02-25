import 'dart:async';

class NotificationService {
  final StreamController<double> _notificationController =
      StreamController<double>.broadcast();

  Stream<double> get notificationStream => _notificationController.stream;

  void addNotification(double count) {
    _notificationController.add(count);
  }

  void dispose() {
    _notificationController.close();
  }
}