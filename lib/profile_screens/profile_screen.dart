import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/mainbutton.dart';
import '../constants/textfields.dart';
import '../notifications_screen/notification_screen.dart';
import '../settings_screen/settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Uint8List? _image;
  File? selectedImage;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _uid;
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  String get uid => FirebaseAuth.instance.currentUser?.uid ?? '';
  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _uid = user.uid;
        _firstNameController.text = user.displayName ?? '';
        _emailController.text = user.email ?? '';
        // Add logic to fetch additional user information if needed
      });
    }
  }

  

  @override
  Widget build(BuildContext context) {


    final firstNameController = TextFormField(
      controller: _firstNameController,
      cursorColor: Colors.orange,
      decoration: InputDecoration(
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xff6B7280).withOpacity(0.3),
          ),
        ),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6B7280).withOpacity(0.3))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6B7280).withOpacity(0.3)),
            borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(vertical: 19, horizontal: 20),
        border: InputBorder.none,
        hintText: "First Name",
        hintStyle: TextStyle(color: Color(0xff9E9E9E), fontSize: 18),
      ),
    );

    final secondNamecontroller = TextFormField(
      controller: _lastNameController,
      cursorColor: Colors.orange,
      decoration: InputDecoration(
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xff6B7280).withOpacity(0.3),
          ),
        ),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6B7280).withOpacity(0.3))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6B7280).withOpacity(0.3)),
            borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(vertical: 19, horizontal: 20),
        border: InputBorder.none,
        hintText: "Last Name",
        hintStyle: TextStyle(color: Color(0xff9E9E9E), fontSize: 18),
      ),
    );

    final emailAdd = TextFormField(
      controller: _emailController,
      cursorColor: Colors.orange,
      decoration: InputDecoration(
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xff6B7280).withOpacity(0.3),
          ),
        ),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6B7280).withOpacity(0.3))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6B7280).withOpacity(0.3)),
            borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(vertical: 19, horizontal: 20),
        border: InputBorder.none,
        hintText: "Email Address",
        hintStyle: TextStyle(color: Color(0xff9E9E9E), fontSize: 18),
      ),
    );

    // Password Text Fields
    final mobileNumber = TextFormField(
      controller: _dobController,
      cursorColor: Colors.orange,
      decoration: InputDecoration(
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xff6B7280).withOpacity(0.3),
          ),
        ),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6B7280).withOpacity(0.3))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6B7280).withOpacity(0.3)),
            borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(vertical: 19, horizontal: 20),
        border: InputBorder.none,
        hintText: "Mobile Number",
        hintStyle: TextStyle(color: Color(0xff9E9E9E), fontSize: 18),
      ),
    );





    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.grey.shade400, width: 2),
                              borderRadius: BorderRadius.circular(8)),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 7),
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'Profile',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                     NotificationScreen()));
                      },
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: const Icon(
                            Icons.notifications_outlined,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 75,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : const CircleAvatar(
                            radius: 75,
                            backgroundImage: AssetImage('assets/ppp.png'),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 110,
                      ),
                      child: InkWell(
                        onTap: () {
                          showImagePickerOption(context);
                        },
                        child: Image.asset(
                          'assets/cam.png',
                          scale: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                  firstNameController,
                const SizedBox(
                  height: 20,
                ),
                  secondNamecontroller,
                const SizedBox(
                  height: 20,
                ),
              mobileNumber,
                const SizedBox(
                  height: 20,
                ),
             emailAdd,
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 30,
                ),
                Button(
                  child: const Center(
                    child: Text(
                      'Update',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ),
                  gradient: const LinearGradient(
                    colors: [Color(0xffC3B39E), Color(0xff725E45)],
                  ),
                  onTap: () {
                _profileScreen();
                 
                  
                  },
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _profileScreen() async {
   if (uid.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please sign in to update data')),
      );
      return;
    }
    try {
      await FirebaseFirestore.instance.collection('users') // Replace with your collection name
          .doc(uid)
          .update({
            'firstName': _firstNameController.text,
            'lastName': _lastNameController.text,
            'dob':_dobController.text,
            'email':_emailController.text
          });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Firestore data updated successfully!')),
      );
    } catch (error) {
      print('Error updating Firestore: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update Firestore data')),
      );
    }
  }


  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.blue[100],
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4.5,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImageFromGallery();
                    },
                    child: SizedBox(
                      child: Column(
                        children: const [
                          Icon(
                            Icons.image,
                            size: 70,
                          ),
                          Text("Gallery")
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImageFromCamera();
                    },
                    child: SizedBox(
                      child: Column(
                        children: const [
                          Icon(
                            Icons.camera_alt,
                            size: 70,
                          ),
                          Text("Camera")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Gallery
  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop(); // Close the modal sheet
  }

  // Camera
  Future _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }
}