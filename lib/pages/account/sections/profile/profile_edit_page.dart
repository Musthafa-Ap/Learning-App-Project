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
  ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  ValueNotifier<String> selectedDateNotifier =
      ValueNotifier("Select Date of Birth");
  final _formKey = GlobalKey<FormState>();
  ValueNotifier<String> selectedGenderNotifier = ValueNotifier("Male");
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  var _genders = ["Male", "Female", "Others"];
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
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    name = _sharedPref.getString("name");
    String? email = _sharedPref.getString("email");
    String? _nmbr = _sharedPref.getString("number");
    _address = _sharedPref.getString("address");
    _dob = _sharedPref.getString("dob");
    _gender = _sharedPref.getString("gender");
    _profileimage = _sharedPref.getString("image");
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

  TextEditingController _emailController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final accountProvider =
        Provider.of<AccountProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Edit profile"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(15),
          children: [
            KHeight,
            GestureDetector(
              onTap: () {
                _pickImage();
              },
              child: _image == null
                  ? CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 90,
                      backgroundImage: NetworkImage(_profileimage == null
                          ? "https://cdn2.vectorstock.com/i/1000x1000/20/76/man-avatar-profile-vector-21372076.jpg"
                          : _profileimage!),
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 90,
                      backgroundImage: FileImage(_image!),
                    ),
            ),
            KHeight20,
            TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"))
              ],
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.name,
              controller: _nameController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  hintStyle: TextStyle(color: Colors.white),
                  fillColor: Colors.black,
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(5)),
                  hintText: "Name"),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: ((value) => value == null || value.isEmpty
                  ? "Please enter your name"
                  : null),
            ),
            // Container(
            //   height: 60,
            //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(5),
            //       color: Colors.black,
            //       border: Border.all(color: Colors.white)),
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 5),
            //     child: TextField(
            //       controller: _nameController,
            //       style: const TextStyle(color: Colors.white),
            //       decoration: const InputDecoration(
            //           border: InputBorder.none,
            //           hintText: "Name",
            //           hintStyle: TextStyle(color: Colors.white)),
            //     ),
            //   ),
            // ),
            KHeight15,
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
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )
                // : Container(
                //     height: 50,
                //     padding:
                //         const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(5),
                //         color: Colors.black,
                //         border: Border.all(color: Colors.white)),
                //     child: Padding(
                //       padding: const EdgeInsets.only(left: 5),
                //       child: TextFormField(
                //         controller: _nameController,
                //         style: const TextStyle(color: Colors.white),
                //         decoration: const InputDecoration(
                //             border: InputBorder.none,
                //             hintText: "Email",
                //             hintStyle: TextStyle(color: Colors.white)),
                //         autovalidateMode: AutovalidateMode.onUserInteraction,
                //         validator: (email) =>
                //             email != null && !EmailValidator.validate(email)
                //                 ? "Enter a valid mail"
                //                 : null,
                //       ),
                //     ),
                //   ),
                : TextFormField(
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        hintStyle: TextStyle(color: Colors.white),
                        fillColor: Colors.black,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(5)),
                        hintText: "Email"),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? "Enter a valid mail"
                            : null,
                  ),
            KHeight,
            _mobile == null
                ? TextFormField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    controller: _numberController,
                    decoration: InputDecoration(
                        prefixIcon: Container(
                          // alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(top: 11, left: 1),
                          child: Text(
                            "  +91",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        hintStyle: TextStyle(color: Colors.white),
                        fillColor: Colors.black,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
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
                    child: Text(
                      _mobile!,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),

            KHeight15,
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

            KHeight15, //Dataofbirth
            GestureDetector(
              onTap: () async {
                final selectedDateTemp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().subtract(Duration(days: 10000)),
                    firstDate: DateTime.now().subtract(Duration(days: 30000)),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            );
                          },
                        ),
                        KWidth5,
                        Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                          size: 18,
                        )
                      ],
                    ),
                  )),
            ),
            KHeight15,
            Container(
              height: 150,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black,
                  border: Border.all(color: Colors.white)),
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: TextFormField(
                  maxLines: 8,
                  controller: _addressController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Address",
                      hintStyle: TextStyle(color: Colors.white)),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: ((value) => value == null || value.isEmpty
                      ? "Please enter your address"
                      : null),
                ),
              ),
            ),
            KHeight20, KHeight,
            SizedBox(
              height: 50,
              child: ElevatedButton(
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
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                    : const Text("Submit"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.purple)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      String path = image.path;
      File? img = File(image.path);
      setState(() {
        _image = img;
        // SharedPreferences _sharedpref = await SharedPreferences.getInstance();
        // _sharedpref.setString("image", path);
        // print(_image);
        print(_image!.path);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text('Image updoaded successfully')));

        //  Navigator.pop(context);
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
