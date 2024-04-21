import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sayuga_jewels/logic/cubit/banner_cubit.dart';
import 'package:sayuga_jewels/utils/screen_type.dart';

class BannerSection extends StatelessWidget {
  const BannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double aspectRatio = MediaQuery.of(context).size.aspectRatio;
    ScreenType screenType = FormFactor().getFormFactor(context);
    double borderRadius = screenType == ScreenType.desktop
        ? 80
        : screenType == ScreenType.tablet
            ? 50
            : 25;

    return BlocBuilder<BannerCubit, BannerState>(
      builder: (context, state) {
        switch (state.status) {
          case Status.initial:
            return ListView(shrinkWrap: true, children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40.0),
                child: ConstrainedBox(
                  constraints: aspectRatio > 16 / 9
                      ? BoxConstraints(maxHeight: height - 250)
                      : const BoxConstraints(),
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 16.0 / 9.0,
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(borderRadius)),
                        child: ColoredBox(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 20,
                      child: ColoredBox(
                          color: Theme.of(context).colorScheme.surfaceVariant),
                    ),
                  ),
                  const Expanded(flex: 3, child: SizedBox())
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 20,
                child: ColoredBox(
                    color: Theme.of(context).colorScheme.surfaceVariant),
              ),
            ]);
          case Status.failure:
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: (aspectRatio > 16 / 9) ? 40.0 : 20),
              child: ConstrainedBox(
                constraints: aspectRatio > 16 / 9
                    ? BoxConstraints(maxHeight: height - 250)
                    : const BoxConstraints(),
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 16.0 / 9.0,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(borderRadius)),
                      child: ColoredBox(
                        color: Theme.of(context).colorScheme.errorContainer,
                        child: Center(
                          child: Text(
                            "Oops! Something went wrong.",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onErrorContainer),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );

          case Status.success:
            return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: (aspectRatio > 16 / 9) ? 40.0 : 20),
                    child: ConstrainedBox(
                      constraints: aspectRatio > 16 / 9
                          ? BoxConstraints(maxHeight: height - 250)
                          : const BoxConstraints.tightForFinite(),
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: 16.0 / 9.0,
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                if (kIsWeb) {
                                  context.go(state.bannerData.url);
                                } else {
                                  context.push(state.bannerData.url);
                                }
                              },
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(borderRadius)),
                                child: Image.network(
                                  state.bannerData.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      state.bannerData.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(child: Text(state.bannerData.description)),
                ]);
        }
      },
    );
  }
}
