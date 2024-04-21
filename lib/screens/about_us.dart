import 'package:flutter/material.dart';
import 'package:sayuga_jewels/Widgets/footer.dart';
import 'package:sayuga_jewels/constants/insets.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width > 600
        ? Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 20,
                    child: Column(
                      children: [
                        Text(
                          "About Us",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: width > 600
                                      ? const EdgeInsets.only(right: 30.0)
                                      : const EdgeInsets.only(right: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Our Story: Pioneering Excellence in Jewelry",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Sayuga Jewels is renowned as the pioneering Indian jeweler to establish manufacturing and wholesale operations in the United States of America. Our commitment to excellence, coupled with traditional Indian craftsmanship and contemporary designs, has solidified our position as a leader in the jewelry industry. With a rich heritage and a dedication to quality, Sayuga Jewels continues to set the standard for exquisite jewelry both in the U.S. and beyond.",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(Insets.large)),
                                  child: Image.asset(
                                      "assets/images/about-us-1.webp"),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(Insets.large)),
                                  child: Image.asset(
                                      "assets/images/about-us-2.webp"),
                                )),
                            Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: width > 600
                                      ? const EdgeInsets.only(left: 30.0)
                                      : const EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "A Universe of Designs, Crafted for You",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "At Sayuga Jewels, we believe jewelry shouldn't be limited. That's why we offer a dazzling spectrum of designs, from intricate heirlooms steeped in tradition to the boldest, most contemporary pieces that push the boundaries of style. Whether you crave classic elegance or a statement-making masterpiece, our collections cater to every taste and occasion. We're constantly on the pulse of emerging trends, ensuring you'll always find fresh and captivating designs to add to your story.",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              borderRadius:
                                  BorderRadius.circular(Insets.large)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  "Be the First to Shine: Pre-Order Your Dream Jewelry",
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Pre-ordering at Sayuga Jewels unlocks a treasure trove of benefits for you, the discerning jewelry lover. Secure the hottest designs before they hit the mainstream, and enjoy exclusive pricing and discounts reserved for early birds. Not only do you get the best price on your coveted piece, but you also play a vital role in shaping our future collections! Your pre-order provides valuable insights, allowing us to tailor production and bring your jewelry dreams to life.",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              const Footer()
            ],
          )
        : Column(
            children: [
              Row(
                children: [
                  const Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                    flex: 20,
                    child: Column(
                      children: [
                        Text(
                          "About Us",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Our Story: Pioneering Excellence in Jewelry",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(Insets.large)),
                                  child: Image.asset(
                                      "assets/images/about-us-1.webp"),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Sayuga Jewels is renowned as the pioneering Indian jeweler to establish manufacturing and wholesale operations in the United States of America. Our commitment to excellence, coupled with traditional Indian craftsmanship and contemporary designs, has solidified our position as a leader in the jewelry industry. With a rich heritage and a dedication to quality, Sayuga Jewels continues to set the standard for exquisite jewelry both in the U.S. and beyond.",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(Insets.large)),
                                  child: Image.asset(
                                      "assets/images/about-us-2.webp"),
                                )),
                            Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "A Universe of Designs, Crafted for You",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "At Sayuga Jewels, we believe jewelry shouldn't be limited. That's why we offer a dazzling spectrum of designs, from intricate heirlooms steeped in tradition to the boldest, most contemporary pieces that push the boundaries of style. Whether you crave classic elegance or a statement-making masterpiece, our collections cater to every taste and occasion. We're constantly on the pulse of emerging trends, ensuring you'll always find fresh and captivating designs to add to your story.",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              borderRadius:
                                  BorderRadius.circular(Insets.large)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  "Be the First to Shine: Pre-Order Your Dream Jewelry",
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Pre-ordering at Sayuga Jewels unlocks a treasure trove of benefits for you, the discerning jewelry lover. Secure the hottest designs before they hit the mainstream, and enjoy exclusive pricing and discounts reserved for early birds. Not only do you get the best price on your coveted piece, but you also play a vital role in shaping our future collections! Your pre-order provides valuable insights, allowing us to tailor production and bring your jewelry dreams to life.",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(flex: 1, child: SizedBox()),
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              const Footer()
            ],
          );
  }
}
