import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watsapp/colors.dart';
import 'package:watsapp/common/widgets/loader.dart';
import 'package:watsapp/features/auth/controller/auth_controller.dart';
import 'package:watsapp/info.dart';
import 'package:watsapp/features/chat/widgets/chat_list.dart';

import '../../../common/models/user_model.dart';
import '../widgets/bottom_chat_filed_widget.dart';

class MobileChatScreen extends ConsumerWidget {
  static const String routeName = "/mobile-chat-screen";
  final String name;
  final String uid;
  const MobileChatScreen({Key? key,required this.name,required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: StreamBuilder<UserModel>(
          stream: ref.read(authControllerProvider).userDataById(uid) ,
          builder: (context,snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Loader();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name),
                Text(snapshot.data!.isOnline ?"online":"offline",style:const TextStyle(fontSize: 12,fontWeight: FontWeight.normal),),
              ],
            );

          }
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body:SafeArea(
        child:  Column(
          children: [
             Expanded(
              child: ChatList(recieverUserId: uid,),
            ),
            BottomChatField(recieverUserId: uid),
          ],
        ),
      ),
    );
  }
}

