import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/common/widgets/error.dart';
import 'package:whatsapp_ui/common/widgets/loader.dart';
import 'package:whatsapp_ui/feature/select_contacts/controller/select_contact_controller.dart';

class SelectContactScreen extends ConsumerWidget {
  static const routeName = '/select-contact';
  const SelectContactScreen({Key? key}) : super(key: key);
  void selectContact(
      {required WidgetRef ref,
      required Contact selectedContact,
      required BuildContext context}) {
    ref
        .read(selectContactControllerProvider)
        .selectContact(selectedContact, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('select contact'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: ref.watch(getContactProvider).when(
            data: (contacts) {
              return ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return InkWell(
                    onTap: () => selectContact(
                        ref: ref, selectedContact: contact, context: context),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: ListTile(
                        leading: contact.photo == null
                            ? const CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    AssetImage('assets/avatar.png'),
                              )
                            : CircleAvatar(
                                radius: 25,
                                backgroundImage: MemoryImage(contact.photo!),
                              ),
                        title: Text(
                          contact.displayName,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            error: (error, stackTrace) => ErrorScreen(error: error.toString()),
            loading: () => const Loader(),
          ),
    );
  }
}
