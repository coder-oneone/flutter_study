import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function()? onTap;
  CustomIconButton({required this.icon, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Icon(
                icon,
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 12.0, height: 1.5),
            )
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
