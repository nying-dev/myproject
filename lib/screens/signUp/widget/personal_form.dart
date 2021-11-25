import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:myproject/constants.dart';
import 'package:myproject/widget/custom_button.dart';
import 'package:myproject/widget/custom_input.dart';
import 'package:myproject/service/firestore.dart';
import 'package:group_button/group_button.dart';

enum gender { male, female }

class PersonalFormPage extends StatefulWidget {
  final _PersonalFormState _personalFormState = _PersonalFormState();

  @override
  _PersonalFormState createState() => _PersonalFormState();
  void sendIt(bool sent) {
    if (sent) {
      _personalFormState._submitForm();
    }
  }
}

class _PersonalFormState extends State<PersonalFormPage> {
  // ignore: non_constant_identifier_names
  static String f_name;
  static String l_name;
  static String birthday;
  static String province;
  static String municipality;
  static String baranggay;
  static List<String> diatary = [];
  static String gendr;
  static gender _gender = gender.male;
  bool alergen = false;
  List<String> groupBtn = const [
    "Eggs",
    "Nuts",
    "Shellfish",
    "Tomato",
    "Fish",
    "Milk",
    "Soy"
  ];
  TextEditingController dateinput = TextEditingController();
  //text editing controller for text field
  String _dateText;

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Row(children: [
            Flexible(
                child: CustomInput(
                    hintText: 'Last name',
                    isPasswordField: false,
                    onChanged: (value) {
                      setState(() {
                        l_name = value ?? '';
                      });
                    },
                    onSubmitted: (value) {
                      l_name = value;
                    },
                    focusNode: FocusNode(),
                    textInputAction: TextInputAction.done)),
            Flexible(
                child: CustomInput(
                    hintText: 'First name',
                    isPasswordField: false,
                    onChanged: (value) {
                      setState(() {
                        f_name = value ?? '';
                      });
                    },
                    onSubmitted: (value) {
                      f_name = value;
                    },
                    focusNode: FocusNode(),
                    textInputAction: TextInputAction.done)),
          ]),
          Row(
            children: [
              Flexible(
                child: ListTile(
                  title: const Text('Male'),
                  leading: Radio<gender>(
                    value: gender.male,
                    groupValue: _gender,
                    onChanged: (gender value) {
                      setState(() {
                        _gender = value;
                        gendr = "male";
                      });
                    },
                  ),
                ),
              ),
              Flexible(
                child: ListTile(
                  title: const Text('Female'),
                  leading: Radio<gender>(
                    value: gender.female,
                    groupValue: _gender,
                    onChanged: (gender value) {
                      setState(() {
                        _gender = value;
                        gendr = "female";
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          Container(
              margin: EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 24.0,
              ),
              child: TextField(
                controller: dateinput, //editing controller of this TextField
                decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: _dateText //label text of field
                    ),
                readOnly:
                    true, //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(
                          1980), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));
                  if (pickedDate != null) {
                    //ckedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    birthday = formattedDate;
                    //formatted date output using intl package =>  2021-03-16
                    //you can implement different kind of Date Format here according to your requirement
                    setState(() {
                      dateinput.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              )),
          Icon(Icons.home),
          CustomInput(
            hintText: 'Province',
            isPasswordField: false,
            onChanged: (value) {
              province = value;
            },
            onSubmitted: (value) {},
            focusNode: FocusNode(),
            textInputAction: TextInputAction.done,
          ),
          CustomInput(
            hintText: 'City/Municipality',
            isPasswordField: false,
            onChanged: (value) {
              municipality = value;
            },
            onSubmitted: (value) {},
            focusNode: FocusNode(),
            textInputAction: TextInputAction.done,
          ),
          CustomInput(
              hintText: 'Barangay',
              isPasswordField: false,
              onChanged: (value) {
                baranggay = value;
              },
              onSubmitted: (value) {},
              focusNode: FocusNode(),
              textInputAction: TextInputAction.done),
          Center(
              child: Text("Select diatary restriction",
                  style: Constants.kDescriptionStyle)),
          CustomBtn(
              textBtn: "Diabetic",
              onPressed: () {
                if (!diatary.contains('diabetic')) {
                  diatary.add('diabetic');
                }
              },
              onDoubleTap: () {
                if (diatary.contains('diabetic')) {
                  diatary.remove('diabetic');
                }
              },
              outlinedBtn: false,
              isLoading: false),
          CustomBtn(
              textBtn: "Food Allergen or Intolerance",
              onPressed: () {
                setState(() {
                  if (!alergen) {
                    alergen = true;
                  } else {
                    alergen = false;
                  }
                });
              },
              outlinedBtn: true,
              isLoading: false),
          Visibility(
              visible: alergen,
              child: GroupButton(
                spacing: 5,
                isRadio: false,
                direction: Axis.horizontal,
                onSelected: (index, isSelected) {
                  print(
                      '${groupBtn[index]} button is ${isSelected ? 'selected' : 'unselected'}');
                  if (!diatary.contains('${groupBtn[index]}')) {
                    if (isSelected) {
                      diatary.add('${groupBtn[index]}');
                    } else {
                      diatary.remove('${groupBtn[index]}');
                    }
                  }

                  print(diatary);
                },
                buttons: groupBtn,
                selectedButtons: const [0, 1],

                /// [List<int>] after 2.2.1 version
                selectedTextStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.green,
                ),
                unselectedTextStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                selectedColor: Colors.white,
                unselectedColor: Colors.grey[300],
                selectedBorderColor: Colors.green,
                unselectedBorderColor: Colors.grey[500],
                borderRadius: BorderRadius.circular(5.0),
                selectedShadow: <BoxShadow>[
                  BoxShadow(color: Colors.transparent)
                ],
                unselectedShadow: <BoxShadow>[
                  BoxShadow(color: Colors.transparent)
                ],
              )),
        ],
      ),
    );
  }

  Future _submitForm() async {
    FirestoreUser firestoreUser = FirestoreUser();
    // ignore: avoid_print
    firestoreUser.UserInfo(
        lname: l_name,
        fname: f_name,
        gender: gendr,
        birthdate: birthday,
        province: province,
        municipality: municipality,
        baragay: baranggay,
        medical: diatary);
  }
}

class FamilyPage extends StatefulWidget {
  @override
  _FamilyPage createState() => _FamilyPage();
}

class _FamilyPage extends State<FamilyPage> {
  gender _human = gender.male;
  bool alergen = false;
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Row(children: [
          Flexible(
              child: CustomInput(
                  hintText: 'Last name',
                  isPasswordField: false,
                  onChanged: (value) {},
                  onSubmitted: (value) {},
                  focusNode: FocusNode(),
                  textInputAction: TextInputAction.next)),
          Flexible(
            child: CustomInput(
                hintText: 'First name',
                isPasswordField: false,
                onChanged: (value) {},
                onSubmitted: (value) {},
                focusNode: FocusNode(),
                textInputAction: TextInputAction.next),
          )
        ]),
        Row(
          children: [
            Flexible(
              child: ListTile(
                title: const Text('Male'),
                leading: Radio<gender>(
                  value: gender.male,
                  groupValue: _human,
                  onChanged: (gender value) {
                    setState(() {
                      _human = value;
                    });
                  },
                ),
              ),
            ),
            Flexible(
              child: ListTile(
                title: const Text('Female'),
                leading: Radio<gender>(
                  value: gender.female,
                  groupValue: _human,
                  onChanged: (gender value) {
                    setState(() {
                      _human = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        Icon(Icons.home),
        CustomInput(
          hintText: 'Province',
          isPasswordField: false,
          onChanged: (value) {},
          onSubmitted: (value) {},
          focusNode: FocusNode(),
          textInputAction: TextInputAction.next,
        ),
        CustomInput(
          hintText: 'City/Municipality',
          isPasswordField: false,
          onChanged: (value) {},
          onSubmitted: (value) {},
          focusNode: FocusNode(),
          textInputAction: TextInputAction.next,
        ),
        CustomInput(
          hintText: 'Barangay',
          isPasswordField: false,
          onChanged: (value) {},
          onSubmitted: (value) {},
          focusNode: FocusNode(),
          textInputAction: TextInputAction.next,
        ),
        Center(
            child: Text("Select diatary restriction",
                style: Constants.kDescriptionStyle)),
        CustomBtn(
            textBtn: "Diabetic",
            onPressed: () {},
            outlinedBtn: false,
            isLoading: false),
        CustomBtn(
            textBtn: "Food Allergen or Intolerance",
            onPressed: () {
              setState(() {
                if (!alergen) {
                  alergen = true;
                } else {
                  alergen = false;
                }
              });
            },
            outlinedBtn: true,
            isLoading: false),
        Visibility(
            visible: alergen,
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: CustomBtn(
                          textBtn: "Eggs", onPressed: () {}, isLoading: false),
                    ),
                    Flexible(
                      child: CustomBtn(
                          textBtn: "Nuts", onPressed: () {}, isLoading: false),
                    ),
                    Flexible(
                      child: CustomBtn(
                          textBtn: "Shell Fish",
                          onPressed: () {},
                          isLoading: false),
                    ),
                    Flexible(
                      child: CustomBtn(
                          textBtn: "Tomato",
                          onPressed: () {},
                          isLoading: false),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: CustomBtn(
                          textBtn: "Fish", onPressed: () {}, isLoading: false),
                    ),
                    Flexible(
                      child: CustomBtn(
                          textBtn: "Milk", onPressed: () {}, isLoading: false),
                    ),
                    Flexible(
                      child: CustomBtn(
                          textBtn: "Soy", onPressed: () {}, isLoading: false),
                    ),
                  ],
                )
              ],
            ))
      ],
    );
  }
}
