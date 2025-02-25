import 'dart:async';

class StreamService {
  final StreamController<double> _streamController =
      StreamController<double>.broadcast();

  Stream<double> get notificationStream => _streamController.stream;

  void addNotification(double count) {
    _streamController.add(count);
  }

  void dispose() {
    _streamController.close();
  }
}