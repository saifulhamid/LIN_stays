import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lin_stays/database/functions/dbfunction.dart';
import 'package:lin_stays/database/model/model.dart';
import 'package:lin_stays/pages/settings/admin/admin_view.dart';

class EditResort extends StatefulWidget {
  final int index;
  const EditResort(this.index, {Key? key}) : super(key: key);

  @override
  State<EditResort> createState() => _EditResortState();
}

class _EditResortState extends State<EditResort> {
  TextEditingController nameController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  TextEditingController guestController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController feeController = TextEditingController();
  TextEditingController receptionController = TextEditingController();
  TextEditingController miscellaneousController = TextEditingController();
  TextEditingController rulesController = TextEditingController();
  List<String> items = ['Resort', 'Appartment', 'Room', 'Beach Resort'];

  List miscellaneousList = [];
  List rulesList = [];

  late LINModel _linModel;
  File? _image;

  final imagePicker = ImagePicker();
  void getImage() async {
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
        // _image.path;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    final resortList = resortDetailList.value;
    _linModel = resortList[widget.index];
    nameController.text = _linModel.name;
    typeController.text = _linModel.type;
    placeController.text = _linModel.place;
    roomController.text = _linModel.noOfRooms.toString();
    guestController.text = _linModel.maximumGuest.toString();
    priceController.text = _linModel.price.toString();
    feeController.text = _linModel.cleaningFee.toString();
    receptionController.text = _linModel.receptionService;
    miscellaneousList = _linModel.miscellaneous;
    rulesList = _linModel.rules;
  }

  @override
  Widget build(BuildContext context) {
    final imageBytes = _linModel.image;
    final image = base64Decode(imageBytes);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text('Edit Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text(
                  'Add Rooms',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              GestureDetector(
                onTap: getImage,
                child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        image: _image != null
                            ? DecorationImage(
                                image: Image.file(_image!).image,
                                fit: BoxFit.cover)
                            : DecorationImage(image: MemoryImage(image)))),
              ),
              // ===== Resort Details =============
              const Text(
                'Resort Details',
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                    labelText: 'Name (less than 25 characters)',
                    border: OutlineInputBorder(),
                    floatingLabelStyle: TextStyle(color: Colors.black)),
                textCapitalization: TextCapitalization.characters,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: placeController,
                decoration: const InputDecoration(
                    labelText: 'place',
                    border: OutlineInputBorder(),
                    floatingLabelStyle: TextStyle(color: Colors.black)),
                textCapitalization: TextCapitalization.characters,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white54),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: typeController.text,
                      items: items.map((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          typeController.text = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: roomController,
                decoration: const InputDecoration(
                    labelText: 'No. of Rooms', border: OutlineInputBorder()),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: guestController,
                decoration: const InputDecoration(
                    labelText: 'Maximum guests', border: OutlineInputBorder()),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(
                    labelText: 'Price', border: OutlineInputBorder()),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: feeController,
                decoration: const InputDecoration(
                    labelText: 'Cleaning fee', border: OutlineInputBorder()),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 20,
              ),
              // ===================== Reception Service ========================
              const Text(
                'Reception Service',
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                controller: receptionController,
                decoration: const InputDecoration(
                    labelText: 'Reception Service',
                    border: OutlineInputBorder()),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Miscellaneous',
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                      onPressed: () {
                        generateTextField();
                      },
                      icon: const Icon(Icons.add))
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: miscellaneousList.length,
                itemBuilder: (context, index) {
                  TextEditingController miscController =
                      TextEditingController(text: miscellaneousList[index]);
                  return getTextField(miscController, index);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Rules',
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                      onPressed: () {
                        generateRulesTextField();
                      },
                      icon: const Icon(Icons.add))
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: rulesList.length,
                itemBuilder: (context, index) {
                  TextEditingController ruleController =
                      TextEditingController(text: rulesList[index]);
                  return getRulesTextField(ruleController, index);
                },
              ),

              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.green.shade700),
                        shape: MaterialStatePropertyAll(
                            ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(10)))),
                    onPressed: () {
                      updateDetails();
                      snackBar();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => AdminEdit(),
                      ));
                      // dispose();
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // =======================================================================================================

  Future<void> updateDetails() async {
    final resortList = resortDetailList.value;
    final updated = LINModel(
        isFavorite: false,
        id: _linModel.id,
        name: nameController.text,
        place: placeController.text,
        type: typeController.text,
        noOfRooms: int.parse(roomController.text),
        maximumGuest: int.parse(guestController.text),
        price: int.parse(priceController.text),
        cleaningFee: int.parse(feeController.text),
        receptionService: receptionController.text,
        miscellaneous: miscellaneousList,
        rules: rulesList,
        image: _image != null
            ? base64Encode(_image!.readAsBytesSync())
            : _linModel.image);
    resortList[widget.index] = updated;
    final box = await Hive.openBox<LINModel>(dbName);
    await box.put(_linModel.id, updated);
    resortDetailList.value = resortList;
    resortDetailList.notifyListeners();
  }

  void generateTextField() {
    setState(() {
      miscellaneousList.add('');
    });
  }

  Widget getTextField(miscController, int index) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: TextField(
              controller: miscController,
              onSubmitted: (value) {
                setState(() {
                  miscellaneousList[index] = value;
                });
              },
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              setState(() {
                miscellaneousList.removeAt(index);
              });
            },
            icon: const Icon(Icons.remove))
      ],
    );
  }

  void generateRulesTextField() {
    setState(() {
      rulesList.add('');
    });
  }

  Widget getRulesTextField(ruleController, int index) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: TextField(
              controller: ruleController,
              onSubmitted: (value) {
                setState(() {
                  rulesList[index] = value;
                });
              },
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              setState(() {
                rulesList.removeAt(index);
              });
            },
            icon: const Icon(Icons.remove))
      ],
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar() {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1500),
      backgroundColor: Colors.blue.shade800,
      content: const Center(child: Text('Updated')),
    ));
  }
}
