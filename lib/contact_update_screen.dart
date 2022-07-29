import 'package:flutter/material.dart';
import 'package:project1/db/cached_contact.dart';
import 'package:project1/db/local_database.dart';
import 'package:project1/utils/utility_functions.dart';

class ContactUpdateScreen extends StatefulWidget {
  const ContactUpdateScreen(
      {Key? key,
      required this.id,
      required this.initialFullName,
      required this.initialPhone,
      required this.listenerCallBack})
      : super(
          key: key,
        );
  final ValueChanged<bool> listenerCallBack;
  final String initialFullName;
  final String initialPhone;
  final int id;
  @override
  State<ContactUpdateScreen> createState() => _ContactUpdateScreenState();
}

class _ContactUpdateScreenState extends State<ContactUpdateScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void _init() async {
    fullNameController.text = widget.initialFullName;
    phoneController.text = widget.initialPhone;
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Contact"),
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
                    if (phoneController.text.length == 12 &&
                        fullNameController.text.length > 3) {
                      CachedContact updatableContact = CachedContact(
                          fullName: fullNameController.text,
                          phone: phoneController.text,
                          id: widget.id);
                      await LocalDatabase.updateContact(updatableContact);
                      widget.listenerCallBack.call(true);
                      UtilityFunctions.getMyToast(
                          message: "Successfully updated");
                      Navigator.of(context).pop();
                    } else if (phoneController.text.length > 12 || phoneController.text.length < 12) {
                      UtilityFunctions.getMyToast(message: "Wrong !!!");
                    } else {
                      UtilityFunctions.getMyToast(message: "Dang !!!");
                    }
                  },
                  child: Row(
                    children: const [
                      Text("Update contact"),
                      SizedBox(width: 10),
                      Icon(Icons.edit)
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
