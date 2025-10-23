import 'package:flutter/foundation.dart';

/// Flow driver controlls
class FlowDrawerController extends ChangeNotifier {
  bool _isOpen = false;

  /// simple get fn for getting state
  bool get isOpen => _isOpen;

  /// ctrl.open() trigger the controller to open the drawer
  void open() {
    _isOpen = true;
    notifyListeners();
  }

  /// ctrl.open() trigger the controller to close the drawer
  void close() {
    _isOpen = false;
    notifyListeners();
  }

  /// ctrl.open() trigger the controller to close the drawer

  void toggle() {
    _isOpen = !_isOpen;
    notifyListeners();
  }
}
