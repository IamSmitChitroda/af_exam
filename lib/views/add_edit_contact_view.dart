import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/contact_controller.dart';
import '../model/contact_model.dart';

class AddEditContactView extends StatelessWidget {
  final Contact? contact;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  AddEditContactView({super.key, this.contact}) {
    if (contact != null) {
      nameController.text = contact!.name;
      numberController.text = contact!.number;
    }
  }

  @override
  Widget build(BuildContext context) {
    final contactController = Get.find<ContactController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(contact == null ? 'Add Contact' : 'Edit Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: contactController.key,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                textInputAction: TextInputAction.next,
                validator: (value) =>
                    value.toString().trim().isEmpty ? "Enter name" : null,
              ),
              TextFormField(
                controller: numberController,
                decoration: const InputDecoration(labelText: 'Number'),
                keyboardType: TextInputType.phone,
                validator: (value) => value.toString().trim().length != 10
                    ? "Enter valid mobile no. "
                    : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (contactController.key.currentState!.validate()) {
                    if (contact == null) {
                      contactController.addContact(
                        Contact(
                            name: nameController.text,
                            number: numberController.text),
                      );
                    } else {
                      contactController.updateContact(
                        Contact(
                          id: contact!.id,
                          name: nameController.text,
                          number: numberController.text,
                        ),
                      );
                    }
                  }
                  Get.back();
                },
                child: Text(contact == null ? 'Add' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
