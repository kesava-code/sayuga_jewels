import 'package:flutter/material.dart';

class SectionDivider extends StatelessWidget {
  const SectionDivider({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const SizedBox(height: 70),
        Row(
          children: [
            const Expanded(
                child: Divider(
              endIndent: 80,
            )),
            Text(
              title,
              style: width > 600
                  ? Theme.of(context).textTheme.headlineLarge
                  : Theme.of(context).textTheme.headlineSmall,
              softWrap: true,
            ),
            const Expanded(
                child: Divider(
              indent: 80,
            ))
          ],
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
