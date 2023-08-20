import 'package:finate/screens/onboarding/onboarding_screens/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Start extends StatelessWidget {
  final TabController tabController;

  const Start({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                height: 200,
                width: 200,
                child: Image.asset(
                  'assets/images/cute_chat.png',
                ),
              ),
              const SizedBox(height: 50),
              const Text(
                'Welcome to Arrow',
                style: TextStyle(
                  color: Color(0xFF2B2E4A),
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.',
                style: TextStyle(
                    color: Color(0xFF2B2E4A),
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    height: 1.8),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          CustomButton(tabController: tabController, text: 'START')
        ],
      ),
    );
  }
}
