import 'package:flutter/material.dart';
import 'package:qq/net/authentication_repository.dart';
import 'package:provider/provider.dart';
import 'package:qq/theme/theme.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold(
      {Key key,
      this.body,
      this.prevPage,
      this.appBar,
      this.floatingActionButton,
      this.bottomNavigationBar,
      this.backgroundColor,
      this.floatingActionButtonLocation,
      this.isShowfloatingActionButtonShowFloat = false})
      : super(key: key);
  final Widget body;
  final String prevPage;
  final AppBar appBar;
  final Widget floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final bool isShowfloatingActionButtonShowFloat;
  final Widget bottomNavigationBar;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar != null
          ? AppBar(
              backgroundColor: backgroundColor,
              title: appBar.title,
              actions: [
                RaisedButton(
                  onPressed: () =>
                      context.read<AuthenticationRepository>().signOut(),
                  child: Text("logout"),
                ),
              ],
              iconTheme: appBar.iconTheme,
              centerTitle: true,
              automaticallyImplyLeading: true,
              leading: null,
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: KConstant.paddingTop),
        child: body,
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}
