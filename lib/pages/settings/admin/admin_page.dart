import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lin_stays/database/functions/dbfunction.dart';
import 'package:lin_stays/database/model/model.dart';
import 'package:lin_stays/pages/settings/admin/admin_view.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController guestController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController feeController = TextEditingController();
  TextEditingController receptionController = TextEditingController();

  List<String> items = ['Resort', 'Appartment', 'Room', 'Beach Resort'];
  String? defaultValue = 'Resort';

  List<TextEditingController> miscellaneousList = [];
  List<TextEditingController> rulesList = [];

  File? _image;

  final imagePicker = ImagePicker();
  void getImage() async {
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_sharp),
        backgroundColor: Colors.white,
        title: const Text('Admin Page'),
        centerTitle: true,
        surfaceTintColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
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
                              : const DecorationImage(
                                  image:
                                      AssetImage('assets/images/Logo.png')))),
                ),
                // ===== Resort Details =============
                const Text(
                  'Resort Details',
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Mandatory Field';
                    }
                    return null;
                  },
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name (less than 25 characters)',
                    border: OutlineInputBorder(),
                    floatingLabelStyle: TextStyle(color: Colors.black),
                  ),
                  textCapitalization: TextCapitalization.characters,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Mandatory Field';
                    }
                    return null;
                  },
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
                        value: defaultValue,
                        items: items.map((String value) {
                          return DropdownMenuItem<String>(
                              value: value, child: Text(value));
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            defaultValue = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Mandatory Field';
                    }
                    return null;
                  },
                  controller: roomController,
                  decoration: const InputDecoration(
                      labelText: 'No. of Rooms', border: OutlineInputBorder()),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Mandatory Field';
                    }
                    return null;
                  },
                  controller: guestController,
                  decoration: const InputDecoration(
                      labelText: 'Maximum guests',
                      border: OutlineInputBorder()),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Mandatory Field';
                    }
                    return null;
                  },
                  controller: priceController,
                  decoration: const InputDecoration(
                      labelText: 'Price', border: OutlineInputBorder()),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Mandatory Field';
                    }
                    return null;
                  },
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
                  'Reception Time',
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Mandatory Field';
                    }
                    return null;
                  },
                  controller: receptionController,
                  decoration: const InputDecoration(
                      labelText: 'Reception Time',
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
                          generateTextFormField();
                        },
                        icon: const Icon(Icons.add))
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: miscellaneousList.length,
                  itemBuilder: (context, index) {
                    return getTextFormField(index);
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
                          generateRulesTextFormField();
                        },
                        icon: const Icon(Icons.add))
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: rulesList.length,
                  itemBuilder: (context, index) {
                    return getRulesTextFormField(index);
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
                        if (formKey.currentState!.validate()) {
                          onClickAdd();
                          snackBar();
                        }

                        nameController.clear();
                        roomController.clear();
                        placeController.clear();
                        guestController.clear();
                        priceController.clear();
                        feeController.clear();
                        receptionController.clear();
                        typeController.clear();
                      },
                      child: const Text(
                        'Add',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==================================================================================================================

  Future<void> onClickAdd() async {
    final name = nameController.text.trim();
    final place = placeController.text.trim();
    final rooms = int.parse(roomController.text.trim());

    final guests = int.parse(guestController.text.trim());
    final price = int.parse(priceController.text.trim());
    final cleaningfee = int.parse(feeController.text.trim());
    final reception = receptionController.text.trim();
    List miscellaneousLists = [];
    for (final controller in miscellaneousList) {
      final value = controller.text;
      miscellaneousLists.add(value);
    }
    List rulesLists = [];
    for (final controller in rulesList) {
      final value = controller.text;
      rulesLists.add(value);
    }

    if (_image == null) {
      return;
    }

    final bytes = await _image?.readAsBytes();
    final String base64Image = base64Encode(bytes!);

    final details = LINModel(
        name: name,
        type: defaultValue!,
        place: place,
        noOfRooms: rooms,
        maximumGuest: guests,
        price: price,
        cleaningFee: cleaningfee,
        receptionService: reception,
        miscellaneous: miscellaneousLists,
        rules: rulesLists,
        image: base64Image,
        isFavorite: false);
    addDetails(details);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const AdminEdit(),
      ),
    );
  }

  Widget getTextFormField(int index) {
    TextEditingController controller;
    if (index < miscellaneousList.length) {
      controller = miscellaneousList[index];
    } else {
      controller = TextEditingController();
      miscellaneousList.add(controller);
    }
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Mandatory Field';
                }
                return null;
              },
              controller: controller,
              decoration: const InputDecoration(
                  labelText: 'Enter what you provide',
                  border: OutlineInputBorder()),
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

  Widget getRulesTextFormField(int index) {
    TextEditingController controller;
    if (index < rulesList.length) {
      controller = rulesList[index];
    } else {
      controller = TextEditingController();
      rulesList.add(controller);
    }
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Mandatory Field';
                }
                return null;
              },
              controller: controller,
              decoration: const InputDecoration(
                  labelText: 'Enter Rules', border: OutlineInputBorder()),
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

  void generateTextFormField() {
    setState(() {
      miscellaneousList.add(TextEditingController());
    });
  }

  void generateRulesTextFormField() {
    setState(() {
      rulesList.add(TextEditingController());
    });
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar() {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1500),
      backgroundColor: Colors.blue.shade800,
      content: const Center(child: Text('Added')),
    ));
  }
}
