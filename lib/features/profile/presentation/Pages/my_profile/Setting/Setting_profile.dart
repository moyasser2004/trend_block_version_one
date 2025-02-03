// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:switcher_button/switcher_button.dart';
// import 'package:trend/features/authentication/presentation/pages/login.dart';
// import 'package:trend/features/profile/All_Bloc/bloc/profile_bloc.dart';
// import 'package:trend/features/profile/All_Bloc/bloc/profile_event.dart';
// import 'package:trend/features/profile/All_Bloc/bloc/profile_state.dart';
// import 'package:trend/features/profile/presentation/block_page/block.dart';
// import 'package:trend/features/profile/presentation/user_profile/widgets/Image_view.dart';
// import 'package:trend/utils/currentUser.dart';

// class SettingProfilePage extends StatefulWidget {
//   const SettingProfilePage({
//     Key? key,
//     required this.user,
//   }) : super(key: key);
//   final currentUser user;
//   @override
//   State<SettingProfilePage> createState() => _SettingProfilePageState();
// }

// class _SettingProfilePageState extends State<SettingProfilePage> {
//   File? _selectedImage; // لتخزين الصورة المختارة
//   final ImagePicker _picker = ImagePicker(); // لإنشاء مثيل لالتقاط الصور
//   late String username = "";
//   late String fullname = "";
//   late String bio = "";
//   Future<void> _pickImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         _selectedImage = File(image.path);
//       });
//     } else {
//       print("No image selected");
//     }
//   }

//   Future<void> _pickImageFromCamera() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.camera);
//     if (image != null) {
//       setState(() {
//         _selectedImage = File(image.path);
//       });
//     } else {
//       print("No image captured");
//     }
//   }

//   void showDeleteDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return BlocConsumer<ProfileBloc, ProfileState>(
//           listener: (context, state) {
//             if (state is Deletesuccess) {
//               Navigator.pushReplacement(context,
//                   MaterialPageRoute(builder: (context) => LoginPage()));
//             }
//           },
//           builder: (context, state) {
//             if (state is DeleteLoading) {
//               return Center(
//                 child: CircularProgressIndicator(
//                   color: Colors.black,
//                 ),
//               );
//             } else {
//               return AlertDialog(
//                 title: Text("Delete Confirmation"),
//                 content: Text("Are you sure you want to delete this Account?"),
//                 actions: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pop(); // Close the Dialog
//                     },
//                     child: Text(
//                       "Cancel",
//                       style:
//                           TextStyle(color: Colors.black), // Default text color
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       BlocProvider.of<ProfileBloc>(context).add(Delete());

//                       // // Perform the delete action here
//                       // Navigator.of(context).pop(); // Close the Dialog
//                     },
//                     child: Text(
//                       "Delete",
//                       style: TextStyle(color: Colors.red), // Text in red color
//                     ),
//                   ),
//                 ],
//               );
//             }
//           },
//         );
//       },
//     );
//   }

//   void pickAvatarImage() async {
//     await _pickImageFromCamera();
//   }

//   void saveProfile() {
//     if (fullname.isNotEmpty) {
//       BlocProvider.of<ProfileBloc>(context)
//           .add(Updatefullname(widget.user.id, fullname));
//     }

//     if (bio.isNotEmpty) {
//       BlocProvider.of<ProfileBloc>(context).add(Updatebio(widget.user.id, bio));
//     }
//     if (_selectedImage != null) {
//       BlocProvider.of<ProfileBloc>(context)
//           .add(UpdateAvatar(widget.user.id, _selectedImage!));
//     }
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Profile saved successfully!")),
//     );
//   }

