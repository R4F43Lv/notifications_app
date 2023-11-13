import 'package:flutter/material.dart';
import 'package:test_firebase_push/main.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list = <String, WidgetBuilder>{
    '/home': (_) => const MyHomePage(title: 'Home'),
    '/notificacao':(_) => const NotificacaoPage(), 
  };

  static String initial = '/home';

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
}