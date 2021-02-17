import 'package:flutter/material.dart';
import 'package:qq/views/hoc/app_scaffold.dart';

class QueueManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text("Queue Management"),
      ),
      body: Container(
        child: Text("Manager"),
      ),
    );
  }
}
