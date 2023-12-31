import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../../widgets/widgets.dart';
import '/blocs/blocs.dart';
import 'widgets/widgets.dart';

class Bio extends StatelessWidget {
  final TabController tabController;

  const Bio({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        if (state is OnboardingLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is OnboardingLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextHeader(text: 'Describe Yourself'),
                    CustomTextField(
                      hint: 'ENTER YOUR BIO',
                      onChanged: (value) {
                        context.read<OnboardingBloc>().add(
                              UpdateUser(
                                user: state.user.copyWith(bio: value),
                              ),
                            );
                      },
                    ),
                    const SizedBox(height: 100),
                    const CustomTextHeader(text: 'What Do You Like?'),
                    const Row(
                      children: [
                        CustomTextContainer(text: 'MUSIC'),
                        CustomTextContainer(text: 'ECONOMICS'),
                        CustomTextContainer(text: 'POLITICS'),
                        CustomTextContainer(text: 'ART'),
                      ],
                    ),
                    const Row(
                      children: [
                        CustomTextContainer(text: 'NATURE'),
                        CustomTextContainer(text: 'HIKING'),
                        CustomTextContainer(text: 'FOOTBALL'),
                        CustomTextContainer(text: 'MOVIES'),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    const StepProgressIndicator(
                      totalSteps: 6,
                      currentStep: 5,
                      selectedColor: Colors.grey,
                      unselectedColor: Colors.black,
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                        tabController: tabController, text: 'NEXT STEP'),
                  ],
                ),
              ],
            ),
          );
        } else {
          return const Text('Something went wrong.');
        }
      },
    );
  }
}
