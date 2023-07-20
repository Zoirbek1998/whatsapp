import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watsapp/common/widgets/error.dart';
import 'package:watsapp/common/widgets/loader.dart';
import 'package:watsapp/features/select_contacys/controller/select_contacts_controller.dart';

class SelectContactsScreen extends ConsumerWidget {
  static const String routeName = "/select-contacts";

  const SelectContactsScreen({super.key});

  void selectContact(WidgetRef ref,Contact selectedContact,BuildContext context){
    ref.read(selectContactControllerProvider).selectContact(selectedContact, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Select contact"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: ref.watch(getContactsProvider).when(data: (contactList) => ListView.builder(
          itemCount: contactList.length,
          itemBuilder: (context,index){
            var contact = contactList[index];
            return InkWell(
              onTap: ()=>selectContact(ref,contact,context),
              child: Padding(
                padding: const EdgeInsets.only(bottom:8.0),
                child: ListTile(
                  title: Text(contact.displayName,style:const TextStyle(fontSize: 18),),
                  leading: contact.photo == null? null : CircleAvatar(
                    backgroundImage: MemoryImage(contact.photo!),
                    radius: 30,
                  ),
                ),
              ),
            );
          }),
        error: (error, trace) => ErrorScreen(error: error.toString()),
        loading: () => const Loader(),),
    );
  }
}
