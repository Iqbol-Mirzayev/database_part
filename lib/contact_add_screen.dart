import 'package:flutter/material.dart';
import 'package:project1/db/cached_contact.dart';
import 'package:project1/db/local_database.dart';
import 'package:project1/utils/utility_functions.dart';

class ContactAddScreen extends StatefulWidget {
  const ContactAddScreen({Key? key, required this.listenerCallBack})
      : super(key: key);
  final ValueChanged<bool> listenerCallBack;

  @override
  State<ContactAddScreen> createState() => _ContactAddScreenState();
}

class _ContactAddScreenState extends State<ContactAddScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Contact"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                keyboardType: TextInputType.text,
                controller: fullNameController,
                decoration: const InputDecoration(hintText: "Write Full Name"),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(hintText: "Write Phone"),
              ),
              const SizedBox(height: 30),
              TextButton(
                  onPressed: () async {
                    String fullName = fullNameController.text;
                    String phoneNumber = phoneController.text;
                    if (fullName.length < 3) {
                      UtilityFunctions.getMyToast(
                          message: "Fullname must be\n minimum 4 symbols");
                    } else if (phoneNumber.length > 12) {
                      UtilityFunctions.getMyToast(
                          message: "Wrong phone number");
                    } else {
                      LocalDatabase.insertCachedContact(CachedContact(
                          fullName: fullName, phone: phoneNumber));
                          widget.listenerCallBack.call(true);
                      Navigator.of(context).pop();
                    }
                    
                  },
                  child: Row(
                    children: const [
                      Text("Add contact"),
                      SizedBox(width: 10),
                      Icon(Icons.add_box)
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
