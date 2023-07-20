import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:watsapp/common/models/status_model.dart';
import 'package:watsapp/common/widgets/loader.dart';
import 'package:watsapp/features/status/controller/status_controller.dart';

import '../../../colors.dart';

class StatusConatctsScreen extends ConsumerWidget {
  const StatusConatctsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<Status>>(
        future: ref.read(statusControllerProvider).getStatus(context),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Loader();
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
              itemBuilder: (context,index){
            var statusData = snapshot.data![index];
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    // Navigator.pushNamed(context,MobileChatScreen.routeName,arguments: {
                    //   "name":chatContactData.name,
                    //   "uid": chatContactData.contactId,
                    // });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      title: Text(
                        statusData.username,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),

                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          statusData.profilePic,
                        ),
                        radius: 30,
                      ),
                    ),
                  ),
                ),
                const Divider(color: dividerColor, indent: 85),
              ],
            );
          });
        });
  }
}