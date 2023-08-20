import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../../widgets/widgets.dart';
import '/blocs/blocs.dart';
import 'widgets/widgets.dart';

class Pictures extends StatelessWidget {
  final TabController tabController;

  const Pictures({
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
          var images = state.user.imageUrls;
          var imageCount = images.length;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextHeader(text: 'Add 2 or More Pictures'),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 350,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.66,
                        ),
                        itemCount: 6,
                        itemBuilder: (BuildContext context, int index) {
                          return (imageCount > index)
                              ? CustomImageContainer(imageUrl: images[index])
                              : const CustomImageContainer();
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const StepProgressIndicator(
                      totalSteps: 6,
                      currentStep: 4,
                      selectedColor: Colors.black,
                      unselectedColor: Colors.grey,
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
