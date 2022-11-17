import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nuox_project/pages/account/account_services/account_provider.dart';
import 'package:provider/provider.dart';

class InstructorDocumentPage extends StatefulWidget {
  const InstructorDocumentPage({super.key});

  @override
  State<InstructorDocumentPage> createState() => _InstructorDocumentPageState();
}

class _InstructorDocumentPageState extends State<InstructorDocumentPage> {
  File? _image;
  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<AccountProvider>(context);
    final size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Instructor document"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: ListView(padding: const EdgeInsets.all(15), children: [
        SizedBox(
          height: size * .1,
        ),
        Consumer<AccountProvider>(
          builder: (context, value, child) {
            return Container(
              height: size * .5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(value.document?.toString() ??
                          "https://www.aakash.ac.in/blog/wp-content/uploads/2022/07/Blog-Image-612x536.jpg"))),
            );
          },
        ),
        SizedBox(
          height: size * .1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 10)),
                  backgroundColor: const MaterialStatePropertyAll(
                    Colors.purple,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  )),
              onPressed: () async {
                await _pickImage();
                await accountProvider.replaceDocument(
                    image: _image, context: context);

                await accountProvider.getDocument();
              },
              child: accountProvider.isDocumentUploadLoading == true
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const Text(
                      "Replace document",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
        ),
      ]),
    );
  }

  Future _pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      File? img = File(image.path);
      setState(() {
        _image = img;
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //     backgroundColor: Colors.green,
        //     content: Text(
        //       'Image updoaded successfully',
        //       style:
        //           TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        //     )));
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
