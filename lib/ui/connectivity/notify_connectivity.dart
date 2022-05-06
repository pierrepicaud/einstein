import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
//import 'package:connectivity/connectivity.dart';
import 'package:overlay_support/overlay_support.dart';

class NotifyConnectivity extends StatefulWidget {
  final Widget child;
  const NotifyConnectivity({Key? key, required this.child}) : super(key: key);

  @override
  State<NotifyConnectivity> createState() => _NotifyConnectivityState();
}

class _NotifyConnectivityState extends State<NotifyConnectivity> {
  late StreamSubscription subscription;

  @override
  void initState() {
    super.initState();

    subscription =
        Connectivity().onConnectivityChanged.listen(showConnectivitySnackBar);
  }

  @override
  void dispose() {
    subscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void showConnectivitySnackBar(ConnectivityResult result) {
    print('reacted');
    final hasInternet = result != ConnectivityResult.none;
    final message = hasInternet
        ? 'You have again ${result.toString()}'
        : 'You have no internet';
    final color = hasInternet ? Colors.green : Colors.red;

    showSimpleNotification(
      const Text('Internet Connectivity Update'),
      subtitle: Text(message),
      background: color,
    );
  }
}
