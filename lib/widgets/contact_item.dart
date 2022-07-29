import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  const ContactItem(
      {Key? key,
      required this.fullName,
      required this.phoneNumber,
      required this.onDeleteTap,
      required this.onUpdateTap})
      : super(key: key);

  final String fullName;
  final String phoneNumber;
  final VoidCallback onDeleteTap;
  final VoidCallback onUpdateTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 5,
              blurRadius: 5,
              offset: const Offset(1, 3),
            ),
          ]),
      child: Column(
        children: [
          ListTile(
            title: Text(fullName),
            subtitle: Text(phoneNumber),
            trailing: IconButton(
              onPressed: onDeleteTap,
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: onUpdateTap,
                  child: Row(
                    children: const [
                      Text("Update"),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.edit,
                      )
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }
}
