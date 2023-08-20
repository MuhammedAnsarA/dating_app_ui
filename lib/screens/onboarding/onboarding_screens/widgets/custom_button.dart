import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/blocs.dart';
import '../../../../cubits/cubits.dart';
import '../../../../models/models.dart';

class CustomButton extends StatelessWidget {
  final TabController tabController;
  final String text;
  final void function;

  const CustomButton({
    Key? key,
    required this.tabController,
    required this.text,
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: const LinearGradient(
          colors: [
            Colors.red,
            Colors.black,
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: () async {
          if (tabController.index == 5) {
            Navigator.pushNamed(context, '/');
          } else {
            tabController.animateTo(tabController.index + 1);
          }

          if (tabController.index == 2) {
            await context.read<SignupCubit>().signUpWithCredentials();

            User user = User(
              // ignore: use_build_context_synchronously
              id: context.read<SignupCubit>().state.user!.uid,
              name: '',
              age: 0,
              gender: '',
              imageUrls: [],
              jobTitle: '',
              interests: [],
              bio: '',
              location: '',
            );
            // ignore: use_build_context_synchronously
            context.read<OnboardingBloc>().add(
                  StartOnboarding(
                    user: user,
                  ),
                );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        child: Container(
          width: double.infinity,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
