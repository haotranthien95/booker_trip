import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ecom_project/core/flutter_bloc/bloc/getUserTripBloc.dart';
import 'package:new_ecom_project/core/flutter_bloc/state/GetUserTripState.dart';
import 'package:new_ecom_project/ui/modules/userPage/userTrip/userTripCard.dart';

class UserTripList extends StatefulWidget {
  const UserTripList({Key? key, required this.hostName}) : super(key: key);

  final String hostName;

  @override
  _UserTripListState createState() => _UserTripListState();
}

class _UserTripListState extends State<UserTripList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserTripBloc, GetUserTripState>(
      builder: (context, state) {
        if (state is GetUserTripSuccess) {
          if (state.tripList.length > 0) {
            return SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
              if (index == state.tripList.length && !state.hasReachedEnd) {
                return Container(
                  alignment: Alignment.center,
                  child: Center(
                    child: SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                      ),
                    ),
                  ),
                );
              }
              if ((state.tripList.length % 5 > 0 || state.hasReachedEnd) &&
                  index == state.tripList.length) {
                return Container(
                  padding: EdgeInsets.all(20),
                  height: 60,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Bạn đã ở cuối trang",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }
              return UserTripCard(state.tripList[index], widget.hostName);
            },
                    childCount: (state.tripList.length == 0)
                        ? state.tripList.length
                        : state.tripList.length + 1));
          } else
            return SliverToBoxAdapter(
                child: SizedBox(
              height: 600,
            ));
        } else if (state is GetUserTripInitial || state is GetUserTripLoading) {
          return SliverToBoxAdapter(
            child: Container(
              height: 500,
              alignment: Alignment.topCenter,
              child: Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                  ),
                ),
              ),
            ),
          );
        } else if (state is GetUserTripError) {
          return SliverToBoxAdapter(
            child: Container(height: 500, child: Text(state.error.toString())),
          );
        }
        return SizedBox();
      },
    );
  }
}
