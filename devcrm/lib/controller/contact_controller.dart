import 'dart:convert';

import 'package:devcrm/models/contact_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ContactController extends GetxController {
  RxList<Contact> contacts = <Contact>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchContacts();
  }

  Future<void> fetchContacts() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.1.2:3000/api/contacts'));
      if (response.statusCode == 200) {
        final List<dynamic> parsedContacts = jsonDecode(response.body);
        contacts.assignAll(
            parsedContacts.map((contact) => Contact.fromJson(contact)));
      } else {
        throw Exception('Failed to fetch contacts');
      }
    } catch (e) {
      print('Error fetching contacts: $e');
    }
  }

  Future<void> addContact(
      String name, String email, String number, String company) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.2:3000/api/contacts'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'email': email,
          'phone': number,
          'company': company,
        }),
      );

      if (response.statusCode == 200) {
        fetchContacts();
      } else {
        throw Exception('Failed to add contact');
      }
    } catch (e) {
      print('Error adding contact: $e');
    }
  }

  Future<void> editContact(
      int id, String name, String email, String number, String company) async {
    try {
      final response = await http.put(
        Uri.parse('http://192.168.1.2:3000/api/contacts/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'email': email,
          'phone': number,
          'company': company,
        }),
      );

      if (response.statusCode == 200) {
        fetchContacts();
      } else {
        throw Exception('Failed to edit contact');
      }
    } catch (e) {
      print('Error editing contact: $e');
    }
  }

  Future<void> deleteContact(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('http://192.168.1.2:3000/api/contacts/$id'),
      );

      if (response.statusCode == 200) {
        fetchContacts();
      } else {
        throw Exception('Failed to delete contact');
      }
    } catch (e) {
      print('Error deleting contact: $e');
    }
  }
}
