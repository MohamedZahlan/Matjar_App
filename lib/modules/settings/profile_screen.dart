import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/Layout/shop_app/bloc/cubit.dart';
import 'package:flutter_projects/shared/shared_components/components.dart';
import 'package:image_picker/image_picker.dart';
import '../../Layout/shop_app/bloc/states.dart';
import '../../shared/network/shared.styles/colors.dart';
import '../../shared/shared_components/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  final passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  bool? isEdit = false;

  final imagePicker = ImagePicker();

  File? _image;

  //dynamic image;
  Future uploadGalleryImage() async {
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {}
      if (_image != null) {
        isEdit = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopUpdateProfileSuccessState) {
          showToast(
              msg: state.updateModel.message.toString(),
              state: state.updateModel.status!
                  ? ToastStates.SUCCESS
                  : ToastStates.ERROR);
        }
        if (ShopCubit.get(context).userModel!.data.name == null) {
          const Center(child: CircularProgressIndicator());
        }
        if (state is ShopGetImageFromGallerySuccessState) {}
      },
      builder: (context, state) {
        var userModel = ShopCubit.get(context).userModel;
        var cubit = ShopCubit.get(context);
        nameController.text = userModel!.data.name!;
        emailController.text = userModel.data.email!;
        phoneController.text = userModel.data.phone!;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                )),
            title: const Text(
              "Profile",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: userModel == null
              ? const Center(child: CircularProgressIndicator())
              : ConditionalBuilder(
                  condition: userModel != null,
                  builder: (context) => state is ShopUpdateProfileLoadingState
                      ? const LinearProgressIndicator()
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SingleChildScrollView(
                              child: Form(
                                key: _formkey,
                                child: Column(
                                  children: [
                                    Center(
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional.bottomEnd,
                                        children: [
                                          if (isEdit == false)
                                            const CircleAvatar(
                                              radius: 60,
                                              child: Image(
                                                width: 200,
                                                height: 150,
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  'https://cdn.icon-icons.com/icons2/2643/PNG/512/male_man_people_person_avatar_white_tone_icon_159363.png',
                                                ),
                                              ),
                                            ),
                                          if (isEdit == true)
                                            CircleAvatar(
                                              radius: 80,
                                              child: ClipOval(
                                                child: Image.file(
                                                  _image!,
                                                  fit: BoxFit.cover,
                                                  width: 160,
                                                  height: 170,
                                                ),
                                                clipBehavior: Clip.hardEdge,
                                              ),
                                            ),
                                          IconButton(
                                              onPressed: () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  builder: (context) =>
                                                      Container(
                                                    height: 120,
                                                    width: double.infinity,
                                                    margin:
                                                        const EdgeInsets.all(
                                                            25),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {},
                                                          child: Column(
                                                            children: const [
                                                              Image(
                                                                image:
                                                                    AssetImage(
                                                                  "assets/Images/camera.jpg",
                                                                ),
                                                                fit: BoxFit
                                                                    .cover,
                                                                height: 80,
                                                                width: 80,
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                  "From Camera")
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 60,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              uploadGalleryImage();
                                                              isEdit = true;
                                                            });
                                                          },
                                                          child: Column(
                                                            children: const [
                                                              Image(
                                                                image:
                                                                    AssetImage(
                                                                  "assets/Images/gallery.png",
                                                                ),
                                                                fit: BoxFit
                                                                    .cover,
                                                                height: 80,
                                                                width: 80,
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                  "From Gallery")
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              icon: const CircleAvatar(
                                                  radius: 15,
                                                  backgroundColor: Colors.grey,
                                                  child: Icon(
                                                    Icons.camera_alt,
                                                    color: Colors.black,
                                                  )))
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      "${userModel.data.name}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      "${userModel.data.email}",
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      onFieldSubmitted: (value) {
                                        if (_formkey.currentState!.validate() ==
                                            true) {
                                          setState(() {
                                            isEdit = false;
                                          });
                                          ShopCubit.get(context).updateProfile(
                                              name: nameController.text,
                                              email: emailController.text,
                                              phone: phoneController.text,
                                              image: isEdit == true
                                                  ? _image!.path
                                                  : cubit
                                                      .userModel!.data.image);
                                          print(_image!.path);
                                        }
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.account_circle,
                                          size: 30,
                                        ),
                                        label: const Text(
                                          "Name",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      maxLines: 1,
                                      keyboardType: TextInputType.name,
                                      controller: nameController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "name must not be empty";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        labelText: "E-mail",
                                        prefixIcon:
                                            const Icon(Icons.email_outlined),
                                      ),
                                      controller: emailController,
                                      minLines: 1,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'E-mail must not be empty';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    TextFormField(
                                      onSaved: (value) {
                                        if (_formkey.currentState!.validate() ==
                                            true) {
                                          setState(() {
                                            isEdit = false;
                                          });
                                          ShopCubit.get(context).updateProfile(
                                              name: nameController.text,
                                              email: emailController.text,
                                              phone: phoneController.text,
                                              image: isEdit == true
                                                  ? _image!.path
                                                  : cubit
                                                      .userModel!.data.image);
                                          print(_image!.path);
                                        }
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        labelText: "Phone",
                                        prefixIcon: const Icon(Icons.phone),
                                      ),
                                      controller: phoneController,
                                      minLines: 1,
                                      keyboardType: TextInputType.phone,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'phone required';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (_formkey.currentState!.validate() ==
                                            true) {
                                          setState(() {
                                            isEdit = false;
                                          });
                                          ShopCubit.get(context).updateProfile(
                                              name: nameController.text,
                                              email: emailController.text,
                                              phone: phoneController.text,
                                              image: isEdit == true
                                                  ? _image!.path
                                                  : cubit
                                                      .userModel!.data.image);
                                          print(_image!.path);
                                        }
                                      },
                                      child: Container(
                                        height: 55,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 110),
                                        decoration: BoxDecoration(
                                            color: defaultColor,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(
                                          children: const [
                                            Icon(
                                              Icons.save_as_sharp,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Save",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        signOut(context);
                                      },
                                      child: Container(
                                        height: 55,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 110),
                                        decoration: BoxDecoration(
                                            color: defaultColor,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(
                                          children: const [
                                            Icon(
                                              Icons.logout,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Logout",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                  fallback: (context) =>
                      const Center(child: CircularProgressIndicator()),
                ),
        );
      },
    );
  }
}
