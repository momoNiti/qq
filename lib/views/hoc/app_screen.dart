import 'package:qq/bloc/counter/counter_bloc.dart';
import 'package:qq/cubit/queue/queue_cubit.dart';
import 'package:qq/router/route_path.dart';
import 'package:qq/router/router.dart';
import 'package:qq/views/user_queue_page.dart';
import 'package:qq/views/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppScreen extends StatefulWidget {
  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int _indexPage = 0;
  @override
  Widget build(BuildContext context) {
    final navigatorKey = GlobalObjectKey<NavigatorState>(context);
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
          children: [
            BlocProvider(
              create: (context) => QueueCubit(),
              child: Navigator(
                key: navigatorKey,
                initialRoute: RoutePath.tabHome,
                onGenerateRoute: RouterApp.generateRoute,
              ),
            ),
            BlocProvider(
              create: (context) => QueueCubit(),
              child: UserQueuePage(),
            ),
            BlocProvider(
              create: (context) => CounterBloc(),
              child: SettingPage(),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _indexPage,
          onTap: (index) {
            setState(() {
              _indexPage = index;
            });
          },
          items: const <BottomNavigationBarItem>[
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
          ],
        ),
      ),
    );
  }
}