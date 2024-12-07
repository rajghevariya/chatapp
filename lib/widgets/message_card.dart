import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:demochats/Components/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver_updated/gallery_saver.dart';

import '../api/apis.dart';
import '../helper/dialogs.dart';
import '../helper/my_date_util.dart';
import '../main.dart';
import '../models/message.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({super.key, required this.message});

  final Message message;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    bool isMe = APIs.user.uid == widget.message.fromId;
    return InkWell(
        onLongPress: () => _showBottomSheet(isMe),
        child: isMe ? _greenMessage() : _blueMessage());
  }

  Widget _blueMessage() {
    if (widget.message.read.isEmpty) {
      APIs.updateMessageReadStatus(widget.message);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //message content
        Flexible(
          child: Container(
            padding: EdgeInsets.all(widget.message.type == Type.image
                ? mq.width * .03
                : mq.width * .04),
            margin: EdgeInsets.symmetric(
                horizontal: mq.width * .04, vertical: mq.height * .01),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 221, 245, 255),
                border: Border.all(color: Colors.lightBlue),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: widget.message.type == Type.text
                ?
                Text(
                    widget.message.msg,
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                  )
                :
                ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: CachedNetworkImage(
                      imageUrl: widget.message.msg,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.image, size: 70),
                    ),
                  ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(right: mq.width * .04),
          child: Text(
            MyDateUtil.getFormattedTime(
                context: context, time: widget.message.sent),
            style: const TextStyle(fontSize: 13, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _greenMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(width: mq.width * .04),

            if (widget.message.read.isNotEmpty)
              const Icon(Icons.done_all_rounded, color: Colors.blue, size: 20),

            const SizedBox(width: 2),

            Text(
              MyDateUtil.getFormattedTime(
                  context: context, time: widget.message.sent),
              style: const TextStyle(fontSize: 13, color: Colors.white),
            ),
          ],
        ),

        Flexible(
          child: Container(
            padding: EdgeInsets.all(widget.message.type == Type.image
                ? mq.width * .03
                : mq.width * .04),
            margin: EdgeInsets.symmetric(
                horizontal: mq.width * .04, vertical: mq.height * .01),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 218, 255, 176),
                border: Border.all(color: Colors.lightGreen),
                //making borders curved
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            child: widget.message.type == Type.text
                ?
                Text(
                    widget.message.msg,
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                  )
                :
                ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: CachedNetworkImage(
                      imageUrl: widget.message.msg,
                      placeholder: (context, url) => const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.image, size: 70),
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  // void _showMessageUpdateDialog() {
  //   String updatedMsg = widget.message.msg;
  //
  //   showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       contentPadding:
  //           const EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 10),
  //       shape: const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(20))),
  //       title: const Row(
  //         children: [
  //           Icon(Icons.message, color: Colors.blue, size: 28),
  //           SizedBox(width: 8),
  //           Text('Update Message'),
  //         ],
  //       ),
  //       content: TextFormField(
  //         initialValue: updatedMsg,
  //         maxLines: null,
  //         onChanged: (value) => updatedMsg = value,
  //         decoration: const InputDecoration(
  //           border: OutlineInputBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(15)),
  //           ),
  //           hintText: "Type your message here...",
  //         ),
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () {
  //             Navigator.pop(context); // Close the dialog
  //           },
  //           child: const Text('Cancel',
  //               style: TextStyle(color: Colors.blue, fontSize: 16)),
  //         ),
  //         TextButton(
  //           onPressed: () async {
  //             if (updatedMsg.isNotEmpty && updatedMsg != widget.message.msg) {
  //               try {
  //                 // Update the message via API
  //                 await APIs.updateMessage(widget.message, updatedMsg);
  //                 if (mounted) {
  //                   setState(() {
  //                     widget.message.msg = updatedMsg; // Update local message
  //                   });
  //                 }
  //
  //                 Navigator.pop(context); // Close the dialog
  //
  //                 // Check if the widget is still mounted before showing snackbar
  //                 Dialogs.showSnackbar(
  //                     context, 'Message updated successfully!');
  //               } catch (e) {
  //                 // Check if the widget is still mounted before showing snackbar
  //                 Dialogs.showSnackbar(context, 'Failed to update message: $e');
  //               }
  //             } else {
  //               // Check if the widget is still mounted before showing snackbar
  //               Dialogs.showSnackbar(context,
  //                   'No changes made to the message or message is empty.');
  //             }
  //           },
  //           child: const Text('Update',
  //               style: TextStyle(color: Colors.blue, fontSize: 16)),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  void dispose() {
    super.dispose();
  }

  void _showBottomSheet(bool isMe) {
    showModalBottomSheet(
        backgroundColor: bgcolor,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            children: [
              Container(
                height: 4,
                margin: EdgeInsets.symmetric(
                    vertical: mq.height * .015, horizontal: mq.width * .4),
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              ),

              widget.message.type == Type.text
                  ?
                  _OptionItem(
                      icon: const Icon(Icons.copy_all_rounded,
                          color: Colors.blue, size: 26),
                      name: 'Copy Text',
                      textColor: Colors.white,
                      onTap: () async {
                        await Clipboard.setData(
                                ClipboardData(text: widget.message.msg))
                            .then((value) {
                          Navigator.pop(context);

                          Dialogs.showSnackbar(context, 'Text Copied!');
                        });
                      },
                    )
                  :
                  _OptionItem(
                      icon: const Icon(Icons.download_rounded,
                          color: Colors.blue, size: 26),
                      name: 'Save Image',
                      textColor: Colors.white,
                      onTap: () async {
                        try {
                          log('Image Url: ${widget.message.msg}');
                          await GallerySaver.saveImage(widget.message.msg,
                                  albumName: 'I Chat')
                              .then((success) {
                            Navigator.pop(context);
                            if (success != null && success) {
                              Dialogs.showSnackbar(
                                  context, 'Image Successfully Saved!');
                            }
                          });
                        } catch (e) {
                          log('ErrorWhileSavingImg: $e');
                        }
                      }),

              if (isMe)
                Divider(
                  color: Colors.black54,
                  endIndent: mq.width * .04,
                  indent: mq.width * .04,
                ),

              if (widget.message.type == Type.text && isMe)
                _OptionItem(
                    icon: const Icon(Icons.edit, color: Colors.blue, size: 26),
                    name: 'Edit Message',
                    textColor: Colors.white,
                    onTap: () {
                      _showMessageUpdateDialog();
                      if(mounted)
                      {
                        Navigator.pop(context);
                      }
                      }),

              if (isMe)
                _OptionItem(
                    icon: const Icon(Icons.delete_forever,
                        color: Colors.red, size: 26),
                    name: 'Delete Message',
                    textColor: Colors.white,
                    onTap: () async {
                      await APIs.deleteMessage(widget.message).then((value) {
                        Navigator.pop(context);
                      });
                    }),

              //separator or divider
              Divider(
                color: Colors.black54,
                endIndent: mq.width * .04,
                indent: mq.width * .04,
              ),

              //sent time
              _OptionItem(
                  icon: const Icon(Icons.remove_red_eye, color: Colors.blue),
                  textColor: Colors.white,
                  name:
                      'Sent At: ${MyDateUtil.getMessageTime(context: context, time: widget.message.sent)}',
                  onTap: () {}),

              //read time
              _OptionItem(
                  icon: const Icon(Icons.remove_red_eye, color: Colors.green),
                  textColor: Colors.white,
                  name: widget.message.read.isEmpty
                      ? 'Read At: Not seen yet'
                      : 'Read At: ${MyDateUtil.getMessageTime(context: context, time: widget.message.read)}',
                  onTap: () {}),
            ],
          );
        });
  }

  void _showMessageUpdateDialog() {
    String updatedMsg = widget.message.msg;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        contentPadding: const EdgeInsets.only(
            left: 24, right: 24, top: 20, bottom: 10),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        title: const Row(
          children: [
            Icon(
              Icons.message,
              color: Colors.blue,
              size: 28,
            ),
            SizedBox(width: 8),
            Text('Update Message'),
          ],
        ),
        content: TextFormField(
          initialValue: updatedMsg,
          maxLines: null,
          onChanged: (value) => updatedMsg = value,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            hintText: "Type your message here...",
          ),
        ),
        actions: [
          // Cancel button
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: const Text('Cancel', style: TextStyle(color: Colors.blue, fontSize: 16)),
          ),
          // Update button
          TextButton(
            onPressed: () async {
              if (updatedMsg.isNotEmpty && updatedMsg != widget.message.msg) {
                try {
                  // Update the message via API
                  await APIs.updateMessage(widget.message, updatedMsg);

                  // Update the local message only if the widget is still mounted
                  if (mounted) {
                    setState(() {
                      widget.message.msg = updatedMsg; // Update local message
                      widget.message.msg = updatedMsg;

                    });
                  }

                  Navigator.pop(context); // Close the dialog
                  Dialogs.showSnackbar(context, 'Message updated successfully!');
                } catch (e) {
                  if (mounted) {
                    Dialogs.showSnackbar(context, 'Failed to update message: $e');
                  }
                }
              } else {
                if (mounted) {
                  Dialogs.showSnackbar(context, 'No changes made to the message or message is empty.');
                }
              }
            },
            child: const Text('Update', style: TextStyle(color: Colors.blue, fontSize: 16)),
          ),
        ],
      ),
    );
  }

}

//custom options card (for copy, edit, delete, etc.)
class _OptionItem extends StatelessWidget {
  final Icon icon;
  final String name;
  final VoidCallback onTap;
  final Color textColor;

  const _OptionItem(
      {required this.icon,
      required this.name,
      required this.onTap,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onTap(),
        child: Padding(
          padding: EdgeInsets.only(
              left: mq.width * .05,
              top: mq.height * .015,
              bottom: mq.height * .015),
          child: Row(children: [
            icon,
            Flexible(
                child: Text('    $name',
                    style: const TextStyle(
                        fontSize: 15, color: Colors.white, letterSpacing: 0.5)))
          ]),
        ));
  }
}
