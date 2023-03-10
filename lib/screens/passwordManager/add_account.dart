import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'components/account_action.dart';
import 'components/account_logo.dart';
import 'components/account_textfield.dart';
import 'components/account_title.dart';

class AddAccountScreen extends StatefulWidget {
  const AddAccountScreen(
      {Key? key, /*this.model*/ this.id, this.isShowData = false})
      : super(key: key);
  //final RecordModel? model;
  final bool isShowData;
  final String? id;

  @override
  State<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  late String selectedValue;
  late TextEditingController _nameController;
  late TextEditingController _userNameController;
  late TextEditingController _passwordController;
  late TextEditingController _webSiteController;
  late TextEditingController _tagController;
  List<String> tags = [];
  late bool _isShowData;

  @override
  void initState() {
    selectedValue = accountsList[0].title;
    _userNameController = TextEditingController();
    _nameController = TextEditingController();
    _webSiteController = TextEditingController();
    _passwordController = TextEditingController();
    _tagController = TextEditingController();
    _isShowData = widget.isShowData;
    //getModelData();
    super.initState();
  }

  @override
  void dispose() {
    _userNameController.clear();
    _nameController.clear();
    _webSiteController.clear();
    _passwordController.clear();
    _tagController.clear();
    super.dispose();
  }

