import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_app_task/components/interset_dropdwon.dart';
import 'package:note_app_task/model/home_notes_model.dart';
import 'package:note_app_task/model/user_model.dart';
import 'package:note_app_task/widget/text_field.dart';
import 'package:provider/provider.dart';

class AddUser extends StatefulWidget {
  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final TextEditingController _userName = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final TextEditingController _email = TextEditingController();

  File? _image;

  final picker = ImagePicker();

  Future getImage() async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

// File imageFile = new File(imageFilePath);
// List<int> imageBytes = imageFile.readAsBytesSync();
// String base64Image = BASE64.encode(imageBytes);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        getImage();
                      },
                      child: const CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage(
                            "https://cdn.pixabay.com/photo/2018/08/28/12/41/avatar-3637425_960_720.png"),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GenericTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter User Name ';
                      }
                      return null;
                    },
                    labelText: " User Name",
                    controller: _userName,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GenericTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Password ';
                      }
                      return null;
                    },
                    labelText: "Password",
                    controller: _email,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GenericTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Email ';
                      }
                      return null;
                    },
                    labelText: " Email",
                    controller: _password,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const IntersetDropdwon(),
                  const SizedBox(
                    height: 40,
                  ),
                  provider.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : MaterialButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() ||
                                provider.getvalueInterst == null) {
                              provider.addUser(
                                context: context,
                                userName: _userName.text,
                                password: _password.text,
                                email: _email.text,
                                // imageUrl:_image ,
                              );
                            }
                          },
                          child: const Text("Save"),
                        ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
