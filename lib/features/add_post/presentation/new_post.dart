import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trend/features/add_post/bloc/AddPostEvent.dart';
import 'package:trend/features/add_post/bloc/Add_Post_State.dart';
import 'package:trend/features/add_post/bloc/Add_Post_cubit.dart';
import 'package:trend/features/add_post/domain/entities/post.dart';
import 'package:trend/features/add_post/presentation/widgets/textField.dart';
import 'package:trend/features/bottom_nav_bar/Bloc/Bottom_Nav_Bloc.dart';
import 'package:trend/features/bottom_nav_bar/Bloc/Bottom_Nav_event.dart';
import 'package:trend/features/posts/presentation/Manager/Bloc_Current_user/Current%20_user_Bloc.dart';
import 'package:trend/features/posts/presentation/Manager/Bloc_Current_user/Current%20_user_event.dart';
import 'package:trend/features/posts/presentation/Manager/Bloc_post/post_bloc.dart';
import 'package:trend/features/posts/presentation/Manager/Bloc_post/post_event.dart';

import '../../../shared/core/local/SharedPreferencesDemo.dart';
import '../../../shared/utiles/routes.dart';

class AddNewPostPage extends StatefulWidget {
  const AddNewPostPage({super.key});

  @override
  State<AddNewPostPage> createState() => _AddNewPostPageState();
}

class _AddNewPostPageState extends State<AddNewPostPage> {
  String _description = "";
  File? _selectedImage;

  // Image Cropper Function
  Future<File?> cropImage(XFile pickedFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Crop Image',
          aspectRatioLockEnabled: true,
          resetButtonHidden: false,
          aspectRatioPickerButtonHidden: true,
          rotateButtonsHidden: true,
          rotateClockwiseButtonHidden: true,
          doneButtonTitle: 'Done',
          cancelButtonTitle: 'Cancel',
        ),
      ],
    );

    return croppedFile != null ? File(croppedFile.path) : null;
  }

  // Function to Pick Image from Camera or Gallery
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      final croppedImage = await cropImage(pickedFile);
      if (croppedImage != null) {
        setState(() {
          _selectedImage = croppedImage;
        });
      }
    } else {
      print("No image selected");
    }
  }

  // Show Dialog to Choose Between Camera & Gallery
  void _showImagePickerDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Take a Photo"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Choose from Gallery"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamed(context, AppRoutes.home);
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: SizedBox(
            height: 45,
            width: MediaQuery.of(context).size.width,
            child: BlocConsumer<AddPostBloc, AddPostState>(
              listener: (context, state) async {
                if (state is AddPostSuccess) {
                  BlocProvider.of<BottomNavBloc>(context)
                      .add(BottomNavItemSelected(0));

                  setState(() {
                    _description = "";
                    _selectedImage = null;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("The Post was added successfully"),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );

                  int c = await SharedPreferencesDemo.getID();
                  BlocProvider.of<CurrentUserBloc>(context)
                      .add(GetPostForCurrentUserEvent(id: c));
                  BlocProvider.of<PostBloc>(context).add(FetchPosts());
                }
              },
              builder: (context, state) {
                if (state is AddPostLoading) {
                  return ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const CircularProgressIndicator(color: Colors.black),
                  );
                } else {
                  return ElevatedButton(
                    onPressed:
                        (_selectedImage != null && _description.isNotEmpty)
                            ? () {
                                context.read<AddPostBloc>().add(
                                      AddNewPostEvent(
                                        NewPost(
                                          fileImage: _selectedImage!,
                                          description: _description,
                                        ),
                                      ),
                                    );
                              }
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          (_selectedImage != null && _description.isNotEmpty)
                              ? Colors.black
                              : Colors.grey[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Save & Share',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: const Text(
                    'Add a new post',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: CustomTextField(
                  onChanged: (value) {
                    setState(() {
                      _description = value;
                    });
                  },
                ),
              ),
              SliverToBoxAdapter(child: const SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Spacer(),
                    IconButton(
                      onPressed: _showImagePickerDialog,
                      icon: const Icon(Icons.attach_file),
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(child: const SizedBox(height: 20)),
              SliverToBoxAdapter(
                child: (_selectedImage != null)
                    ? Center(
                        child: InkWell(
                          onTap: () async {
                            if (_selectedImage != null) {
                              final croppedImage =
                                  await cropImage(XFile(_selectedImage!.path));
                              if (croppedImage != null) {
                                setState(() {
                                  _selectedImage = croppedImage;
                                });
                              }
                            }
                          },
                          child: Image.file(
                            _selectedImage!,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
