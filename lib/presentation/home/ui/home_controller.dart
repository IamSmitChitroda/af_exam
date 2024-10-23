import 'package:af_exam/model/contact_model.dart';
import 'package:get/get.dart';

import '../../../services/data_base_services/sqf_services.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<ContactModel> allContact = <ContactModel>[].obs;
  @override
  Future<void> onInit() async {
    await _initDatabase();
    await _getContact();
    super.onInit();
  }

  Future<void> _initDatabase() async {
    isLoading(true);
    await SqfServices.instance.initDatabase();
    isLoading(false);
  }

  Future<void> _getContact() async {
    isLoading(true);
    allContact(await SqfServices.instance.getAllLoginData());
    isLoading(false);
  }

  Future<void> addContact({required ContactModel contact}) async {
    isLoading(true);
    SqfServices.instance.addContact(contact: contact);
    await _getContact();
    isLoading(false);
  }
}
