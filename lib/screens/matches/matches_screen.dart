import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../widgets/widgets.dart';

class MatchesScreen extends StatelessWidget {
  static const String routeName = '/matches';

  const MatchesScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const MatchesScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final inactiveMatches = UserMatch.matches
        .where((match) => match.userId == 1 && match.chat!.isEmpty)
        .toList();
    final activeMatches = UserMatch.matches
        .where((match) => match.userId == 1 && match.chat!.isNotEmpty)
        .toList();

    return Scaffold(
      appBar: const CustomAppBar(title: 'MATCHES'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Likes',
                style: TextStyle(
                  color: Color(0xFF2B2E4A),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: inactiveMatches.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          UserImage.small(
                            margin: const EdgeInsets.only(top: 10, right: 10),
                            height: 70,
                            width: 70,
                            url:
                                inactiveMatches[index].matchedUser.imageUrls[0],
                          ),
                          Text(
                            inactiveMatches[index].matchedUser.name,
                            style: const TextStyle(
                              color: Color(0xFF2B2E4A),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              const SizedBox(height: 10),
              const Text(
                'Your Chats',
                style: TextStyle(
                  color: Color(0xFF2B2E4A),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: activeMatches.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/chat',
                            arguments: activeMatches[index]);
                      },
                      child: Row(
                        children: [
                          UserImage.small(
                            margin: const EdgeInsets.only(top: 10, right: 10),
                            height: 70,
                            width: 70,
                            url: activeMatches[index].matchedUser.imageUrls[0],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                activeMatches[index].matchedUser.name,
                                style: const TextStyle(
                                  color: Color(0xFF2B2E4A),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                activeMatches[index]
                                    .chat![0]
                                    .messages[0]
                                    .message,
                                style: const TextStyle(
                                  color: Color(0xFF2B2E4A),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                activeMatches[index]
                                    .chat![0]
                                    .messages[0]
                                    .timeString,
                                style: const TextStyle(
                                  color: Color(0xFF2B2E4A),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