//   bool isLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ProfileBloc, ProfileState>(
//       listener: (context, state) async {
//         if (state is Updatesuccess) {
//           SharedPreferences sharedPreferences =
//               await SharedPreferences.getInstance();
//           await sharedPreferences.setString("avatar", state.avatar);
//           await sharedPreferences.setString("bio", state.bio);
//           await sharedPreferences.setString("fullName", state.full_name);
//           BlocProvider.of<ProfileBloc>(context)
//               .add(getPostForUserevent(id: widget.user.id));
//           Navigator.pop(context);
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           backgroundColor: Colors.grey.shade100,
//           body: ModalProgressHUD(
//             inAsyncCall: isLoading, // عرض شاشة التحميل عند true
//             opacity: 0.5,
//             progressIndicator: CircularProgressIndicator(
//               color: Colors.black,
//             ),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 60.sp,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(
//                         onTap: () async {
//                           BlocProvider.of<ProfileBloc>(context)
//                               .add(getPostForUserevent(id: widget.user.id));
//                           Navigator.pop(context);
//                         },
//                         child: Row(
//                           children: [
//                             SizedBox(
//                               width: 20.sp,
//                             ),
//                             Icon(
//                               Icons.arrow_back_ios,
//                               size: 25.sp,
//                             ),
//                             SizedBox(
//                               width: 20.sp,
//                             ),
//                           ],
//                         ),
//                       ),
//                       Text(
//                         "Setting ",
//                         style: TextStyle(
//                             fontSize: 14.sp, fontWeight: FontWeight.w700),
//                       ),
//                       TextButton(
//                         onPressed: saveProfile,
//                         child: Text(
//                           "Save",
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14.sp),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Stack(
//                     clipBehavior: Clip.none,
//                     alignment: Alignment.topCenter,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => GesturePage(
//                                       image: widget.user.avatar
//                                               .startsWith('http')
//                                           ? widget.user.avatar
//                                           : 'http://167.71.92.176${widget.user.avatar}')));
//                         },
//                         child: Hero(
//                           tag: widget.user.avatar.startsWith('http')
//                               ? widget.user.avatar
//                               : 'http://167.71.92.176${widget.user.avatar}',
//                           child: CircleAvatar(
//                             radius: 45.r,
//                             backgroundImage: _selectedImage == null
//                                 ? NetworkImage(
//                                     widget.user.avatar.startsWith('http')
//                                         ? widget.user
//                                             .avatar // If the avatar already has the full URL, use it directly
//                                         : 'http://167.71.92.176${widget.user.avatar}', // Prepend the base URL
//                                   )
//                                 : FileImage(
//                                     _selectedImage!), // Use FileImage for a local file image
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 3.sp,
//                         left: 0.sp,
//                         child: GestureDetector(
//                           onTap: () {
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return AlertDialog(
//                                   title: Text('Choose Image Source'),
//                                   content: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       IconButton(
//                                         icon: Icon(Icons.camera_alt,
//                                             size: 40, color: Colors.black),
//                                         onPressed: () async {
//                                           await _pickImageFromCamera();
//                                           setState(() {});
//                                           Navigator.pop(context);
//                                         },
//                                       ),
//                                       SizedBox(width: 20),
//                                       IconButton(
//                                         icon: Icon(Icons.photo_library,
//                                             size: 40, color: Colors.black),
//                                         onPressed: () async {
//                                           await _pickImage();
//                                           setState(() {});
//                                           Navigator.pop(context);
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                           child: CircleAvatar(
//                             radius: 12.sp,
//                             backgroundColor: Colors.white,
//                             child: Icon(
//                               Icons.edit,
//                               size: 15.sp,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 20.sp,
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 20.sp),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             SvgPicture.asset(
//                               "assets/icons/settings.svg",
//                               height: 14.sp,
//                             ),
//                             SizedBox(
//                               width: 10.sp,
//                             ),
//                             Text(
//                               "Personal Information",
//                               style: TextStyle(
//                                   fontSize: 14.sp, fontWeight: FontWeight.w500),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 10.sp,
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10.sp),
//                           ),
//                           child: Column(
//                             children: [
//                               ListTile(
//                                 leading: Icon(Icons.verified_user),
//                                 title: Text("Full Name"),
//                                 subtitle: Text(fullname.length == 0
//                                     ? widget.user.fullName
//                                     : fullname),
//                                 onTap: () async {
//                                   TextEditingController _controller =
//                                       TextEditingController(
//                                           text: fullname.length == 0
//                                               ? widget.user.fullName
//                                               : fullname);

//                                   showDialog<String>(
//                                       context: context,
//                                       builder: (BuildContext context) {
//                                         return AlertDialog(
//                                           title: Text(
//                                             "Full Name",
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 20),
//                                           ),
//                                           content: Column(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: [
//                                               TextField(
//                                                 maxLength: 80,
//                                                 controller: _controller,
//                                                 decoration: InputDecoration(
//                                                   labelText: 'Edit Text',
//                                                   border: OutlineInputBorder(),
//                                                 ),
//                                                 inputFormatters: [
//                                                   LengthLimitingTextInputFormatter(
//                                                       80),
//                                                   LineLimitInputFormatter(3),
//                                                 ],
//                                                 maxLines:
//                                                     3, // Allow multiple lines if needed
//                                               ),
//                                               SizedBox(height: 20),
//                                               ElevatedButton(
//                                                 onPressed: () {
//                                                   // Return the edited text when the button is pressed
//                                                   String editedText =
//                                                       _controller.text;
//                                                   Navigator.of(context).pop(
//                                                       editedText); // Pass the edited text
//                                                 },
//                                                 child: Text("Edit",
//                                                     style: TextStyle(
//                                                         color: Colors.white)),
//                                                 style: ElevatedButton.styleFrom(
//                                                   backgroundColor: Colors
//                                                       .black, // Black color for the button
//                                                   foregroundColor: Colors
//                                                       .white, // White color for the text
//                                                   minimumSize: Size(
//                                                       double.infinity,
//                                                       40), // Full width
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         );
//                                       }).then((editedText) {
//                                     if (editedText != null) {
//                                       setState(() {
//                                         fullname = editedText;
//                                         print("Received input: $editedText");
//                                       });
//                                     }
//                                   });
//                                   setState(() {});
//                                 },
//                               ),
//                               Divider(),
//                               ListTile(
//                                 leading: Icon(Icons.text_fields_sharp),
//                                 title: Text("Bio"),
//                                 subtitle: Text(
//                                     bio.length == 0 ? widget.user.bio : bio),
//                                 onTap: () async {
//                                   TextEditingController _controller =
//                                       TextEditingController(
//                                           text: bio.length == 0
//                                               ? widget.user.bio
//                                               : bio);

