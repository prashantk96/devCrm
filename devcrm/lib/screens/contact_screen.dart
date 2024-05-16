import 'package:devcrm/controller/contact_controller.dart';
import 'package:devcrm/defaults/appbar.dart';
import 'package:devcrm/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsScreen extends StatelessWidget {
  final ContactController contactController = Get.put(ContactController());

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController companyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault().appBarDefault(context),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: contactController.contacts.length,
                itemBuilder: (context, index) {
                  var contact = contactController.contacts[index];
                  return ListTile(
                    leading: Icon(Icons.person_3),
                    title: Text(contact.name),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (contact.email != null &&
                                contact.email.isNotEmpty) {
                              _launchMail(contact.email);
                            } else {
                              // Handle the case where the phone number is null or empty
                              print('email is null or empty');
                            }
                          },
                          child: Text('email : ${contact.email}'),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (contact.phone != null &&
                                contact.phone.isNotEmpty) {
                              _launchDialPad(contact.phone);
                            } else {
                              // Handle the case where the phone number is null or empty
                              print('Phone number is null or empty');
                            }
                          },
                          child: Text('pnone : ${contact.phone}'),
                        ),
                        Text('company : ${contact.company}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _showEditContactDialog(context, contact);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteContact(contact);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                _showAddContactDialog(context);
              },
              child: Text('Add Contact'),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Contact'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: numberController,
                decoration: InputDecoration(labelText: 'Mobile Number'),
              ),
              TextField(
                controller: companyController,
                decoration: InputDecoration(labelText: 'Company'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                print(numberController.text);
                contactController.addContact(
                    nameController.text,
                    emailController.text,
                    numberController.text,
                    companyController.text);
                Get.back();
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showEditContactDialog(BuildContext context, Contact contact) {
    // Set text controllers with the contact data
    nameController.text = contact.name;
    emailController.text = contact.email;
    numberController.text = contact.phone;
    companyController.text = contact.company;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Contact'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: numberController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              TextField(
                controller: companyController,
                decoration: InputDecoration(labelText: 'Company'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                contactController.editContact(
                  contact.id,
                  nameController.text,
                  emailController.text,
                  numberController.text,
                  companyController.text,
                );
                Get.back();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _deleteContact(Contact contact) {
    contactController.deleteContact(contact.id);
  }

  _launchDialPad(String phoneNumber) async {
    Uri url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(Uri(scheme: 'tel', path: phoneNumber))) {
      await launchUrl(Uri(scheme: 'tel', path: phoneNumber));
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchMail(String email) async {
    if (await canLaunchUrl(Uri(scheme: 'mailto', path: email))) {
      await launchUrl(Uri(scheme: 'mailto', path: email));
    } else {
      throw 'Could not launch mail';
    }
  }
}
