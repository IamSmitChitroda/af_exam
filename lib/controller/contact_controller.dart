import 'package:af_exam/model/contact_model.dart';
import 'package:get/get.dart';
import '../services/db_service.dart';

class ContactController extends GetxController {
  RxList<Contact> contacts = <Contact>[].obs;
  final dbService = DBService();

  @override
  void onInit() {
    super.onInit();
    loadContacts();
  }

  void loadContacts() async {
    contacts.value = await dbService.getContacts();
  }

  void addContact(Contact contact) async {
    await dbService.insertContact(contact);
    loadContacts();
  }

  void updateContact(Contact contact) async {
    await dbService.updateContact(contact);
    loadContacts();
  }

  void deleteContact(int id) async {
    await dbService.deleteContact(id);
    loadContacts();
  }
}
