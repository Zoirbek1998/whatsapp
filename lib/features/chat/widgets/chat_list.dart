
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:watsapp/common/enums/message_enum.dart';
import 'package:watsapp/common/models/message.dart';
import 'package:watsapp/common/providers/message_reply_provider.dart';
import 'package:watsapp/common/widgets/loader.dart';
import 'package:watsapp/features/chat/controller/chat_controller.dart';
import 'package:watsapp/info.dart';
import 'package:watsapp/features/chat/widgets/my_message_card.dart';
import 'package:watsapp/features/chat/widgets/sender_message_card.dart';

class ChatList extends ConsumerStatefulWidget {
  final String recieverUserId;

  const ChatList({Key? key, required this.recieverUserId}) : super(key: key);

  @override
  ConsumerState createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final ScrollController messageController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void onMessageSwipe(String message, bool isMe, MessageEnum messageEnum) {
    ref
        .read(messageReplyProvider.state)
        .update((state) => MessageReply(message, isMe, messageEnum));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
        stream:
            ref.read(chatControllerProvider).chatStream(widget.recieverUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }

          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            messageController
                .jumpTo(messageController.position.maxScrollExtent);
          });

          return ListView.builder(
            // reverse: true,
            controller: messageController,
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              final messageData = snapshot.data![index];
              var timeSent = DateFormat.Hm().format(messageData.timeSent);

              if (!messageData.isSeen &&
                  messageData.recieverid ==
                      FirebaseAuth.instance.currentUser!.uid) {
                ref.read(chatControllerProvider).setChatMessageSeen(
                  context,
                  widget.recieverUserId,
                  messageData.messageId,
                );
              }
              if (messageData.senderId ==
                  FirebaseAuth.instance.currentUser!.uid) {
                return MyMessageCard(
                  message: messageData.text,
                  date: timeSent,
                  type: messageData.type,
                  repliedText: messageData.repliedMessage,
                  username: messageData.repliedTo,
                  repliedMessageType: messageData.repliedMessageType,
                  onLeftSwipe: () => onMessageSwipe(messageData.text, true, messageData.type),
                  isSeen:messageData.isSeen
                );
              }
              return SenderMessageCard(
                message: messageData.text,
                date: timeSent,
                type: messageData.type,
                username: messageData.repliedTo,
                repliedMessageType: messageData.repliedMessageType,
                onRightSwipe: () => onMessageSwipe(
                  messageData.text,
                  false,
                  messageData.type,
                ),
                repliedText: messageData.repliedMessage,
              );
            },
          );
        });
  }
}
