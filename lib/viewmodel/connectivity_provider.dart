import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityProvider extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();

  bool _isConnected = true;
  bool get isConnected => _isConnected;

  StreamSubscription<List<ConnectivityResult>>? _subscription;

  ConnectivityProvider() {
    _init();
  }

  void _init() async {
    final results = await _connectivity.checkConnectivity(); // ✅ already List
    _update(results); // ✅ no wrapping

    _subscription =
        _connectivity.onConnectivityChanged.listen(_update);
  }

  void _update(List<ConnectivityResult> results) {
    final previous = _isConnected;

    _isConnected = results.contains(ConnectivityResult.wifi) ||
        results.contains(ConnectivityResult.mobile);

    if (previous != _isConnected) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}