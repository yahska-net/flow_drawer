import 'package:flutter/foundation.dart';

/// Controls whether a [FlowDrawer] is open or closed.
class FlowDrawerController extends ChangeNotifier {
  bool _isOpen = false;

  /// Whether the drawer is currently open.
  bool get isOpen => _isOpen;

  /// Opens the drawer.
  void open() {
    if (_isOpen) return;
    _isOpen = true;
    notifyListeners();
  }

  /// Closes the drawer.
  void close() {
    if (!_isOpen) return;
    _isOpen = false;
    notifyListeners();
  }

  /// Toggles the drawer between its open and closed states.
  void toggle() {
    _isOpen = !_isOpen;
    notifyListeners();
  }
}
