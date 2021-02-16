import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qq/bloc/authentication/authentication_bloc.dart';
import 'package:qq/cubit/queue/queue_cubit.dart';
import 'package:qq/models/queue_transaction.dart';
import 'package:qq/models/restaurant.dart';
import 'package:qq/net/queue_repository.dart';
import 'package:qq/views/hoc/app_scaffold.dart';
import 'package:provider/provider.dart';

class RestaurantScreen extends StatelessWidget {
  final Restaurant restaurant;
  final QueueRepository _queueRepository = QueueRepository();
  RestaurantScreen({Key key, this.restaurant})
      : assert(restaurant != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: StreamBuilder<List<QueueTransaction>>(
          stream: _queueRepository.fetchQueuesInRestaurant(restaurant.id),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Text(
                              "${index + 1} ${snapshot.data.elementAt(index).userId.id}");
                        }),
                  ),
                  BlocConsumer<QueueCubit, QueueState>(
                      cubit: BlocProvider.of<QueueCubit>(context),
                      listener: (context, state) {
                        if (state.status == QueueEventStatus.failure) {
                          Scaffold.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content:
                                    Text("Add Queue Fail : ${state.error}"),
                              ),
                            );
                        }
                      },
                      buildWhen: (previous, current) =>
                          previous.status != current.status,
                      builder: (context, state) {
                        return RaisedButton(
                          onPressed: () {
                            if (state.status == QueueEventStatus.inprogress) {
                              return null;
                            } else {
                              context.read<QueueCubit>().addQueue(
                                  resId: restaurant.id,
                                  userId: context
                                      .read<AuthenticationBloc>()
                                      .state
                                      .user
                                      .id);
                            }
                          },
                          child: state.status == QueueEventStatus.inprogress
                              ? CircularProgressIndicator()
                              : Text("Add Queue"),
                        );
                      }),
                ],
              );
            } else if (snapshot.hasError)
              return Text("Error ${snapshot.error}");
            else
              return CircularProgressIndicator();
          }),
    );
  }
}
