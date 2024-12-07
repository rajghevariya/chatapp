import 'package:demochats/Components/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:share/share.dart';


class ShareApp extends StatelessWidget {

final String _content =
      'Hey friends! awesome chat app that I think you will love. It is super easy to use and lets us chat, share files. We can  share photos and videos. Plus, it is totally free and secure. Want to try it out? Click the link to download the app and start chatting with me! [Share App]';

  void _shareContent() {
    Share.share(_content);
  }


  @override
  Widget build(BuildContext context) {
  
     return Scaffold(
      backgroundColor: bgcolor,
     appBar: AppBar(
         iconTheme: IconThemeData(
    color: Colors.white, //change your color here
  ),
        title:const  Text('Share Your Application',style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Center(
          child: Column(children: [
            Text(_content, textAlign: TextAlign.justify,style: TextStyle(color: Colors.white,fontSize: 16),),
            const SizedBox(height: 15),
            ElevatedButton.icon(
                onPressed: _shareContent,
                icon: const Icon(Icons.share),
                label: const Text('Share Application'))
          ]),
        ),
      ),
    );
  }
}

