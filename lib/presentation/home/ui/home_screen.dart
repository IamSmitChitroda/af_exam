import 'package:af_exam/model/contact_model.dart';
import 'package:af_exam/presentation/home/ui/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contents"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () {
            return Stack(
              children: [
                ListView.builder(
                  itemCount: controller.allContact.length,
                  itemBuilder: (context, index) {
                    Logger().i(controller.allContact[index].name);

                    return Card(
                      child: ListTile(
                        title: Text(controller.allContact[index].name.value),
                        subtitle:
                            Text(controller.allContact[index].number.value),
                      ),
                    );
                  },
                ),
                controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final TextEditingController nameController = TextEditingController();
          final TextEditingController numberController =
              TextEditingController();
          final GlobalKey<FormState> formKey = GlobalKey<FormState>();

          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Enter Details'),
                content: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(labelText: 'Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: numberController,
                        decoration: const InputDecoration(labelText: 'Number'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your number';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.of(context).pop();

                        controller.addContact(
                          contact: ContactModel(
                            id: "".obs,
                            name: nameController.text.obs,
                            number: numberController.text.obs,
                          ),
                        );
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              );
            },
          );
        },
        label: const Text("Add"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
