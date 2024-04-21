import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sayuga_jewels/Widgets/best_of_sayuga_loading_window.dart';
import 'package:sayuga_jewels/Widgets/best_of_sayuga_window.dart';
import 'package:sayuga_jewels/logic/cubit/best_of_sayuga_cubit.dart';
import 'package:sayuga_jewels/utils/screen_type.dart';

class BestOfSayugaSection extends StatelessWidget {
  const BestOfSayugaSection({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenType screenType = FormFactor().getFormFactor(context);
    

    return BlocBuilder<BestOfSayugaCubit, BestOfSayugaState>(
      builder: (context, state) {
        switch (state.status) {
          case BestOfSayugaStatus.initial:
            if (screenType == ScreenType.desktop ||
                screenType == ScreenType.tablet) {
              return const Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                              flex: 1,
                              child: AspectRatio(
                                aspectRatio: 2,
                                child: BestOfSayugaLoadingWindow()
                              )),
                          Flexible(
                              flex: 1,
                              child: AspectRatio(
                                  aspectRatio: 2,
                                  child: Row(
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 1,
                                        child: BestOfSayugaLoadingWindow()
                                      ),
                                      AspectRatio(
                                        aspectRatio: 1,
                                        child: BestOfSayugaLoadingWindow()
                                      ),
                                    ],
                                  ))),
                        ],
                      )),
                  Expanded(
                    flex: 2,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: BestOfSayugaLoadingWindow()
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: BestOfSayugaLoadingWindow()
                        ),
                        AspectRatio(
                          aspectRatio: 1,
                          child: BestOfSayugaLoadingWindow()
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
            const Row(
              children: [
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                        flex: 1,
                        child: AspectRatio(
                            aspectRatio: 2,
                            child: BestOfSayugaLoadingWindow())),
                    Flexible(
                        flex: 1,
                        child: AspectRatio(
                          aspectRatio: 2,
                          child: Row(
                            children: [
                              AspectRatio(
                                  aspectRatio: 1,
                                  child: BestOfSayugaLoadingWindow()),
                              AspectRatio(
                                  aspectRatio: 1,
                                  child: BestOfSayugaLoadingWindow()),
                            ],
                          ),
                        )),
                    Flexible(
                      flex: 2,
                      child: AspectRatio(
                          aspectRatio: 1,
                          child: BestOfSayugaLoadingWindow()),
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: AspectRatio(
                                aspectRatio: 1,
                                child: BestOfSayugaLoadingWindow()),
                          ),
                          Expanded(
                            child: AspectRatio(
                                aspectRatio: 1,
                                child:BestOfSayugaLoadingWindow()),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
              ],
            );
          case BestOfSayugaStatus.failure:
            return SizedBox(
                height: 100,
                child: ColoredBox(
                  color: Theme.of(context).colorScheme.errorContainer,
                  child: Center(
                    child: Text(
                      "Oops! Something went wrong.",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onErrorContainer),
                    ),
                  ),
                ));
          case BestOfSayugaStatus.success:
            if (screenType == ScreenType.desktop ||
                screenType == ScreenType.tablet) {
              return Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                              flex: 1,
                              child: AspectRatio(
                                  aspectRatio: 2,
                                  child: BestOfSayugaWindow(
                                      id: state.jewelryList[0].id.toString(),
                                      url: state.jewelryList[0].mainImage))),
                          Flexible(
                              flex: 1,
                              child: AspectRatio(
                                  aspectRatio: 2,
                                  child: Row(
                                    children: [
                                      AspectRatio(
                                          aspectRatio: 1,
                                          child: BestOfSayugaWindow(
                                              id: state.jewelryList[1].id
                                                  .toString(),
                                              url: state
                                                  .jewelryList[1].mainImage)),
                                      AspectRatio(
                                          aspectRatio: 1,
                                          child: BestOfSayugaWindow(
                                              id: state.jewelryList[2].id
                                                  .toString(),
                                              url: state
                                                  .jewelryList[2].mainImage)),
                                    ],
                                  ))),
                        ],
                      )),
                  Expanded(
                    flex: 2,
                    child: AspectRatio(
                        aspectRatio: 1,
                        child: BestOfSayugaWindow(
                            id: state.jewelryList[3].id.toString(),
                            url: state.jewelryList[3].mainImage)),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AspectRatio(
                            aspectRatio: 1,
                            child: BestOfSayugaWindow(
                                id: state.jewelryList[4].id.toString(),
                                url: state.jewelryList[4].mainImage)),
                        AspectRatio(
                            aspectRatio: 1,
                            child: BestOfSayugaWindow(
                                id: state.jewelryList[5].id.toString(),
                                url: state.jewelryList[5].mainImage)),
                      ],
                    ),
                  )
                ],
              );
            }
            return Row(
              children: [
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                        flex: 1,
                        child: AspectRatio(
                            aspectRatio: 2,
                            child: BestOfSayugaWindow(
                                id: state.jewelryList[0].id.toString(),
                                url: state.jewelryList[0].mainImage))),
                    Flexible(
                        flex: 1,
                        child: AspectRatio(
                          aspectRatio: 2,
                          child: Row(
                            children: [
                              AspectRatio(
                                  aspectRatio: 1,
                                  child: BestOfSayugaWindow(
                                      id: state.jewelryList[1].id.toString(),
                                      url: state.jewelryList[1].mainImage)),
                              AspectRatio(
                                  aspectRatio: 1,
                                  child: BestOfSayugaWindow(
                                      id: state.jewelryList[2].id.toString(),
                                      url: state.jewelryList[2].mainImage)),
                            ],
                          ),
                        )),
                    Flexible(
                      flex: 2,
                      child: AspectRatio(
                          aspectRatio: 1,
                          child: BestOfSayugaWindow(
                              id: state.jewelryList[3].id.toString(),
                              url: state.jewelryList[3].mainImage)),
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: AspectRatio(
                                aspectRatio: 1,
                                child: BestOfSayugaWindow(
                                    id: state.jewelryList[4].id.toString(),
                                    url: state.jewelryList[4].mainImage)),
                          ),
                          Expanded(
                            child: AspectRatio(
                                aspectRatio: 1,
                                child: BestOfSayugaWindow(
                                    id: state.jewelryList[5].id.toString(),
                                    url: state.jewelryList[5].mainImage)),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
              ],
            );
        }
        return const SizedBox();
      },
    );
  }
}
