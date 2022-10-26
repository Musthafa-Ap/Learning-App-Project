import 'package:flutter/material.dart';
import 'package:nuox_project/constants/constants.dart';

import '../../../../widgets/oulined_text_field_widget.dart';

ValueNotifier<String> selectedGender = ValueNotifier("");

class ProfileEditPage extends StatelessWidget {
  ProfileEditPage({super.key});

  ValueNotifier<String> _selectedDate = ValueNotifier("Select Date of Birth");

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
          OutlinedTextFieldWidget(
            hintText: "Name",
          ),
          KHeight15,
          OutlinedTextFieldWidget(
            hintText: "Adress",
          ),
          KHeight15,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GenderSection(text: "Male"),
              GenderSection(text: "Female"),
              GenderSection(text: "Others"),
            ],
          ),

          KHeight15, //Dataofbirth
          ValueListenableBuilder(
            valueListenable: _selectedDate,
            builder: (context, value, child) {
              return TextButton.icon(
                onPressed: () async {
                  final selectedDateTemp = await showDatePicker(
                      context: context,
                      initialDate:
                          DateTime.now().subtract(Duration(days: 10000)),
                      firstDate: DateTime.now().subtract(Duration(days: 30000)),
                      lastDate: DateTime.now());
                  if (selectedDateTemp == null) {
                    return;
                  } else {
                    var dateTime = DateTime.parse(selectedDateTemp.toString());

                    var formate1 =
                        "${dateTime.day}-${dateTime.month}-${dateTime.year}";
                    _selectedDate.value = formate1;
                  }
                },
                icon: const Icon(
                  Icons.calendar_month,
                  color: Colors.green,
                  size: 28,
                ),
                label: Text(
                  value,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            },
          ),
          KHeight20, KHeight,
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {
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

class GenderSection extends StatelessWidget {
  final String text;
  GenderSection({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: selectedGender,
        builder: (context, newGender, _) {
          return Row(
            children: [
              Radio(
                  fillColor:
                      MaterialStateColor.resolveWith((states) => Colors.white),
                  value: text,
                  groupValue: newGender,
                  onChanged: (newValue) {
                    selectedGender.value = newValue!;
                  }),
              Text(
                text,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          );
        });
  }
}
