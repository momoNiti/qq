import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qq/bloc/authentication/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qq/cubit/queue/queue_cubit.dart';
import 'package:qq/models/queue_transaction.dart';
import 'package:qq/net/queue_repository.dart';
import 'package:qq/utility/utility.dart';
import 'package:qq/views/hoc/app_scaffold.dart';

class UserQueueTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final QueueCubit _counterBloc = BlocProvider.of<QueueCubit>(context);
    final QueueRepository queueRepository = QueueRepository();
    return AppScaffold(
      appBar: AppBar(
        title: Text("ํYour Queue"),
      ),
      body: Center(
        child: Column(
          children: [
            BlocBuilder(
              bloc: context.read<AuthenticationBloc>(),
              builder: (context, AuthenticationState state) {
                return state.status == AuthenticationStatus.authenticated
                    ? Text(context.select((AuthenticationBloc bloc) =>
                        "Login as Mr.${bloc.state.user.name} and role is ${Utility.enumToString(bloc.state.user.role)}"))
                    : SizedBox.shrink();
              },
            ),
            Expanded(
              child: StreamBuilder<List<QueueTransaction>>(
                  stream: queueRepository.fetchQueueOfUser(
                      context.read<AuthenticationBloc>().state.user.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: queueStatusColor[
                                  Utility.enumFromString<QueueStatus>(
                                      snapshot.data.elementAt(index).status,
                                      QueueStatus.values)],
                              margin: EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Text(
                                      "Queue ID : ${snapshot.data.elementAt(index).id}"),
                                  FutureBuilder<DocumentSnapshot>(
                                      future: snapshot.data
                                          .elementAt(index)
                                          .resId
                                          .get(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData &&
                                            snapshot.data != null) {
                                          return Text(
                                              "ร้าน : ${snapshot.data.get('name')}");
                                        } else if (snapshot.hasError) {
                                          return Text("Error Occured");
                                        } else {
                                          return CircularProgressIndicator();
                                        }
                                      }),
                                  Text(
                                      "เวลาที่จอง ${snapshot.data.elementAt(index).timestamp.toDate().toString()}"),
                                  Text("เวลาโดยประมาณ ===="),
                                  Text(
                                      "จำนวนคิวก่อนหน้า ${snapshot.data.elementAt(index).queueNumber - 1}"),
                                  Text(
                                      "สถานะ : ${snapshot.data.elementAt(index).status}")
                                ],
                              ),
                            );
                          });
                    } else if (snapshot.hasError)
                      return Text("Error Occured");
                    else
                      return CircularProgressIndicator();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
