import 'package:ajeeb/models/eventManager.dart';
import 'package:ajeeb/authenticate/authenticateEventManager.dart';
import 'package:ajeeb/screens/EventManager/homeEvent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WrapperEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final eventManager = Provider.of<EventManager>(context);
    print(eventManager);

    // return either the Home or Authenticate widget
    if (eventManager == null){
      return AuthenticateEventManager();
    } else {
      return HomePage();
    }

  }
}