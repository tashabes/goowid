import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.iconData,
      required this.onTap})
      : super(key: key);
  final String title;
  final String subtitle;
  final IconData iconData;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            iconData,
            size: 36.0,
            color: Colors.red,
          ),
          const SizedBox(width: 12.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                subtitle,
              ),
            ],
          )
        ],
      ),
    );
  }
}
