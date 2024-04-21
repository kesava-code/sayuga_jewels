
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sayuga_jewels/logic/cubit/jewelry_details_cubit.dart';

class ImageInteractiveViewer extends StatefulWidget {
  const ImageInteractiveViewer({
    super.key,
    required this.currentImage,
  });
  final int currentImage;

  @override
  State<ImageInteractiveViewer> createState() => _ImageInteractiveViewerState();
}

class _ImageInteractiveViewerState extends State<ImageInteractiveViewer> {
  int? currentImage;
  PageController? _controller;

  @override
  void initState() {
    currentImage = widget.currentImage;

    _controller = PageController(initialPage: currentImage!);
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<JewelryDetailsCubit, JewelryDetailsState>(
      builder: (context, state) {
        if (state is JewelryDetailsLoaded) {
          return ColoredBox(
            color: Theme.of(context).colorScheme.background,
            child: SafeArea(
                child: Stack(children: [
              PageView(
                  controller: _controller,
                  children: List.generate(
                      state.jewelry.imageList.length,
                      (index) => Stack(children: [
                            GestureDetector(
                              onTap: () {
                                context.pop();
                              },
                            ),
                            Center(
                              child: InteractiveViewer(
                                  child: Hero(
                                      tag: index,
                                      child: Image(
                                          image:
                                              state.jewelry.imageList[index]))),
                            ),
                          ]))),
              Positioned(
                  top: 50,
                  right: 50,
                  child: IconButton.filledTonal(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(Icons.close))),
              Visibility(
                visible: currentImage == 0 ? false : true,
                child: Positioned(
                    left: 0,
                    top: height / 2,
                    child: IconButton(
                        style: IconButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .surfaceVariant
                                .withAlpha(180)),
                        onPressed: () {
                          setState(() {
                            if (currentImage != 0) {
                              currentImage = currentImage! - 1;
                            }
                          });
                          _controller!.animateToPage((currentImage!),
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                        ))),
              ),
              Visibility(
                visible: currentImage == state.jewelry.imageList.length - 1
                    ? false
                    : true,
                child: Positioned(
                    right: 0,
                    top: height / 2,
                    child: IconButton(
                      style: IconButton.styleFrom(
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .surfaceVariant
                              .withAlpha(180)),
                      iconSize: 30,
                      onPressed: () {
                        setState(() {
                          if (currentImage !=
                              state.jewelry.imageList.length - 1) {
                            currentImage = currentImage! + 1;
                          }
                        });
                        _controller!.animateToPage((currentImage!),
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                      icon: const Icon(Icons.arrow_forward_ios_rounded),
                    )),
              ),
            ])),
          );
        }
        return SafeArea(
            child: PageView(
          children: const [],
        ));
      },
    );
  }
}
