import 'package:flutter/material.dart';

class SectionDivider extends StatelessWidget {
  const SectionDivider({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const SizedBox(height: 50),
        Row(
          children: [
            Expanded(
                child: Divider(
              endIndent: width > 600 ? 80 : 20,
            )),
            Text(
              title,
              style: width > 600
                  ? Theme.of(context).textTheme.headlineLarge
                  : Theme.of(context).textTheme.headlineSmall,
              softWrap: true,
            ),
            Expanded(
                child: Divider(
              indent: width > 600 ? 80 : 20,
            ))
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
