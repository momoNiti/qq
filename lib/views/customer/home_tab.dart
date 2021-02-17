import 'package:qq/bloc/authentication/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qq/models/restaurant.dart';
import 'package:qq/net/restaurant_repository.dart';
import 'package:qq/router/route_path.dart';
import 'package:qq/utility/utility.dart';
import 'package:qq/views/hoc/app_scaffold.dart';

class HomeCustomerTab extends StatelessWidget {
  Widget build(BuildContext context) {
    final RestaurantRepository restaurantRepository = RestaurantRepository();

    return AppScaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: LayoutBuilder(
        builder: (context, constraint) {
          return Container(
            width: constraint.maxWidth,
            height: constraint.maxHeight,
            child: Column(
              children: [
                BlocBuilder(
                  cubit: context.read<AuthenticationBloc>(),
                  builder: (context, AuthenticationState state) {
                    return state.status == AuthenticationStatus.authenticated
                        ? Text(context.select((AuthenticationBloc bloc) =>
                            "Login as Mr.${bloc.state.user.name} and role is ${Utility.enumToString(bloc.state.user.role)}"))
                        : SizedBox.shrink();
                  },
                ),
                Expanded(
                  child: StreamBuilder<List<Restaurant>>(
                    stream: restaurantRepository.fetchRestaurants(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  RoutePath.customerRestaurantDetail,
                                  arguments: Restaurant(
                                      id: snapshot.data.elementAt(index).id,
                                      name: snapshot.data.elementAt(index).name,
                                      owner:
                                          snapshot.data.elementAt(index).owner,
                                      queued: snapshot.data
                                          .elementAt(index)
                                          .queued),
                                );
                              },
                              child: ListTile(
                                title:
                                    Text(snapshot.data.elementAt(index).name),
                                subtitle: Text(
                                    "จำนวนคิว : ${snapshot.data.elementAt(index).queued.toString()}"),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError)
                        return Text("Error ${snapshot.error}");
                      else
                        return CircularProgressIndicator();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
