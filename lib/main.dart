import 'package:qq/bloc/authentication/authentication_bloc.dart';
import 'package:qq/models/user.dart';
import 'package:qq/net/authentication_repository.dart';
import 'package:qq/router/route_path.dart';
import 'package:qq/router/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(
    authenticationRepository: AuthenticationRepository(),
  ));
}

class MyApp extends StatefulWidget {
  final AuthenticationRepository authenticationRepository;

  const MyApp({Key key, @required this.authenticationRepository})
      : assert(authenticationRepository != null),
        super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: widget.authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: widget.authenticationRepository,
        ),
        child: MaterialApp(
          title: 'Emo Tracker Babe',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          navigatorKey: _navigatorKey,
          onGenerateRoute: RouterApp.generateRoute,
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state.status == AuthenticationStatus.authenticated &&
                    state.user.role == UserRole.customer) {
                  // debugPrint("=========Authen=========");
                  _navigator.pushNamedAndRemoveUntil<void>(
                      RoutePath.appCustomerScreen, (route) => false);
                }

                if (state.status == AuthenticationStatus.authenticated &&
                    state.user.role == UserRole.manager) {
                  // debugPrint("=========Authen=========");
                  _navigator.pushNamedAndRemoveUntil<void>(
                      RoutePath.appManagerScreen, (route) => false);
                }

                if (state.status == AuthenticationStatus.unauthenticated) {
                  // debugPrint("=========UNAuthen=========");
                  _navigator.pushNamedAndRemoveUntil(
                      RoutePath.login, (route) => false);
                }
              },
              child: child,
            );
          },
        ),
      ),
    );
  }
}
