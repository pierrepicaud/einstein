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
  int state = 0;
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
    return OverlaySupport.global(child: widget.child);
  }

  void showConnectivitySnackBar(ConnectivityResult result) {
    const message = 'Internet status changed';
    const color = Colors.orange;
    showSimpleNotification(
      const Text('Internet Connectivity Update'),
      duration: const Duration(seconds: 10),
      subtitle: Text(message),
      background: color,
    );
  }

  /*void showConnectivitySnackBar(ConnectivityResult result) {
    final hasInternet = result != ConnectivityResult.none;
    //final hasInternet = state != ConnectivityResult.none;
    print(result);
    final message = hasInternet
        ? 'You have again ${result.toString()}'
        : 'You have no internet';
    final color = hasInternet ? Colors.green : Colors.red;

    showSimpleNotification(
      const Text('Internet Connectivity Update'),
      duration: const Duration(seconds: 10),
      subtitle: Text(message),
      background: color,
    );
  }*/
}
