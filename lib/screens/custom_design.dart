import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sayuga_jewels/Widgets/custom_design_form.dart';
import 'package:sayuga_jewels/Widgets/footer.dart';
import 'package:sayuga_jewels/logic/cubit/custom_jewelry_post_cubit.dart';
import 'package:sayuga_jewels/utils/url_launcher.dart';

class CustomDesign extends StatefulWidget {
  const CustomDesign({super.key});

  @override
  State<CustomDesign> createState() => _CustomDesignState();
}

class _CustomDesignState extends State<CustomDesign> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => CustomJewelryPostCubit(),
      child: Builder(builder: (context) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: width > 900 ? 1 : 0,
                    child: const SizedBox(),
                  ),
                  Expanded(
                    flex: 3,
                    child: Card.filled(
                      color: Theme.of(context).colorScheme.surface,
                      child: Padding(
                        padding: EdgeInsets.all(width > 900 ? 50 : 0),
                        child: BlocBuilder<CustomJewelryPostCubit,
                            CustomJewelryPostState>(
                          builder: (context, state) {
                            if (state is CustomJewelryPostUploaded) {
                              return Center(
                                  child: Column(
                                children: [
                                  SizedBox(
                                    height: 300,
                                    child: Image.asset(
                                      "assets/images/received.webp",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const Text(
                                      "We've got your design. We will contact you soon."),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  OutlinedButton(
                                      onPressed: () {
                                        BlocProvider.of<
                                                    CustomJewelryPostCubit>(
                                                context)
                                            .newForm();
                                      },
                                      child: const Text("Submit other design")),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text("or"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        context.go("/");
                                      },
                                      child: const Text("Go Home"))
                                ],
                              ));
                            }
                            if (state is CustomJewelryPostFailure) {
                              return Center(
                                  child: Column(
                                children: [
                                  SizedBox(
                                    height: 300,
                                    child: Image.asset(
                                      "assets/images/error.webp",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const Text(
                                      "Hold on! Looks like your design didn't go through."),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  OutlinedButton.icon(
                                    onPressed: () {
                                      String message =
                                          "Hi there! I was trying to submit my custom design through the website form, but it seems there might be an issue. Sending it to you via WhatsApp instead.";
        
                                      Uri url = Uri.parse(
                                          "https://wa.me/14696296139?text=${Uri.encodeQueryComponent(message)}");
                                      launchWeb(url);
                                    },
                                    icon: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Image.asset(
                                        "assets/images/whatsapp.png",
                                        width: 25,
                                      ),
                                    ),
                                    label: const Text("Send Design"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                      "Send your design via WhatsApp! We're here to help."),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text("or"),
                                  TextButton(
                                      onPressed: () {
                                        context.go("/");
                                      },
                                      child: const Text("Go Home"))
                                ],
                              ));
                            }
                            return const CustomDesignForm();
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: width > 900 ? 1 : 0,
                    child: const SizedBox(),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            const Footer()
          ],
        );
      }),
    );
  }
}
