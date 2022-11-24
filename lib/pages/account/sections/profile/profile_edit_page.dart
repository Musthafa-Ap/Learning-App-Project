import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nuox_project/constants/constants.dart';
import 'package:nuox_project/pages/account/account_services/account_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  ValueNotifier<String> selectedDateNotifier =
      ValueNotifier("Select Date of Birth");
  final _formKey = GlobalKey<FormState>();
  ValueNotifier<String> selectedGenderNotifier = ValueNotifier("Male");
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final _genders = ["Male", "Female", "Others"];
  String? name;
  File? _image;
  String? _email;
  String? _mobile;
  String? _address;
  String? _dob;
  String? _gender;
  String? _profileimage;
  @override
  void initState() {
    getdata();
    super.initState();
  }

  void getdata() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    name = sharedPref.getString("name");
    String? email = sharedPref.getString("email");
    String? _nmbr = sharedPref.getString("number");
    _address = sharedPref.getString("address");
    _dob = sharedPref.getString("dob");
    _gender = sharedPref.getString("gender");
    _profileimage = sharedPref.getString("image");
    if (name != null) {
      setState(() {
        _nameController.text = name!;
      });
    }
    if (email != null) {
      setState(() {
        _email = email;
      });
    }
    if (_nmbr != null) {
      setState(() {
        _mobile = _nmbr;
      });
    }
    if (_address != null) {
      setState(() {
        _addressController.text = _address!;
      });
    }
    if (_dob != null) {
      selectedDateNotifier.value = _dob!;
    }
    if (_gender != null) {
      selectedGenderNotifier.value = _gender!;
    }
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final accountProvider =
        Provider.of<AccountProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Edit profile"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(15),
          children: [
            kHeight,
            GestureDetector(
              onTap: () {
                //   _pickImage();
                showModalBottomSheet(
                  backgroundColor: Colors.white,
                  context: context,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          kHeight,
                          GestureDetector(
                            onTap: () {
                              _pickImage(ImageSource.gallery);
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black,
                              ),
                              height: 55,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.image,
                                    color: Colors.white,
                                  ),
                                  kWidth10,
                                  Text(
                                    "Gallery",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          kHeight,
                          Row(
                            children: const [
                              Expanded(
                                  child: Divider(
                                color: Colors.black,
                              )),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "OR",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              Expanded(
                                  child: Divider(
                                color: Colors.black,
                              )),
                            ],
                          ),
                          kHeight,
                          GestureDetector(
                            onTap: () {
                              _pickImage(ImageSource.camera);
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black,
                              ),
                              height: 55,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                  ),
                                  kWidth10,
                                  Text(
                                    "Camera",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          kHeight,
                        ],
                      ),
                    );
                  },
                );
              },
              child: _image == null
                  ? Align(
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 90,
                        backgroundImage: NetworkImage(_profileimage == null
                            ? "https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o="
                            : _profileimage!),
                        child: const Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.purple,
                              child: Icon(Icons.edit),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Align(
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 90,
                        backgroundImage: FileImage(_image!),
                      ),
                    ),
            ),
            kheight20,
            TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"))
              ],
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.name,
              controller: _nameController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  hintStyle: const TextStyle(color: Colors.white),
                  fillColor: Colors.black,
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(5)),
                  hintText: "Name"),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: ((value) => value == null || value.isEmpty
                  ? "Please enter your name"
                  : null),
            ),
            kHeight15,
            _email != null
                ? Container(
                    padding: const EdgeInsets.only(left: 12),
                    alignment: Alignment.centerLeft,
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      _email!,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )
                : TextFormField(
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        hintStyle: const TextStyle(color: Colors.white),
                        fillColor: Colors.black,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(5)),
                        hintText: "Email"),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? "Enter a valid mail"
                            : null,
                  ),
            kHeight,
            _mobile == null
                ? TextFormField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    controller: _numberController,
                    decoration: InputDecoration(
                        prefixIcon: Container(
                          // alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(
                              right: 2, left: 8, bottom: 3),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                width: 30,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://upload.wikimedia.org/wikipedia/en/thumb/4/41/Flag_of_India.svg/1200px-Flag_of_India.svg.png"))),
                              ),
                              const Text(
                                "  +91",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        hintStyle: const TextStyle(color: Colors.white),
                        fillColor: Colors.black,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(5)),
                        hintText: "Mobile number"),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: ((value) => value == null || value.length < 10
                        ? "Enter a valid mobile number"
                        : null),
                  )
                : Container(
                    padding: const EdgeInsets.only(left: 12),
                    alignment: Alignment.centerLeft,
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          height: 40,
                          width: 30,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://upload.wikimedia.org/wikipedia/en/thumb/4/41/Flag_of_India.svg/1200px-Flag_of_India.svg.png"))),
                        ),
                        Text(
                          _mobile!,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),

            kHeight15,
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black,
                  border: Border.all(color: Colors.white)),
              child: ValueListenableBuilder(
                valueListenable: selectedGenderNotifier,
                builder: (context, value, child) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: DropdownButtonFormField(
                        borderRadius: BorderRadius.circular(10),
                        iconEnabledColor: Colors.white,
                        dropdownColor: Colors.purple,
                        //   hint: Text('Please choose a location'),
                        value: value,
                        items: _genders
                            .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16))))
                            .toList(),
                        onChanged: (newValue) {
                          selectedGenderNotifier.value = newValue!;
                        }),
                  );
                },
              ),
            ),

            kHeight15, //Dataofbirth
            GestureDetector(
              onTap: () async {
                final selectedDateTemp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    //  DateTime.now().subtract(const Duration(days: 8000)),
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 30000)),
                    lastDate: DateTime.now());
                if (selectedDateTemp == null) {
                  return;
                } else {
                  var dateTime = DateTime.parse(selectedDateTemp.toString());

                  var formate1 =
                      "${dateTime.year}-${dateTime.month}-${dateTime.day}";
                  selectedDateNotifier.value = formate1;
                }
              },
              child: Container(
                  height: 60,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black,
                      border: Border.all(color: Colors.white)),
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Row(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: selectedDateNotifier,
                          builder: (context, value, child) {
                            return Text(
                              value,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            );
                          },
                        ),
                        kWidth5,
                        const Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                          size: 18,
                        )
                      ],
                    ),
                  )),
            ),
            kHeight15,
            // Container(
            //   height: 150,
            //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(5),
            //       color: Colors.black,
            //       border: Border.all(color: Colors.white)),
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 5),
            //     child: TextFormField(
            //       maxLines: 8,
            //       controller: _addressController,
            //       style: const TextStyle(color: Colors.white),
            //       decoration: const InputDecoration(
            //           border: InputBorder.none,
            //           hintText: "Address",
            //           hintStyle: TextStyle(color: Colors.white)),
            //       autovalidateMode: AutovalidateMode.onUserInteraction,
            //       validator: ((value) => value == null || value.isEmpty
            //           ? "Please enter your address"
            //           : null),
            //     ),
            //   ),
            // ),
            // Container(
            //   height: 150,
            //  padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 4),
            // decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(5),
            //     // color: Colors.black,
            //     border: Border.all(color: Colors.white)),
            TextFormField(
              maxLines: 6,
              controller: _addressController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(5)),
                  //   border: InputBorder.none,
                  hintText: "Address",
                  hintStyle: const TextStyle(color: Colors.white)),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: ((value) => value == null || value.isEmpty
                  ? "Please enter your address"
                  : null),
            ),

            kheight20,
            kHeight,
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.purple)),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    String date = selectedDateNotifier.value;
                    String name = _nameController.text;
                    String number = _mobile == null
                        ? "+91${_numberController.text}"
                        : _mobile!;
                    String gender = selectedGenderNotifier.value;
                    String email =
                        _email == null ? _emailController.text : _email!;
                    String address = _addressController.text;
                    // if (_image == null) {
                    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //       backgroundColor: Colors.red,
                    //       content: Text('Please upload a profile picture')));
                    //   return;
                    // }
                    if (date == "Select Date of Birth") {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Please select date of birth')));
                      return;
                    } ////////////
                    accountProvider.editProfile(
                        name: name,
                        email: email,
                        mobile: number,
                        gender: gender,
                        dob: date,
                        address: address,
                        context: context,
                        image: _image);
                  }
                },
                child: accountProvider.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      setState(() {
        _image = img;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Image updoaded successfully')));
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
