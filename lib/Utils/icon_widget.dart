//import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class IconWidget extends StatelessWidget {
  final IconData icon;
  final Color color;

  const IconWidget({
    Key? key,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Icon(icon, color: Colors.white),
      );
}
/*
class NeumorphicIcon2 extends StatelessWidget {
  final IconData icon;
  final Color color;

  const NeumorphicIcon2({
    Key? key,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: NeumorphicIcon(
          icon,
          size: 25,
          style: const NeumorphicStyle(
              border: NeumorphicBorder(
            color: Color.fromARGB(51, 255, 255, 255),
            width: 0.5,
          )),
        ),
      );
}
*/