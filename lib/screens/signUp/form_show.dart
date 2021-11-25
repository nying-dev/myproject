import 'package:flutter/material.dart';
import 'package:myproject/screens/signUp/widget/personal_form.dart';
import 'widget/tabs_button.dart';

class FormShow extends StatefulWidget {
  @override
  _FormShowState createState() => _FormShowState();
}

class _FormShowState extends State<FormShow> {
  PageController _tabsPageController = PageController();
  int _selectedTab = 0;
  bool btnVisibilty = false;
  PersonalFormPage personalFormPage = PersonalFormPage();

  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TopTabs(selectedTab: _selectedTab, tabPressed: (num) {}),
          Container(
            child: Expanded(
                child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabsPageController,
              onPageChanged: (num) {
                setState(() {
                  _selectedTab = num;
                });
              },
              children: [
                Center(child: PersonalFormPage()),
                Center(child: FamilyPage()),
              ],
            )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            verticalDirection: VerticalDirection.up,
            children: [
              Visibility(
                  visible: btnVisibilty,
                  child: Container(
                      child: BtnNext(
                          onPressed: () {
                            if (_selectedTab > 0) {
                              _selectedTab--;
                              if (_selectedTab == 0) {
                                btnVisibilty = false;
                              }
                              _tabsPageController.animateToPage(_selectedTab,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInCubic);
                            }
                            print(_selectedTab);
                          },
                          textBtn: "Back"))),
              BtnNext(
                  onPressed: () {
                    if (_selectedTab < 1) {
                      _selectedTab++;

                      if (_selectedTab > 0) {
                        btnVisibilty = true;
                      }
                    } else if (_selectedTab == 1) {
                      personalFormPage.sendIt(true);
                      print("send");
                    }
                    print(_selectedTab);
                    _tabsPageController.animateToPage(_selectedTab,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInCubic);
                  },
                  textBtn: _selectedTab == 1 ? "Done" : "Next"),
            ],
          )
        ],
      ),
    );
  }
}
