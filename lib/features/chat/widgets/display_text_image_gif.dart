import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:watsapp/common/enums/message_enum.dart';
import 'package:watsapp/features/chat/widgets/video_player_item_widget.dart';

class DisplayTextImageGIF extends StatelessWidget {
  final String message;
  final MessageEnum type;

  const DisplayTextImageGIF({
    super.key,
    required this.type,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return type == MessageEnum.text
        ? Text(
            message,
            style: const TextStyle(fontSize: 16),
          )
        : type == MessageEnum.video
            ? VideoPlayerItem(videoUrl: message)
            : type == MessageEnum.gif
                ? CachedNetworkImage(imageUrl: message)
                : CachedNetworkImage(
                    imageUrl: message,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      child: Icon(Icons.error),
                    ),
                  );
  }
}
