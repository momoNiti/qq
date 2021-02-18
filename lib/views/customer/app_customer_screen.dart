import 'package:qq/bloc/counter/counter_bloc.dart';
import 'package:qq/cubit/queue/queue_cubit.dart';
import 'package:qq/router/route_path.dart';
import 'package:qq/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qq/views/customer/customer.dart';

class AppCustomerScreen extends StatefulWidget {
  @override
  _AppCustomerScreenState createState() => _AppCustomerScreenState();
}

class _AppCustomerScreenState extends State<AppCustomerScreen> {
  int _indexPage = 0;
  @override
  @override
  Widget build(BuildContext context) {
    final navigatorKey = GlobalObjectKey<NavigatorState>(context);
    final _customerWidgets = <Widget>[
      BlocProvider(
        create: (context) => QueueCubit(),
        child: Navigator(
          key: navigatorKey,
          initialRoute: RoutePath.customerTabHome,
          onGenerateRoute: RouterApp.generateRoute,
        ),
      ),
      BlocProvider(
        create: (context) => QueueCubit(),
        child: UserQueueTab(),
      ),
      BlocProvider(
        create: (context) => CounterBloc(),
        child: SettingCustomerTab(),
      )
    ];

    final _customerBottomWidgets = const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text('Home Page'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.queue),
        title: Text('Queue'),
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
          children: _customerWidgets,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _indexPage,
          onTap: (index) {
            setState(() {
              _indexPage = index;
            });
          },
          items: _customerBottomWidgets,
        ),
      ),
    );
  }
}
