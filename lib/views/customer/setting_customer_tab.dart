import 'package:qq/bloc/counter/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qq/views/hoc/app_scaffold.dart';

class SettingCustomerTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);
    return AppScaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
      body: Center(
        child: Column(
          children: [
            BlocBuilder(
              cubit: counterBloc,
              builder: (BuildContext context, CounterState state) {
                return Text("Setting Page ${state.counter}");
              },
            ),
            RaisedButton(
              onPressed: () => {counterBloc.add(IncrementEvent())},
              child: Icon(Icons.plus_one),
            ),
            RaisedButton(
              onPressed: () => {counterBloc.add(DecrementEvent())},
              child: Icon(Icons.exposure_minus_1),
            ),
          ],
        ),
      ),
    );
  }
}
