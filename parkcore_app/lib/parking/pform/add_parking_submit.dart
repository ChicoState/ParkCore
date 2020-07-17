import 'package:flutter/material.dart';
import 'package:parkcore_app/navigate/menu_drawer.dart';
import 'package:parkcore_app/models/ParkingData.dart';
import 'package:parkcore_app/models/ParkingData2.dart';
import 'package:parkcore_app/models/ParkingData3.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import 'pform_helpers.dart';

class AddParkingSubmit extends StatefulWidget {
  AddParkingSubmit({Key key,
    this.parkingData, this.parkingData2, this.parkingData3, this.curUser
  }) : super(key: key);

  // This widget is the 'add parking' page of the app. It is stateful: it has a
  // State object (defined below) that contains fields that affect how it looks.
  // This class is the configuration for the state. It holds the values (title)
  // provided by the parent (App widget) and used by the build method of the
  // State. Fields in a Widget subclass are always marked 'final'.

  final ParkingData parkingData;
  final ParkingData2 parkingData2;
  final ParkingData3 parkingData3;
  final String curUser;

  @override
  _MyAddParkingSubmitState createState() => _MyAddParkingSubmitState();
}

class _MyAddParkingSubmitState extends State<AddParkingSubmit> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  FormError formError = FormError();
  final ImagePicker _picker = ImagePicker();
  File _imageFile;
  String _downloadURL;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // build(): rerun every time setState is called (e.g. for stateful methods)
    // Rebuild anything that needs updating instead of having to individually
    // change instances of widgets.
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      key: _scaffoldKey,
      appBar: parkingFormAppBar(),
      drawer: MenuDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Part 5 of 5'),
              SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: buildImages(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildImages() {
    return [
      showImage(),
      SizedBox(height: 10),
      Row(
        children: <Widget>[
          getImageType('camera'),
          SizedBox(width: 10),
          getImageType('gallery'),
        ],
      ),
      SizedBox(height: 10),
      submitParking(),
      SizedBox(height: 10),
      restart(context),
    ];
  }

  // Page 4 Parking Form Widgets (Image and Submit)

  Widget showImage() {
    return Center(
      child: _imageFile == null
        ? Text(
          'No image selected.',
          style: Theme.of(context).textTheme.headline3,
        )
        : Image.file(_imageFile),
    );
  }

  Widget getImageType(String type) {
    return Expanded(
      child: FormField<File>(
        //validator: validateImage,
        builder: (FormFieldState<File> state) {
          return RaisedButton(
            child: Icon(
              type == 'camera' ? Icons.photo_camera : Icons.photo_library,
            ),
            onPressed: () => type == 'camera' ?
              getUserImage(ImageSource.camera) :
              getUserImage(ImageSource.gallery),
            color: Theme.of(context).backgroundColor,
            textColor: Colors.white,
          );
        },
      ),
    );
  }

  // Select an image via gallery or camera
  Future<void> getUserImage(ImageSource source) async {
    var selected = await _picker.getImage(source: source);

    setState(() {
      _imageFile = File(selected.path);
    });
  }

  // Get a unique ID for each image upload
  Future<void> getUniqueFile() async {
    final uuid = Uuid().v1();
    _downloadURL = await _uploadFile(uuid);
  }

  // get download URL for image files
  Future<String> _uploadFile(filename) async {
    //StorageReference
    final ref = FirebaseStorage.instance.ref().child('$filename.jpg');
    //StorageUploadTask
    final uploadTask = ref.putFile(
      _imageFile,
      StorageMetadata(contentLanguage: 'en'),
    );

    final downloadURL = await (await uploadTask.onComplete).ref.getDownloadURL();
    return downloadURL.toString();
  }

  // Submit Button for form to add a Parking Space:
  // create a parking space (with all data) that can be saved as JSON in
  // Firestore, then navigate to 'success' page (form was submitted)
  Widget submitParking() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        RaisedButton(
          key: Key('submit'),
          onPressed: () {
            final form = _formKey.currentState;
            form.save();

            createParkingSpace();
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/form_success',
              (Route<dynamic> route) => false,
            );
          },
          child: Text(
            'Submit',
            style: Theme.of(context).textTheme.headline4,
          ),
          color: Theme.of(context).accentColor,
        ),
      ],
    );
  }

  // Create ParkingSpaces database entry using all parkingData, then add the
  // Map<String, dynamic> (in JSON format) to Firestore
  Future<void> createParkingSpace() async {
    // If user uploads an image, create a unique file id with a unique download
    // URL for storage in Firestore; else, downloadURL is null (image optional)
    if(_imageFile != null){
      await getUniqueFile();
    }
    else{
      _downloadURL = '';
    }

    //Map<String, dynamic>
    var allParkingData = {
      'downloadURL': _downloadURL, // for the image (put in firebase storage)
      'reserved': [], // list of UIDs (if reserved, starts empty)
      'cur_tenant': '', // current tenant (a UID, or empty if spot is available)
    };
    allParkingData['reserved'] = allParkingData['reserved'].toString();

    allParkingData.addAll(widget.parkingData.toJson());
    allParkingData.addAll(widget.parkingData2.toJson());
    allParkingData.addAll(widget.parkingData3.toJson());

    await Firestore.instance.runTransaction((transaction) async {
      //CollectionReference
      var ref = Firestore.instance.collection('parkingSpaces');
      await ref.add(allParkingData);
    });
  }
}
