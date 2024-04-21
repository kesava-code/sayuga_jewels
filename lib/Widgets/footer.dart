import 'package:flutter/material.dart';
import 'package:sayuga_jewels/utils/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        children: [
          const Expanded(flex: 1, child: SizedBox()),
          Expanded(
            flex: 16,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Need help finding the perfect piece? Our jewelry experts are here!",
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Let Us Know.",
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  ),
                  Row(
                    children: [
                      SelectableText(
                        "info@sayuga.com",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SelectableText(
                        "+1 (469) 629-6139",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Follow Us on ",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      IconButton(
                          onPressed: () {
                            Uri url = Uri.parse(
                                "https://www.instagram.com/sayugajewel/");
                            launchWeb(url);
                          },
                          icon: Image.asset(
                            "assets/images/instagram.png",
                            width: 20,
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
          const Expanded(flex: 1, child: SizedBox()),
        ],
      ),
    );
  }
}
