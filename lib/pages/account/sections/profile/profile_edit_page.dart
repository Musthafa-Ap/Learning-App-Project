import 'package:flutter/material.dart';
import 'package:nuox_project/constants/constants.dart';

import '../../../../widgets/oulined_text_field_widget.dart';

class ProfileEditPage extends StatelessWidget {
  ProfileEditPage({super.key});

  ValueNotifier<String> selectedDateNotifier =
      ValueNotifier("Select Date of Birth");
  ValueNotifier<String> selectedGenderNotifier = ValueNotifier("Male");
  var _genders = ["Male", "Female", "Others"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Edit profile"),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(15),
        children: [
          KHeight,
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 100,
            backgroundImage: NetworkImage(
              "https://www.pngitem.com/pimgs/m/421-4213036_avatar-hd-png-download.png",
            ),
          ),
          KHeight20,
          OutlinedTextFieldWidget(
            hintText: "Name",
          ),
          KHeight15,
          OutlinedTextFieldWidget(
            hintText: "Adress",
          ),
          KHeight15,
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black,
                border: Border.all(color: Colors.white)),
            child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: ValueListenableBuilder(
                  valueListenable: selectedGenderNotifier,
                  builder: (context, value, child) {
                    return DropdownButton(
                        borderRadius: BorderRadius.circular(10),
                        underline: const SizedBox(),
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
                        });
                  },
                )),
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
                    "${dateTime.day}-${dateTime.month}-${dateTime.year}";
                selectedDateNotifier.value = formate1;
              }
            },
            child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                            style: TextStyle(color: Colors.white, fontSize: 16),
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
          KHeight20, KHeight,
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                print(selectedDateNotifier.value);
                print(selectedGenderNotifier.value);
                Navigator.of(context).pop();
              },
              child: Text("Submit"),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple)),
            ),
          ),
        ],
      ),
    );
  }
}
