import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/blocs/blocs.dart';
import '/repositories/repositories.dart';
import '/screens/screens.dart';
import '/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';

  const ProfileScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) {
          print(BlocProvider.of<AuthBloc>(context).state);

          return BlocProvider.of<AuthBloc>(context).state.status ==
                  AuthStatus.unauthenticated
              ? const OnboardingScreen()
              : const ProfileScreen();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'PROFILE',
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProfileLoaded) {
              return Column(
                children: [
                  const SizedBox(height: 10),
                  UserImage.medium(
                    url: state.user.imageUrls[0],
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor.withOpacity(0.1),
                            Theme.of(context).primaryColor.withOpacity(0.9),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 40.0),
                          child: Text(
                            state.user.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 36,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TitleWithIcon(
                            title: 'Biography', icon: Icons.edit),
                        Text(
                          state.user.bio,
                          style: const TextStyle(
                              color: Color(0xFF2B2E4A),
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              height: 1.5),
                        ),
                        const TitleWithIcon(
                            title: 'Pictures', icon: Icons.edit),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          height: state.user.imageUrls.length > 0 ? 125 : 0,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: state.user.imageUrls.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: UserImage.small(
                                  width: 100,
                                  url: state.user.imageUrls[index],
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const TitleWithIcon(
                            title: 'Location', icon: Icons.edit),
                        Text(
                          state.user.location,
                          style: const TextStyle(
                              color: Color(0xFF2B2E4A),
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              height: 1.5),
                        ),
                        const TitleWithIcon(
                            title: 'Interest', icon: Icons.edit),
                        // Row(
                        //   children: [
                        //     CustomTextContainer(text: 'MUSIC'),
                        //     CustomTextContainer(text: 'ECONOMICS'),
                        //     CustomTextContainer(text: 'FOOTBALL'),
                        //   ],
                        // ),
                        TextButton(
                          onPressed: () {
                            RepositoryProvider.of<AuthRepository>(context)
                                .signOut();
                          },
                          child: const Center(
                            child: Text(
                              'Sign Out',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const Text('Something went wrong.');
            }
          },
        ),
      ),
    );
  }
}

class TitleWithIcon extends StatelessWidget {
  final String title;
  final IconData icon;

  const TitleWithIcon({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF2B2E4A),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        IconButton(
          icon: Icon(icon),
          onPressed: () {},
        ),
      ],
    );
  }
}
