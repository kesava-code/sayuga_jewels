import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sayuga_jewels/logic/cubit/custom_jewelry_post_cubit.dart';

class CustomDesignForm extends StatefulWidget {
  const CustomDesignForm({super.key});

  @override
  State<CustomDesignForm> createState() => _CustomDesignFormState();
}

class _CustomDesignFormState extends State<CustomDesignForm> {
  final formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  final _descriptionController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  XFile? image;
  Uint8List? registrationImage;
  bool imageError = false;

  void getImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    registrationImage = await image?.readAsBytes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Custom Jewelry Design',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Center(
            child: Text(
              'We\'d love to help you create your dream design. Please submit the details and we\'ll get back to you with a quote.',
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: AspectRatio(
                aspectRatio: 16 / 9,
                child: image == null
                    ? ListTile(
                        tileColor: Theme.of(context).colorScheme.surfaceVariant,
                        onTap: getImage,
                        title: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_outlined,
                              size: 100,
                            ),
                            Text("Click here to uplaod your design")
                          ],
                        ),
                      )
                    : Stack(children: [
                        Center(
                            child: Image.memory(
                          registrationImage!,
                          fit: BoxFit.contain,
                        )),
                        Center(
                            child: ElevatedButton(
                          onPressed: getImage,
                          child: const Text("Change"),
                        ))
                      ])),
          ),
          imageError
              ? Text(
                  'Please select an Image',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                )
              : const Text(''),
          const SizedBox(height: 20),
          Text('Description',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _descriptionController,
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10)),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceVariant,
              hintText: 'Describe your desired custom design in detail',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please provide a description of your desired design.';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Text('Email',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10)),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceVariant,
              hintText: 'Enter your email address',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email address.';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Text('Mobile Number',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _mobileController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10)),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceVariant,
              hintText: 'Enter your mobile number',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your mobile number.';
              }
              return null;
            },
          ),
          const SizedBox(height: 40),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minimumSize: const Size.fromHeight(60),
                  backgroundColor: Theme.of(context).colorScheme.primary),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  if (image == null) {
                    setState(() {
                      imageError = true;
                    });
                    return;
                  }
                  final description = _descriptionController.text;
                  final email = _emailController.text;
                  final mobileNumber = _mobileController.text;
                  BlocProvider.of<CustomJewelryPostCubit>(context).uploadFile(
                    file: image!,
                    email: email,
                    mobile: mobileNumber,
                    description: description,
                  );

                  // Example showing a success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Custom design request submitted!')),
                  );
                }
              },
              child:
                  BlocBuilder<CustomJewelryPostCubit, CustomJewelryPostState>(
                builder: (context, state) {
                  return state is CustomJewelryPostUploading
                      ? const CupertinoActivityIndicator(
                          color: Color.fromRGBO(255, 255, 255, 1),
                        )
                      : const Text(
                          'Submit Design',
                        );
                },
              )),
        ],
      ),
    );
  }
}
