import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watsapp/common/enums/message_enum.dart';
import 'package:watsapp/common/utils/utils.dart';
import 'package:watsapp/features/chat/repository/chat_repository.dart';

import '../../../colors.dart';
import '../../../common/providers/message_reply_provider.dart';
import '../controller/chat_controller.dart';
import 'message_reply_preview.dart';

class BottomChatField extends ConsumerStatefulWidget {
  final String recieverUserId;

  const BottomChatField({super.key, required this.recieverUserId});

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  bool isShowSendButton = false;
  final messageController = TextEditingController();
  bool isShowEmojiContainer = false;
  FocusNode focusNode = FocusNode();

  void sendTextMessage() async {
    if (isShowSendButton) {
      ref.read(chatControllerProvider).sendTextMessage(
            context,
            messageController.text.trim(),
            widget.recieverUserId,
          );
      setState(() {
        messageController.text = "";
      });
    }
  }

  void sendFileMessage(File file, MessageEnum messageEnum) {
    ref.read(chatControllerProvider).sendFileMessage(
          context,
          file,
          widget.recieverUserId,
          messageEnum,
        );
  }

  void selectImage() async {
    File? image = await pickImageFromGallery(context);
    if (image != null) {
      sendFileMessage(image, MessageEnum.image);
    }
  }

  void selectVideo() async {
    File? video = await pickVideoFromGallary(context);
    if (video != null) {
      sendFileMessage(video, MessageEnum.video);
    }
  }

  void hideEmojiContainer() {
    setState(() {
      isShowEmojiContainer = false;
    });
  }

  void showEmojiContainer() {
    setState(() {
      isShowEmojiContainer = true;
    });
  }

  void showKeyboard() => focusNode.requestFocus();

  void hideKeyboard() => focusNode.unfocus();

  void toggleEmojiKeyboardContainer(){
    if(isShowEmojiContainer){
      showKeyboard();
      hideEmojiContainer();
    }else{
      hideKeyboard();
      showEmojiContainer();
    }
  }

  void selectGIF() async{
    final gif = await pickGIF(context);
    if(gif != null){
      ref.read(chatControllerProvider).sendGIFMessage(context, gif.url, widget.recieverUserId);
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messageReply = ref.watch(messageReplyProvider);
    final isShowMessageReply = messageReply != null;
    return Padding(
      padding: const EdgeInsets.only(left: 10).copyWith(bottom: 10),
      child: Column(
        children: [
          isShowMessageReply ? const MessageReplyPreview() : const SizedBox(),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  focusNode: focusNode,
                  controller: messageController,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        isShowSendButton = true;
                      });
                    } else {
                      setState(() {
                        isShowSendButton = false;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: mobileChatBoxColor,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: toggleEmojiKeyboardContainer,
                                icon: const Icon(
                                  Icons.emoji_emotions,
                                  color: Colors.grey,
                                )),
                            const SizedBox(width: 4),
                            IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: selectGIF,
                                icon: const Icon(
                                  Icons.gif,
                                  color: Colors.grey,
                                )),
                          ],
                        ),
                      ),
                    ),
                    suffixIcon: SizedBox(
                      // padding:  EdgeInsets.symmetric(horizontal: 20.0),
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: selectImage,
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                              )),
                          IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: selectVideo,
                              icon: const Icon(
                                Icons.attach_file,
                                color: Colors.grey,
                              )),
                        ],
                      ),
                    ),
                    hintText: 'Type a message!',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                ),
              ),
              GestureDetector(
                onTap: sendTextMessage,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CircleAvatar(
                    backgroundColor: const Color(0xff128c7e),
                    radius: 24,
                    child: Icon(
                      isShowSendButton ? Icons.send : Icons.mic,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

            ],
          ),
          isShowEmojiContainer?  SizedBox(
            height: 310,
            child: EmojiPicker(
              onEmojiSelected: ((category, emoji) {
                setState(() {
                  messageController.text =
                      messageController.text + emoji.emoji;
                });
                if(!isShowSendButton){
                  setState(() {
                    isShowSendButton = true;
                  });
                }
              }),
            ),
          ) : const SizedBox(),
        ],
      ),
    );
  }
}
