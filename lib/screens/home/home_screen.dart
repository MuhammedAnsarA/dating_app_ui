import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens.dart';
import '/blocs/blocs.dart';
import '/models/models.dart';
import '/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  const HomeScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) {
          print(BlocProvider.of<AuthBloc>(context).state.status);
          return BlocProvider.of<AuthBloc>(context).state.status ==
                  AuthStatus.unauthenticated
              ? OnboardingScreen()
              : const HomeScreen();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'DISCOVER'),
      body: BlocBuilder<SwipeBloc, SwipeState>(
        builder: (context, state) {
          if (state is SwipeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SwipeLoaded) {
            var userCount = state.users.length;
            return Column(
              children: [
                InkWell(
                  onDoubleTap: () {
                    Navigator.pushNamed(context, '/users',
                        arguments: state.users[0]);
                  },
                  child: Draggable<User>(
                    data: state.users[0],
                    feedback: UserCard(user: state.users[0]),
                    childWhenDragging: (userCount > 1)
                        ? UserCard(user: state.users[1])
                        : Container(),
                    onDragEnd: (drag) {
                      if (drag.velocity.pixelsPerSecond.dx < 0) {
                        context
                            .read<SwipeBloc>()
                            .add(SwipeLeft(user: state.users[0]));
                        print('Swiped Left');
                      } else {
                        context
                            .read<SwipeBloc>()
                            .add(SwipeRight(user: state.users[0]));
                        print('Swiped Right');
                      }
                    },
                    child: UserCard(user: state.users[0]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 60,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          context
                              .read<SwipeBloc>()
                              .add(SwipeRight(user: state.users[0]));
                          print('Swiped Right');
                        },
                        child: const ChoiceButton(
                          color: Colors.red,
                          icon: Icons.clear_rounded,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context
                              .read<SwipeBloc>()
                              .add(SwipeRight(user: state.users[0]));
                          print('Swiped Left');
                        },
                        child: const ChoiceButton(
                          width: 80,
                          height: 80,
                          size: 30,
                          color: Colors.white,
                          hasGradient: true,
                          icon: Icons.favorite,
                        ),
                      ),
                      ChoiceButton(
                        color: Theme.of(context).primaryColor,
                        icon: Icons.watch_later,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          if (state is SwipeError) {
            return const Center(
              child: Text(
                'There arent any more users.',
                style: TextStyle(
                  color: Color(0xFF2B2E4A),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            );
          } else {
            return const Text('Something went wrong.');
          }
        },
      ),
    );
  }
}
