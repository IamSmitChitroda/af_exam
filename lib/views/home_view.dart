import 'package:af_exam/controller/contact_controller.dart';
import 'package:af_exam/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_edit_contact_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final contactController = Get.put(ContactController());
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        actions: [
          IconButton(
            icon: Icon(themeController.isDarkMode.value
                ? Icons.light_mode
                : Icons.dark_mode),
            onPressed: themeController.toggleTheme,
          ),
        ],
      ),
      body: Obx(
        () {
          if (contactController.contacts.isEmpty) {
            return const Center(child: Text('No Contacts Found'));
          }
          return Stack(
            children: [
              ListView.builder(
                itemCount: contactController.contacts.length,
                itemBuilder: (context, index) {
                  final contact = contactController.contacts[index];
                  return ListTile(
                    title: Text(contact.name),
                    subtitle: Text(contact.number),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => Get.to(
                              () => AddEditContactView(contact: contact)),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () =>
                              contactController.deleteContact(contact.id!),
                        ),
                      ],
                    ),
                  );
                },
              ),
              if (contactController.isLoading.value)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddEditContactView()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
