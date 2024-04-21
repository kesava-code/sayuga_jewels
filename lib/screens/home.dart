import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:sayuga_jewels/Widgets/banner_section.dart';
import 'package:sayuga_jewels/Widgets/best_of_sayuga_section.dart';
import 'package:sayuga_jewels/Widgets/categories_section.dart';
import 'package:sayuga_jewels/Widgets/footer.dart';
import 'package:sayuga_jewels/Widgets/gender_section.dart';
import 'package:sayuga_jewels/Widgets/new_for_you_section.dart';
import 'package:sayuga_jewels/Widgets/section_divider.dart';
import 'package:sayuga_jewels/logic/cubit/banner_cubit.dart';
import 'package:sayuga_jewels/logic/cubit/best_of_sayuga_cubit.dart';
import 'package:sayuga_jewels/logic/cubit/categories_cubit.dart';
import 'package:sayuga_jewels/logic/cubit/new_for_you_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => BannerCubit(),
        ),
        BlocProvider(
          create: (context) => BestOfSayugaCubit(),
        ),
        BlocProvider(
          create: (context) => CategoriesCubit(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => NewForYouCubit(),
          lazy: false,
        ),
      ],
      child: Builder(builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 16,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 30,
                        child: ListView(
                          primary: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: OutlinedButton(
                                  onPressed: () {
                                    if (kIsWeb) {
                                      context.go("/s?material__id__in=1");
                                    } else {
                                      context.push("/s?material__id__in=1");
                                    }
                                  },
                                  child: const Text("Gold")),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: OutlinedButton(
                                  onPressed: () {
                                    if (kIsWeb) {
                                      context.go("/s?material__id__in=4");
                                    } else {
                                      context.push("/s?material__id__in=4");
                                    }
                                  },
                                  child: const Text("Platinum")),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: OutlinedButton(
                                  onPressed: () {
                                    if (kIsWeb) {
                                      context.go("/s?material__id__in=5");
                                    } else {
                                      context.push("/s?material__id__in=5");
                                    }
                                  },
                                  child: const Text("Diamond")),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: OutlinedButton(
                                  onPressed: () {
                                    if (kIsWeb) {
                                      context.go("/s?category__id__in=8");
                                    } else {
                                      context.push("/s?category__id__in=8");
                                    }
                                  },
                                  child: const Text("Earrings")),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: OutlinedButton(
                                  onPressed: () {
                                    if (kIsWeb) {
                                      context.go("/s?category__id__in=21");
                                    } else {
                                      context.push("/s?category__id__in=21");
                                    }
                                  },
                                  child: const Text("Pendants")),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: OutlinedButton(
                                  onPressed: () {
                                    if (kIsWeb) {
                                      context.go("/s?category__id__in=19");
                                    } else {
                                      context.push("/s?category__id__in=19");
                                    }
                                  },
                                  child: const Text("Bangles")),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: OutlinedButton(
                                  onPressed: () {
                                    if (kIsWeb) {
                                      context.go("/s?category__id__in=20");
                                    } else {
                                      context.push("/s?category__id__in=20");
                                    }
                                  },
                                  child: const Text("Bracelets")),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: OutlinedButton(
                                  onPressed: () {
                                    if (kIsWeb) {
                                      context.go("/s?category__id__in=17");
                                    } else {
                                      context.push("/s?category__id__in=17");
                                    }
                                  },
                                  child: const Text("Necklaces")),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: OutlinedButton(
                                  onPressed: () {
                                    if (kIsWeb) {
                                      context.go("/s?category__id__in=18");
                                    } else {
                                      context.push("/s?category__id__in=18");
                                    }
                                  },
                                  child: const Text("Nose Pins")),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: OutlinedButton(
                                  onPressed: () {
                                    if (kIsWeb) {
                                      context.go("/s?category__id__in=15");
                                    } else {
                                      context.push("/s?category__id__in=15");
                                    }
                                  },
                                  child: const Text("Rings")),
                            ),
                          ],
                        ),
                      ),
                      const BannerSection(),
                      const SectionDivider(title: "SHOP BY CATEGORY"),
                      const CategoriesSection(),
                      const SectionDivider(title: "BEST OF SAYUGA"),
                      const BestOfSayugaSection(),
                      const SectionDivider(title: "SHOP BY GENDER"),
                      const GenderSection(),
                      const SectionDivider(title: "NEW FOR YOU"),
                      const NewForYouSection(),
                      const SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                )
              ],
            ),
            if (kIsWeb) const Footer()
          ],
        );
      }),
    );
  }
}
