import 'package:qq/bloc/counter/counter_bloc.dart';
import 'package:qq/cubit/queue/queue_cubit.dart';
import 'package:qq/router/route_path.dart';
import 'package:qq/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qq/views/customer/customer.dart';

class AppManagerScreen extends StatefulWidget {
  @override
  _AppManagerScreenState createState() => _AppManagerScreenState();
}

class _AppManagerScreenState extends State<AppManagerScreen> {
  int _indexPage = 0;
  @override
  @override
  Widget build(BuildContext context) {
    final navigatorKey = GlobalObjectKey<NavigatorState>(context);
    final _managerWidgets = <Widget>[
      // BlocProvider(
      // create: (context) => QueueCubit(),
      // child:
      Navigator(
        key: navigatorKey,
        initialRoute: RoutePath.managerTabQueueManage,
        onGenerateRoute: RouterApp.generateRoute,
      ),
      // ),
      // BlocProvider(
      //   create: (context) => QueueCubit(),
      // child:
      Text("TEMP MANAGER"),
      // ),
      // BlocProvider(
      // create: (context) => CounterBloc(),
      // child:
      Text("TEMP MANAGER"),
      // )
    ];

    final _managerBottomWidgets = const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text('Queue Management'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.queue),
        title: Text('Stock Management'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        title: Text('Setting'),
      ),
    ];

    return WillPopScope(
      onWillPop: () async {
        if (navigatorKey.currentState.canPop()) {
          navigatorKey.currentState.pop();
          return false;
        }

        return true;
      },
      child: Scaffold(
        body: IndexedStack(
          index: _indexPage,
          children: _managerWidgets,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _indexPage,
          onTap: (index) {
            setState(() {
              _indexPage = index;
            });
          },
          items: _managerBottomWidgets,
        ),
      ),
    );
  }
}