//                                   showDialog<String>(
//                                       context: context,
//                                       builder: (BuildContext context) {
//                                         return AlertDialog(
//                                           title: Text(
//                                             "bio",
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 20),
//                                           ),
//                                           content: Column(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: [
//                                               TextField(
//                                                 maxLength: 80,
//                                                 controller: _controller,
//                                                 decoration: InputDecoration(
//                                                   labelText: 'Edit Text',
//                                                   border: OutlineInputBorder(),
//                                                 ),
//                                                 inputFormatters: [
//                                                   LengthLimitingTextInputFormatter(
//                                                       80),
//                                                   LineLimitInputFormatter(3),
//                                                 ],
//                                                 maxLines:
//                                                     3, // Allow multiple lines if needed
//                                               ),
//                                               SizedBox(height: 20),
//                                               ElevatedButton(
//                                                 onPressed: () {
//                                                   // Return the edited text when the button is pressed
//                                                   String editedText =
//                                                       _controller.text;
//                                                   Navigator.of(context).pop(
//                                                       editedText); // Pass the edited text
//                                                 },
//                                                 child: Text("Edit",
//                                                     style: TextStyle(
//                                                         color: Colors.white)),
//                                                 style: ElevatedButton.styleFrom(
//                                                   backgroundColor: Colors
//                                                       .black, // Black color for the button
//                                                   foregroundColor: Colors
//                                                       .white, // White color for the text
//                                                   minimumSize: Size(
//                                                       double.infinity,
//                                                       40), // Full width
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         );
//                                       }).then((editedText) {
//                                     if (editedText != null) {
//                                       setState(() {
//                                         bio = editedText;
//                                       });
//                                     }
//                                   });
//                                 },
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20.sp,
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 20.sp),
//                     child: Column(
//                       children: [
//                         ListTile(
//                           leading: Icon(Icons.block, size: 20.sp),
//                           title: Text("BlockList"),
//                           onTap: () {
//                             BlocProvider.of<ProfileBloc>(context)
//                                 .add(getBlockedUser(id: widget.user.id));
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => BlockedUsers(
//                                         id: widget.user
//                                             .id))); // Navigate to BlockList
//                           },
//                         ),
//                         Divider(),
//                         ListTile(
//                           leading: Icon(Icons.logout, size: 20.sp),
//                           title: Text("Logout"),
//                           onTap: () {
//                             setState(() {
//                               isLoading = true;
//                             });
//                             BlocProvider.of<ProfileBloc>(context).add(Logout());
//                             Future.delayed(Duration(seconds: 1), () {
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>
//                                       LoginPage(), // استبدلها بالصفحة التي تريد الذهاب إليها
//                                 ),
//                               );
//                             });
//                           },
//                         ),
//                         Divider(),
//                         ListTile(
//                           leading: Icon(Icons.lock, size: 20.sp),
//                           trailing: SwitcherButton(
//                             value: widget.user.is_private,
//                             onChange: (value) {
//                               BlocProvider.of<ProfileBloc>(context).add(
//                                   Accountprivacy(
//                                       private: value, id: widget.user.id));
//                             },
//                           ),
//                           title: Text("Account privacy"),
//                           onTap: () {},
//                         ),
//                         Divider(),
//                         ListTile(
//                           leading: Icon(Icons.delete, size: 20.sp),
//                           title: Text("Delete Account"),
//                           onTap: () {
//                             showDeleteDialog(context);
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class LineLimitInputFormatter extends TextInputFormatter {
//   final int maxLines;

//   LineLimitInputFormatter(this.maxLines);

//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     // Count the number of lines in the new text
//     int lineCount = '\n'.allMatches(newValue.text).length + 1;

//     // If the number of lines exceeds the limit, revert to the old value
//     if (lineCount > maxLines) {
//       return oldValue;
//     }

//     return newValue;
//   }
// }
