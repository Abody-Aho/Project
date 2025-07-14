import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class Settings1 extends StatefulWidget {
  const Settings1({super.key});

  @override
  State<Settings1> createState() => _Settings1State();
}

class _Settings1State extends State<Settings1> {
  File? localImage;
  final ImagePicker picker = ImagePicker();
  String userName = "جارٍ التحميل...";
  String userEmail = "";
  bool isLoading = true;

  awsome(Title,Desc,DialogType,Cancel,Ok){
    AwesomeDialog(
      context: context,
      dialogType: DialogType,
      animType: AnimType.rightSlide,
      title: Title,
      desc: Desc,
      btnCancelOnPress: Cancel,
      btnOkOnPress: Ok,
    ).show();
  }
  @override
  void initState() {
    super.initState();
    loadUserData();
    loadLocalImage();
  }

  Future<void> pickAndSaveImageLocally() async {
    var permission = Platform.isAndroid ? Permission.storage : Permission.photos;
    var status = await permission.status;

    if (status.isDenied || status.isRestricted) {
      status = await permission.request();
    }

    if (status.isPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("الرجاء تفعيل إذن الوصول من إعدادات الهاتف")),
      );
      await openAppSettings();
      return;
    }

    if (status.isGranted) {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        final dir = await getApplicationDocumentsDirectory();
        final file = File("${dir.path}/profile.jpg");
        await file.writeAsBytes(bytes);
        setState(() {
          localImage = file;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("يجب السماح للتطبيق بالوصول للصور")),
      );
    }
  }

  Future<void> loadLocalImage() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/profile.jpg");
    if (file.existsSync()) {
      setState(() {
        localImage = file;
      });
    }
  }

  Future<void> loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userEmail = user.email ?? "لا يوجد بريد";
      });
      if (user.displayName != null && user.displayName!.isNotEmpty) {
        setState(() {
          userName = user.displayName!;
          isLoading = false;
        });
      } else {
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (doc.exists && doc.data() != null) {
          setState(() {
            userName = doc['name'] ?? "بدون اسم";
            isLoading = false;
          });
        } else {
          setState(() {
            userName = "اسم غير معروف";
            isLoading = false;
          });
        }
      }
    } else {
      setState(() {
        userName = "غير مسجل الدخول";
        userEmail = "";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: localImage != null
                          ? FileImage(localImage!)
                          : const AssetImage('images/6.png') as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.orange),
                        onPressed: pickAndSaveImageLocally,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                isLoading
                    ? const CircularProgressIndicator()
                    : Text(
                  userName,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  userEmail,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text("إعدادات الحساب", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("اللغة"),
            subtitle: const Text("العربية"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
             awsome("تحذير", "ليس متوفر حالين",DialogType.error,() {},() {});
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const Text("الوضع الليلي"),
            value: false,
            onChanged: (val) {
              // تفعيل الوضع الليلي لاحقًا
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("تسجيل الخروج", style: TextStyle(color: Colors.red)),
            onTap: () async {
              try {
                await GoogleSignIn().signOut();
              } catch (_) {}
              await FirebaseAuth.instance.signOut();
              if (mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil("Login", (route) => false);
              }
            },
          ),
        ],
      ),
    );
  }
}
