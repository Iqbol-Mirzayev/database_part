import 'package:flutter/material.dart';
import 'package:project1/db/local_database.dart';
import 'package:project1/widgets/contact_item.dart';

import 'contact_add_screen.dart';
import 'contact_update_screen.dart';
import 'db/cached_contact.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<CachedContact> cachedContacts = [
    CachedContact(fullName: "fullName", phone: "86556656556665")
  ];

//TODO 3 Read from database
  void _init() async {
    cachedContacts = await LocalDatabase.getAllContacts();
    setState(() {});
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
        title: const Text("My Contacts"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext con) {
                      //TODO 5 Add new contact item  --- Success
                      return ContactAddScreen(
                        listenerCallBack: (bool value) {
                          if (value == true) {
                            _init();
                          }
                        },
                      );
                    },
                  ),
                );
              },
              icon: const Icon(
                Icons.add,
                size: 30,
              )),
          const SizedBox(width: 20),
          TextButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Are you sure"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () async {
                          await LocalDatabase.deleteAllCachedUsers();
                          _init();
                          Navigator.of(context).pop();
                        },
                        child: Text("Ok"),
                      ),
                    ],
                  ),
                );
              },
              child: const Text(
                "Clear All",
                style: TextStyle(fontSize: 16, color: Colors.white),
              )),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: ListView.builder(
          itemCount: cachedContacts.length,
          itemBuilder: (BuildContext context, index) {
            return ContactItem(
              //TODO 6 Delete contact item
              onDeleteTap: () async {
                LocalDatabase.deleteById(cachedContacts[index].id!);
                _init();
              },
              fullName: cachedContacts[index].fullName,
              phoneNumber: cachedContacts[index].phone,
              onUpdateTap: () {
                //TODO 4 Update contact item
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext con) {
                      return ContactUpdateScreen(
                        id:cachedContacts[index].id!,
                        initialFullName: cachedContacts[index].fullName,
                        initialPhone: cachedContacts[index].phone,
                        listenerCallBack: (bool value) {
                          if (value) {
                            _init();
                          }
                        },
                      );
                    },
                  ),
                );
              },
            );
          }),
    );
  }
}
