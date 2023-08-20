import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasActions;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.hasActions = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.popAndPushNamed(context, '/');
              },
              child: Container(
                child: Image.asset(
                  'assets/images/icon_app.png',
                  height: 50,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
      actions: hasActions
          ? [
              IconButton(
                  icon: Icon(Icons.message,
                      color: Theme.of(context).primaryColor),
                  onPressed: () {
                    Navigator.pushNamed(context, '/matches');
                  }),
              IconButton(
                  icon:
                      Icon(Icons.person, color: Theme.of(context).primaryColor),
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile');
                  })
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
