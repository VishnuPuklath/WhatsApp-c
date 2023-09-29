import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/feature/select_contacts/repository/select_contact_repository.dart';

//provider for contact in our phone
final getContactProvider = FutureProvider((ref) {
  final selectContactRepository = ref.watch(selectContactRepositoryProvider);
  return selectContactRepository.getContacts();
});

//provider for controller class
final selectContactControllerProvider = Provider((ref) {
  return SelectContactController(
      selectContactRepository: ref.watch(selectContactRepositoryProvider),
      ref: ref);
});

class SelectContactController {
  final SelectContactRepository selectContactRepository;
  final ProviderRef ref;

  SelectContactController(
      {required this.selectContactRepository, required this.ref});

  void selectContact(Contact selectedContact, BuildContext context) async {
    selectContactRepository.selectContact(selectedContact, context);
  }
}
