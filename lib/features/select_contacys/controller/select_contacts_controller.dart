import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watsapp/features/select_contacys/repository/select_repository.dart';

final getContactsProvider = FutureProvider((ref) {
  final selectContactRepository = ref.watch(selectContactsRepositoryProvider);
  return selectContactRepository.getContacts();
});

final selectContactControllerProvider = Provider((ref){
 final selectContactRepository = ref.watch(selectContactsRepositoryProvider);
 return SelectContactController(ref: ref, selectContactRepository: selectContactRepository);
});

class SelectContactController {
  final ProviderRef ref;
  final SelectContactRepository selectContactRepository;

  SelectContactController({
    required this.ref,
    required this.selectContactRepository,
  });

  void selectContact(Contact selectedContact,BuildContext context){
     selectContactRepository.selectContact(selectedContact, context);
  }
}

