import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = '/chat';

  static Route route({required UserMatch userMatch}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => ChatScreen(userMatch: userMatch),
    );
  }

  final UserMatch userMatch;

  const ChatScreen({super.key, required this.userMatch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        title: Column(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(userMatch.matchedUser.imageUrls[0]),
            ),
            Text(
              userMatch.matchedUser.name,
              style: const TextStyle(
                color: Color(0xFF2B2E4A),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: userMatch.chat != null
                  ? Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: userMatch.chat![0].messages.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: userMatch
                                          .chat![0].messages[index].senderId ==
                                      1
                                  ? Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8.0),
                                            ),
                                            color: Colors.black),
                                        child: Text(
                                          userMatch
                                              .chat![0].messages[index].message,
                                          style: const TextStyle(
                                            color: Color(0xFF2B2E4A),
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Align(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundImage: NetworkImage(
                                                userMatch
                                                    .matchedUser.imageUrls[0]),
                                          ),
                                          const SizedBox(width: 10),
                                          Container(
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8.0),
                                              ),
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            child: Text(
                                              userMatch.chat![0].messages[index]
                                                  .message,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            );
                          }),
                    )
                  : const SizedBox(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            height: 100,
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    RepositoryProvider.of<AuthRepository>(context).signOut();
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
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send_outlined),
                    onPressed: () {},
                    color: Colors.white,
                  ),
                ),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Type here...',
                      contentPadding:
                          EdgeInsets.only(left: 20, bottom: 5, top: 5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
