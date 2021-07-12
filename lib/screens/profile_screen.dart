import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:publist/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;
  File _image;

  @override
  Widget build(BuildContext context) {
    final user= _auth.currentUser;
    String userUrl=user.photoURL;

    Future uploadImage(BuildContext context) async{
      String filename=basename(_image.path);
      Reference storageRef=FirebaseStorage.instance.ref().child(filename);
      UploadTask uploadTask= storageRef.putFile(_image);
      try {
        TaskSnapshot snapshot = await uploadTask;
        setState(() {
          storageRef.getDownloadURL().then((Url) => user.updatePhotoURL(Url));
          print('Uploaded ${snapshot.bytesTransferred} bytes.');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Profile Picture Uploaded'),
            ),
          );
        });

      } on  FirebaseException catch (e) {
        print(uploadTask.snapshot);
        if (e.code == 'permission-denied') {
          print('User does not have permission to upload to this reference.');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message),
            ),
          );
        }
        // ...
      }
    }
    Future getImage() async{
      var image=await ImagePicker.platform.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = File(image.path);
      });
      uploadImage(context);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kMainThemeColor,
        title: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget> [
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget> [
              SizedBox(width:50),
              Align(alignment: Alignment.center,
              child: CircleAvatar(radius: 100,
              backgroundColor: kMainThemeColor,
              child: ClipOval(
                child: SizedBox(
                  height: 180,
                  width: 180,
                  child:Image.network(userUrl,fit: BoxFit.fill,)
                ),
              ),),),
              Padding(
                padding: EdgeInsets.only(top:60.0,left :10,),
                child: IconButton(

                  icon: Icon(
                    Icons.add_a_photo,
                    size: 40,
                    color: kMainThemeColor,
                  ),
                  onPressed: () async{
                      await getImage().then((value) {setState(() {
                        userUrl=user.photoURL;
                      });});

                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text('User Name',style: fadeTextStyle),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget> [
              SizedBox(width:40,),
              Text(user.displayName,style: defaultTextStyle),
              IconButton(icon:Icon(Icons.border_color,), onPressed: (){})
            ],
          ),
          SizedBox(height: 20),
          Text('Email',style: fadeTextStyle),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget> [
              SizedBox(width:40,),
              Text(user.email,style: defaultTextStyle),
              IconButton(icon:Icon(Icons.border_color,), onPressed: (){})
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget> [
              SizedBox(width:40,),
              Text('Password',style: fadeTextStyle),
              IconButton(icon:Icon(Icons.border_color,), onPressed: (){})
            ],
          ),
        ],
      ),
      );
  }
}
/*
*
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 25),
            SizedBox(height: 115,width: 115,child: CircleAvatar(backgroundColor: Colors.black,),),
            SizedBox(
              height: 36.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: user.displayName),
                  ),
                ),

                Icon(Icons.border_color),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password'),
            ),

          ],*/


/*Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.border_color),
              )*/