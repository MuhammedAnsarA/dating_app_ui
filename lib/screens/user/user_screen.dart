import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';

class UsersScreen extends StatelessWidget {
  static const String routeName = '/users';

  static Route route({required User user}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => UsersScreen(user: user),
    );
  }

  final User user;

  const UsersScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.9,
            child: Stack(
              children: [
                Hero(
                  tag: 'user_card',
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 45.0),
                    child: UserImage.medium(
                      url: user.imageUrls[0],
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: double.infinity,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 60,
                    ),
                    child: BlocBuilder<SwipeBloc, SwipeState>(
                      builder: (context, state) {
                        if (state is SwipeLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is SwipeLoaded) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  context
                                      .read<SwipeBloc>()
                                      .add(SwipeRight(user: state.users[0]));
                                  Navigator.pop(context);
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
                                  Navigator.pop(context);
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
                          );
                        } else {
                          return const Text('Something went wrong.');
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.name}, ${user.age}',
                  style: const TextStyle(
                    color: Color(0xFF2B2E4A),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Text(
                  user.jobTitle,
                  style: const TextStyle(
                    color: Color(0xFF2B2E4A),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'About',
                  style: TextStyle(
                    color: Color(0xFF2B2E4A),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  user.bio,
                  style: const TextStyle(
                      color: Color(0xFF2B2E4A),
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      height: 2),
                ),
                const SizedBox(height: 15),
                const Text('Interests',
                    style: TextStyle(
                      color: Color(0xFF2B2E4A),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    )),
                Row(
                  children: user.interests
                      .map((interest) => Container(
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.only(top: 5.0, right: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.black,
                                  Colors.red,
                                ],
                              ),
                            ),
                            child: Text(
                              interest,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
