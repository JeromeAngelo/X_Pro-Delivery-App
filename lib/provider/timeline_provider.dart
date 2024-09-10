import 'package:flutter/material.dart';
import 'package:x_pro_delivery_app/data/timelineData.dart';
import 'package:x_pro_delivery_app/model/time_line.dart';

class TimelineProvider extends ChangeNotifier {
  List<TimeLineModel> _timeline = [];
  AnimationController? _animationController;
  bool _isMapVisible = true;
  bool _isDeliveryCompleted = false;
  String _currentDeliveryStatus = 'In Transit';

  List<TimeLineModel> get timeline => _timeline;
  AnimationController? get animationController => _animationController;
  bool get isMapVisible => _isMapVisible;
  bool get isDeliveryCompleted => _isDeliveryCompleted;
  String get currentDeliveryStatus => _currentDeliveryStatus;

  void setAnimationController(AnimationController controller) {
    _animationController = controller;
  }

  void setInitialPendingStatus() {
    if (_timeline.isEmpty) {
      updateTimeline('Pending');
    }
  }

  void toggleMapVisibility() {
    _isMapVisible = !_isMapVisible;
    notifyListeners();
  }

  void setDeliveryCompleted(bool value) {
    _isDeliveryCompleted = value;
    notifyListeners();
  }

  void addStatus(TimeLineModel status) {
    final updatedStatus = TimeLineModel(
      title: status.title,
      subtitle_1: status.subtitle_1,
      subtitle_2: status.subtitle_2,
      time: DateTime.now(),
      iconDescription: status.iconDescription,
    );
    _timeline.add(updatedStatus);
    notifyListeners();
  }

  void updateTimeline(String status) {
    if (_timeline.isEmpty || _timeline.first.title != status) {
      TimeLineModel newStatus = dummyTimeLineData.firstWhere(
        (element) => element.title == status,
        orElse: () => dummyTimeLineData.first,
      );
      newStatus = TimeLineModel(
        title: newStatus.title,
        subtitle_1: newStatus.subtitle_1,
        subtitle_2: newStatus.subtitle_2,
        time: DateTime.now(), // Use current time
        iconDescription: newStatus.iconDescription,
      );
      _timeline = [newStatus, ..._timeline];
      _animationController?.forward(from: 0.0);

      if (status == 'Arrived') {
        _isMapVisible = false;
      }
      notifyListeners();
    }
  }

  void updateDeliveryStatus(String status) {
    if (status == 'End Delivery') {
      _currentDeliveryStatus = 'End Delivery';
      setDeliveryCompleted(true);
    } else {
      _currentDeliveryStatus = status;
    }
    updateTimeline(_currentDeliveryStatus);
    notifyListeners();
  }

  void undoLastStatus() {
    if (_timeline.isNotEmpty) {
      _timeline.removeAt(0);
      notifyListeners();
    }
  }
}
