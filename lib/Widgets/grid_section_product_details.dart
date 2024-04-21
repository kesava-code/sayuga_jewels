import 'package:flutter/material.dart';

class ProductDetailsGridSection extends StatelessWidget {
  const ProductDetailsGridSection(
      {super.key, required this.title, required this.details});
  final String title;
  final List<String> details;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const Expanded(
              child: Divider(
                indent: 10,
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
            children: List.generate(
                details.length,
                (index) => Chip(
                      label: Text(details[index]),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.primary),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    )),
          ),
        )
      ],
    );
  }
}