  showMessage({required String text, isError = true}) {
    final snackBar = SnackBar(
      backgroundColor: isError ? Colors.red : Colors.green,
      content: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // _saveRecord() {
  //   String? userUID = FirebaseAuth.instance.currentUser?.uid;
  //   if (userUID != null) {
  //     DBHelper.insertRecord(
  //       uid: userUID,
  //       logoValue: selectedValue,
  //       name: _nameController.text.trim(),
  //       userName: _userNameController.text.trim(),
  //       password: _passwordController.text.trim(),
  //       webSite: _webSiteController.text.trim(),
  //       tags: tags,
  //     );
  //     // Future.delayed(
  //     //     const Duration(milliseconds: 500),
  //     //     (() => Navigator.pushNamedAndRemoveUntil(
  //     //         context, HomeScreen.id, (route) => false)));
  //   } else {
  //     showMessage(text: 'Something wront with User');
  //   }
  // }

  // void getModelData() {
  //   if (widget.model != null) {
  //     setState(() {
  //       _nameController.text = widget.model!.name;
  //       _userNameController.text = widget.model!.username;
  //       _passwordController.text = widget.model!.password;
  //       _webSiteController.text = widget.model!.webSite;
  //       tags.addAll(widget.model!.tag);
  //       selectedValue = widget.model!.logoValue;
  //     });
  //   }
  // }

  // sayWellDone() {
  //   showMessage(text: 'Record removed', isError: false);
  //   Future.delayed(
  //       const Duration(milliseconds: 1000),
  //       (() => Navigator.pushNamedAndRemoveUntil(
  //           context, HomeScreen.id, (route) => false)));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18.0, 24.0, 18.0, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const AccountTitle(
                  title: 'Account:',
                  isPadding: true,
                ),
                _buildDropDownButton(),
                const SizedBox(height: 12.0),
                AccountTextField(
                  controller: _nameController,
                  title: 'Name',
                  hintText: 'Full Name',
                ),
                AccountTextField(
                  controller: _userNameController,
                  title: 'Username(Email)',
                  hintText: 'name@gmail.com',
                ),
                AccountPasswordField(
                  controller: _passwordController,
                  title: 'Password',
                ),
                AccountTextField(
                  controller: _webSiteController,
                  title: 'Website',
                  hintText: 'https://google.com',
                ),
                const SizedBox(height: 12.0),
                _buildTagRow(),
                _buildSaveButton(),
                if (_isShowData) _buildCRUDButton(),
                const SizedBox(height: 18.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildSaveButton() {
    return Row(
      children: [
        Expanded(
            child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFFF77D8E))),
                onPressed: () {
                  if (_nameController.text.isEmpty) {
                    showMessage(text: 'Please, check "Name"!');
                    return;
                  } else if (_userNameController.text.isEmpty) {
                    showMessage(text: 'Please, check "Username"!');
                    return;
                  } else if (_passwordController.text.isEmpty) {
                    showMessage(text: 'Please, check "Password"!');
                    return;
                  } else if (_webSiteController.text.isEmpty) {
                    showMessage(text: 'Please, check "Website"!');
                    return;
                  } else if (tags.isEmpty) {
                    showMessage(text: 'Please, add at least one "Tag"!');
                    return;
                  }
                  // _saveRecord();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    'Save',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        letterSpacing: 1),
                  ),
                )))
      ],
    );
  }

  Column _buildCRUDButton() {
    return Column(
      children: [
        const SizedBox(height: 18.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AccountAction(
              title: 'copy Username',
              iconData: Icons.copy,
              onPressed: () {
                Clipboard.setData(ClipboardData(text: _userNameController.text))
                    .then((_) {
                  showMessage(
                      text: 'Username copied to clipboard', isError: false);
                });
              },
            ),
            AccountAction(
              title: 'copy Password',
              iconData: Icons.copy,
              onPressed: () {
                Clipboard.setData(ClipboardData(text: _passwordController.text))
                    .then((_) {
                  showMessage(
                      text: 'Password copied to clipboard', isError: false);
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AccountAction(
              title: 'login+password',
              iconData: Icons.copy,
              onPressed: () {
                Clipboard.setData(ClipboardData(
                        text:
                            'username: ${_userNameController.text}\npassword: ${_passwordController.text}'))
                    .then((_) {
                  showMessage(
                      text: 'Username and Password copied to clipboard',
                      isError: false);
                });
              },
            ),
            // AccountAction(
            //   title: 'Delete record',
            //   iconData: Icons.delete_outline,
            //   isDelete: true,
            //   onPressed: () {
            //     String? uid = FirebaseAuth.instance.currentUser?.uid;
            //     if (uid != null) {
            //       try {
            //         FirebaseDatabase.instance
            //             .ref()
            //             .child('users/$uid/${widget.id}')
            //             .remove()
            //             .then((value) => sayWellDone());
            //       } catch (e) {
            //         showMessage(text: 'Something wrong: $e');
            //       }
            //     }
            //   },
            // ),
          ],
        ),
      ],
    );
  }

  Column _buildTagRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AccountTitle(
          title: 'Tags',
        ),
        SizedBox(
          height: 36.0,
          child: TextField(
            controller: _tagController,
            onChanged: (text) {
              if (text.contains(',')) {
                List data = text.split(',');
                setState(() {
                  tags.add(data[0]);
                  _tagController.clear();
                });
              }
            },
            decoration: const InputDecoration(
              hintText: 'google, account, gmail ...',
            ),
            style: const TextStyle(color: Colors.black54),
          ),
        ),
        SizedBox(
          height: 50.0,
          child: ListView.builder(
              shrinkWrap: false,
              scrollDirection: Axis.horizontal,
              itemCount: tags.length,
              itemBuilder: ((context, index) => InkWell(
                    onTap: () => setState(() {
                      tags.removeAt(index);
                    }),
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 4.0, 8.0, 4.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          tags[index],
                          style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ))),
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }

  Row _buildDropDownButton() {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
                hint: const Text('Select Account'),
                value: selectedValue,
                itemHeight: 60.0,
                items: accountsList
                    .map((account) => DropdownMenuItem<String>(
                        value: account.title,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(left: 4.0),
                                  height: 48.0,
                                  width: 48.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        12.0,
                                      ),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          offset: Offset(0, 4),
                                          blurRadius: 4.0,
                                          spreadRadius: 0,
                                          color: Colors.black26,
                                        )
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                        SvgPicture.asset(account.accountImage),
                                  )),
                              const SizedBox(width: 12.0),
                              Text(
                                account.title,
                                style: const TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                        )))
                    .toList(),
                onChanged: (newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedValue = newValue;
                    });
                  }
                }),
          ),
        )
      ],
    );
  }
}
