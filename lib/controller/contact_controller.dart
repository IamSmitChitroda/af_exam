import 'package:af_exam/model/contact_model.dart';
import 'package:get/get.dart';
import '../services/db_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<Contact> contacts = <Contact>[].obs;
  final dbService = DBService();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadContacts();
  }

  Future<void> loadContacts() async {
    contacts.value = await dbService.getContacts();
  }

  Future<void> addContact(Contact contact) async {
    await dbService.insertContact(contact);
    loadContacts();
  }

  Future<void> updateContact(Contact contact) async {
    await dbService.updateContact(contact);
    loadContacts();
  }

  Future<void> deleteContact(int id) async {
    await dbService.deleteContact(id);
    loadContacts();
  }

  Future<void> backupContact() async {
    isLoading(true);
    List ooo = contacts.map((element) => element.toMap()).toList();

    for (int i = 0; i < ooo.length; i++) {
      await firestore.collection('contacts').doc().set(ooo[i]);
    }
    isLoading(true);
  }
}
