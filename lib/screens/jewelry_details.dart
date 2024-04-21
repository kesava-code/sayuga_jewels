import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sayuga_jewels/Widgets/footer.dart';
import 'package:sayuga_jewels/Widgets/grid_section_product_details.dart';
import 'package:sayuga_jewels/constants/insets.dart';
import 'package:sayuga_jewels/constants/location_url.dart';
import 'package:sayuga_jewels/logic/cubit/jewelry_details_cubit.dart';
import 'package:sayuga_jewels/screens/interactive_viewer.dart';
import 'package:sayuga_jewels/utils/extensions.dart';
import 'package:sayuga_jewels/utils/screen_type.dart';
import 'package:sayuga_jewels/utils/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class JewelryDetails extends StatefulWidget {
  const JewelryDetails({super.key, required this.id});
  final String id;

  @override
  State<JewelryDetails> createState() => _JewelryDetailsState();
}

class _JewelryDetailsState extends State<JewelryDetails> {
  final int flex = 14;
  late final ScrollController imageScrollController;

  @override
  void initState() {
    imageScrollController = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    imageScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenType screenType = FormFactor().getFormFactor(context);
    double corouselHeight = screenType == ScreenType.desktop
        ? 400
        : screenType == ScreenType.tablet
            ? 300
            : 200;
    return BlocProvider(
      lazy: false,
      create: (context) => JewelryDetailsCubit(id: int.parse(widget.id)),
      child: BlocBuilder<JewelryDetailsCubit, JewelryDetailsState>(
        builder: (context, state) {
          if (state is JewelryDetailsInitial) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 100,
              child: const Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CupertinoActivityIndicator(),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Loading")
                  ],
                ),
              ),
            );
          }
          if (state is JewelryDetailsNotFound) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 100,
              child: const Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Oops! The content you are looking for is not found.")
                  ],
                ),
              ),
            );
          }
          if (state is JewelryDetailsLoaded) {
            final List<Widget> gridList = [];
            if (state.jewelry.ocassionList.isNotEmpty) {
              gridList.add(ProductDetailsGridSection(
                  title: "Ocassion", details: state.jewelry.ocassionList));
            }
            if (state.jewelry.materialList.isNotEmpty) {
              gridList.add(ProductDetailsGridSection(
                  title: "Material", details: state.jewelry.materialList));
            }
            if (state.jewelry.stoneList.isNotEmpty) {
              gridList.add(ProductDetailsGridSection(
                  title: "Stone", details: state.jewelry.stoneList));
            }
            if (state.jewelry.genderList.isNotEmpty) {
              gridList.add(ProductDetailsGridSection(
                  title: "Gender", details: state.jewelry.genderList));
            }
            return Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: flex,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Product code - ${state.jewelry.id.toString()}",
                                softWrap: true,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const Expanded(child: SizedBox()),
                              TextButton.icon(
                                onPressed: () {
                                  Share.share(
                                      LocationUrl.scheme +
                                          LocationUrl.domain +
                                          GoRouter.of(context)
                                              .routerDelegate
                                              .currentConfiguration
                                              .uri
                                              .toString(),
                                      subject: state.jewelry.title);
                                },
                                icon: const Icon(Icons.share_rounded),
                                label: const Text("Share"),
                                style: TextButton.styleFrom(
                                  foregroundColor: Theme.of(context)
                                      .colorScheme
                                      .onSecondaryContainer,
                                  // Adjust text color as desired
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer, // Tonal color
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Stack(children: [
                            SizedBox(
                              height: corouselHeight,
                              child: Scrollbar(
                                controller: imageScrollController,
                                interactive: true,
                                child: ListView(
                                    controller: imageScrollController,
                                    scrollDirection: Axis.horizontal,
                                    children: List.generate(
                                        state.jewelry.imageList.length,
                                        (index) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: Insets.large,
                                                      horizontal:
                                                          Insets.xsmall),
                                              child: AspectRatio(
                                                aspectRatio: 3 / 4,
                                                child: MouseRegion(
                                                  cursor:
                                                      MaterialStateMouseCursor
                                                          .clickable,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .push(
                                                              MaterialPageRoute(
                                                                  builder: (_) {
                                                        return BlocProvider.value(
                                                            value: BlocProvider
                                                                .of<JewelryDetailsCubit>(
                                                                    context),
                                                            child:
                                                                ImageInteractiveViewer(
                                                                    currentImage:
                                                                        index));
                                                      }));
                                                      // GoRouter.of(context).push(
                                                      //     '/image-view?currentIndex=$index',
                                                      //     extra: BlocProvider
                                                      //         .of<JewelryDetailsCubit>(
                                                      //             context));
                                                    },
                                                    child: Container(
                                                      clipBehavior:
                                                          Clip.hardEdge,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(Insets
                                                                      .large)),
                                                      child: Hero(
                                                        tag: index,
                                                        child: Image(
                                                          image: state.jewelry
                                                              .imageList[index],
                                                          fit: BoxFit.cover,
                                                          errorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                            return const SizedBox(
                                                              child: Center(
                                                                  child: Icon(Icons
                                                                      .error)),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ))),
                              ),
                            ),
                            Positioned(
                                left: 10,
                                top: corouselHeight / 2 - 15,
                                child: IconButton(
                                    style: IconButton.styleFrom(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .surfaceVariant
                                            .withAlpha(180)),
                                    iconSize: corouselHeight / 10,
                                    onPressed: () {
                                      double offset =
                                          imageScrollController.offset;
                                      if (offset < 900) {
                                        imageScrollController.animateTo(0,
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.easeIn);
                                      } else {
                                        imageScrollController.animateTo(
                                            offset - 900,
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.easeIn);
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                    ))),
                            Positioned(
                                right: 10,
                                top: corouselHeight / 2 - 15,
                                child: IconButton(
                                  style: IconButton.styleFrom(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .surfaceVariant
                                          .withAlpha(180)),
                                  iconSize: corouselHeight / 10,
                                  onPressed: () {
                                    double offset =
                                        imageScrollController.offset;
                                    double limit = imageScrollController
                                        .position.maxScrollExtent;
                                    if (limit - offset < 900) {
                                      imageScrollController.animateTo(limit,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeIn);
                                    } else {
                                      imageScrollController.animateTo(
                                          offset + 900,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeIn);
                                    }
                                  },
                                  icon: const Icon(
                                      Icons.arrow_forward_ios_rounded),
                                )),
                          ]),
                          const SizedBox(height: Insets.extraLarge),
                          Text(
                            state.jewelry.title.toUpperCase(),
                            softWrap: true,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          state.jewelry.price != ""
                              ? Row(
                                  children: [
                                    Text(
                                      "From",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "\$${state.jewelry.price}",
                                      softWrap: true,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              : const Text(""),
                          const SizedBox(
                            height: Insets.large,
                          ),
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer),
                              onPressed: () {
                                String message =
                                    "Would like to order - ${LocationUrl.scheme}${LocationUrl.domain}${GoRouter.of(context).routerDelegate.currentConfiguration.uri}";

                                Uri url = Uri.parse(
                                    "https://wa.me/919441719386?text=${Uri.encodeQueryComponent(message)}");
                                launchWeb(url);
                              },
                              child: const Text("Order now")),
                          const SizedBox(
                            height: Insets.small,
                          ),
                          const Row(
                            children: [
                              Icon(Icons.diamond_sharp),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Purity Guaranteed")
                            ],
                          ),
                          const Row(
                            children: [
                              Icon(Icons.filter_vintage_sharp),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Customizable")
                            ],
                          ),
                          const SizedBox(
                            height: Insets.extraLarge,
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
                ColoredBox(
                  color: Theme.of(context)
                      .colorScheme
                      .secondaryContainer
                      .withAlpha(50),
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: flex,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: Insets.large,
                            ),
                            Text(
                              "Product Details",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: Insets.small),
                            Text(
                              state.jewelry.description.capitalizeSentence(),
                              softWrap: true,
                            ),
                            const SizedBox(height: Insets.medium),
                            const Text(
                              'Category',
                            ),
                            Text(
                              state.jewelry.category == ""
                                  ? "--"
                                  : state.jewelry.category,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: Insets.medium),
                            const Text(
                              'Sub-Category',
                            ),
                            Text(
                              state.jewelry.subCategory == ""
                                  ? "--"
                                  : state.jewelry.subCategory,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: Insets.medium),
                            const Text(
                              'Primary Color',
                            ),
                            Text(
                              state.jewelry.primaryColor == ""
                                  ? "--"
                                  : state.jewelry.primaryColor,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: Insets.medium),
                            const Text(
                              'Secondary Color',
                            ),
                            Text(
                              state.jewelry.secondaryColor == ""
                                  ? "--"
                                  : state.jewelry.secondaryColor,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: Insets.medium),
                            Wrap(
                              children: gridList,
                            )
                          ],
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: flex,
                      child: SizedBox(
                        height: 400,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Your Choice, Your Price: Personalized Jewelry for Every Budget",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              OutlinedButton.icon(
                                  onPressed: () {
                                    String message =
                                        "Need Quotation for  this product with customization and constraints -  ${LocationUrl.scheme}${LocationUrl.domain}${GoRouter.of(context).routerDelegate.currentConfiguration.uri}";

                                    Uri url = Uri.parse(
                                        "https://wa.me/14696296139?text=${Uri.encodeQueryComponent(message)}");
                                    launchWeb(url);
                                  },
                                  icon: const Icon(
                                    Icons.request_quote_rounded,
                                  ),
                                  label: const Text(
                                    "Get a Quote",
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    )
                  ],
                ),
                ColoredBox(
                  color: Theme.of(context)
                      .colorScheme
                      .secondaryContainer
                      .withAlpha(50),
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: flex,
                        child: SizedBox(
                          height: 400,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Still Confused What to Buy?",
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    String message =
                                        "Subject: jewelry buying advice.";

                                    Uri url = Uri.parse(
                                        "https://wa.me/13212306506?text=${Uri.encodeQueryComponent(message)}");
                                    launchWeb(url);
                                  },
                                  child: const Text("Talk to an Expert"),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(),
                      )
                    ],
                  ),
                ),
                const Footer()
              ],
            );
          }
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 100,
            child: const Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error),
                  SizedBox(
                    width: 10,
                  ),
                  Text("An error occured while processing your request!")
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
