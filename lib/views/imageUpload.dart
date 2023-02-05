import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_tag/constants/colors.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../constants/collections.dart';
import '../constants/fonts.dart';
import 'imagePreview.dart';

class ImageUpload extends StatefulWidget {
   ImageUpload({Key? key}) : super(key: key);

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  TextEditingController nameController = TextEditingController();

  void addPhoto() async {



    String singlePhoto = "";

    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      if (result.files.single.size < 10485760) {
        singlePhoto = result.files.single.path!;
        Get.bottomSheet(
            SizedBox(
              height: Get.height,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Image Preview",
                      style: fontMontserrat(fontSize: 19),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Text(
                            "Name :",
                            style: fontMontserrat(fontSize: 19),
                          ),
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: TextFormField(
                        controller: nameController,
                        style: fontMontserrat(fontSize: 16, fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          enabledBorder:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xffE7E7E7), width: 1)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Image.file(
                      File(singlePhoto),
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          height: 40,
                          elevation: 0,
                          highlightElevation: 0,
                          minWidth: 130,
                          color: kSecondaryColor,
                          onPressed: () => Get.back(),
                          shape: const StadiumBorder(),
                          child: Text("Cancel"),
                        ),
                        const SizedBox(width: 20),
                        MaterialButton(
                          height: 40,
                          elevation: 0,
                          highlightElevation: 0,
                          minWidth: 130,
                          color: kSecondaryColor,
                          onPressed: () async {
                            if (singlePhoto.isNotEmpty) {
                              try {
                                String photoUrl = "";
                                String ext2 = singlePhoto.split(".").last;
                                firebase_storage.TaskSnapshot _pSnapshot = await firebase_storage.FirebaseStorage.instance
                                    .ref('users/photos/photo_${DateTime.now().millisecondsSinceEpoch}.$ext2')
                                    .putFile(File(singlePhoto));
                                photoUrl = await _pSnapshot.ref.getDownloadURL();
                                await usersCollection.add({
                                  "createdAt": DateTime.now(),
                                  "name": nameController.text,
                                  "photos": photoUrl,
                                }).then((value) => Get.back());
                              } on FirebaseException catch (e) {
                                print(e.toString());
                              }
                            }
                          },
                          shape: const StadiumBorder(),
                          child: Text("Add"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            backgroundColor: Colors.white);
      } else {
        // customSnackBar("Error!", "File limit exceeded");
      }
    } else {
      //customSnackBar("Error!", "No file has been picked");
    }
  }


  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: kBlackColor,
          elevation: 0,
          title: Text(
            "Upload Image",
            style: fontMontserrat(color: kWhiteColor, fontSize: 25, letterSpacing: 1),
          ),
        ),
        body: ListView(
          children: [
            SizedBox(height: 20,),

            Center(child: Text("Click on the images to get a preview",style: fontMontserrat(fontWeight: FontWeight.normal,fontSize: 13),)),
            SizedBox(height: 20,),
            Container(
              height: Get.height/2,

              child: StreamBuilder<QuerySnapshot>(
                  stream: usersCollection.snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return SizedBox();

                    List<DocumentSnapshot> data = snapshot.data!.docs;
                    return GridView.builder(
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: data.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                          final image =  data[index]['photos'];
                        return GestureDetector(
                          onTap: () {
                            Get.dialog(ImagePreview(url: image));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: kBlackColor),
                    onPressed: () {
                      addPhoto();
                    },
                    child: Text(
                      "Upload",
                      style: fontMontserrat(fontSize: 22),
                    )),
              ),
            )
          ],
        ));
  }
}


