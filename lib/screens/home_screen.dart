import 'dart:developer';

import 'package:demochats/Components/color.dart';
import 'package:demochats/screens/Privacy_Policy_Screen.dart';
import 'package:demochats/screens/ai_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:share/share.dart';

import '../api/apis.dart';
import '../helper/dialogs.dart';
import '../main.dart';
import '../models/chat_user.dart';
import '../widgets/chat_user_card.dart';
import '../widgets/profile_image.dart';
import 'auth/login_screen.dart';
import 'profile_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //storing all users
  List<ChatUser> _list = [];

  // for storing searched items
  final List<ChatUser> _searchList = [];

  // for storing search status
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();

    //for updating user active status according to lifecycle events
    //resume -- active or online
    //pause  -- inactive or offline
    SystemChannels.lifecycle.setMessageHandler((message) {
      log('Message: $message');

      if (APIs.auth.currentUser != null) {
        if (message.toString().contains('resume')) {
          APIs.updateActiveStatus(true);
        }
        if (message.toString().contains('pause')) {
          APIs.updateActiveStatus(false);
        }
      }

      return Future.value(message);
    });
  }

  final _advancedDrawerController = AdvancedDrawerController();

  void _handleMenuButtonPressed() {
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
        backdropColor: bgcolor,
        controller: _advancedDrawerController,
        animationCurve: Curves.easeInOutBack,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: false,
        disabledGestures: false,
        childDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        drawer: SafeArea(
          child: Container(
            child: ListTileTheme(
              textColor: Colors.white,
              iconColor: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 128.0,
                    height: 128.0,
                    margin: const EdgeInsets.only(
                      top: 24.0,
                      bottom: 64.0,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      tooltip: 'View Profile',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProfileImage(
                              size: double.infinity,
                            ),
                          ),
                        );
                      },
                      icon: const ProfileImage(size: double.infinity),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10),
                    width: double.infinity, // Adjust width according to your needs
                    height: 2, // Height of the underline
                    color: Colors.white, // Color of the underline
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => HomeScreen()));
                    },
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10),
                    width: double.infinity, // Adjust width according to your needs
                    height: 2, // Height of the underline
                    color: Colors.white, // Color of the underline
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ProfileScreen(
                                    user: APIs.me,
                                  )));
                    },
                    leading: Icon(Icons.account_circle_rounded),
                    title: Text('Profile'),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10),
                    width: double.infinity,
                    height: 2,
                    color: Colors.white,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => AiScreen()));
                    },
                    leading: Icon(Icons.help),
                    title: Text('Help'),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10),
                    width: double.infinity,
                    height: 2,
                    color: Colors.white,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => Privacy_policy()));
                    },
                    leading: Icon(Icons.privacy_tip_outlined),
                    title: Text('Privacy Policy'),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10),
                    width: double.infinity, // Adjust width according to your needs
                    height: 2, // Height of the underline
                    color: Colors.white, // Color of the underline
                  ),
                  ListTile(
                    onTap: () {
                      Share.share(
                          'Check out my app! https://play.google.com/store/apps/details?id=com.example.demochats',
                          subject: 'Share App');
                    },
                    leading: Icon(Icons.share),
                    title: Text('Share'),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10),
                    width: double.infinity,
                    height: 2,
                    color: Colors.white,
                  ),
                  ListTile(
                    onTap: () async {
                      await APIs.auth.signOut().then((value) async {
                        await GoogleSignIn().signOut().then((value) {
                          //for hiding progress dialog
                          Navigator.pop(context);

                          // APIs.auth = FirebaseAuth.instance;

                          //replacing home screen with login screen
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LoginScreen()));
                        });
                      });
                    },
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                  ),   Container(
                    margin: EdgeInsets.only(left: 10,right: 10),
                    width: double.infinity,
                    height: 2,
                    color: Colors.white,
                  ),
                  Spacer(),
                  DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white54,
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 16.0,
                      ),
                      child: Text('Terms of Service | Privacy Policy'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        child: GestureDetector(
          //for hiding keyboard when a tap is detected on screen
          onTap: FocusScope.of(context).unfocus,
          child: WillPopScope(
            onWillPop: () {
              if (_isSearching) {
                setState(() => _isSearching = !_isSearching);
                return Future.value(false);
              } else {
                return Future.value(true);
              }
            },
            child: Scaffold(
              backgroundColor: bgcolor,
              // app bar
              appBar: AppBar(
                // view profile
                leading: IconButton(
                  tooltip: 'View Profile',
                  onPressed: () {
                    _handleMenuButtonPressed();
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                ),

                title: _isSearching
                    ? TextField(
                        decoration: const InputDecoration(
                            border: InputBorder.none,

                            hintText: 'Name, Email, ...',
                            focusColor: Colors.white,
                            hintStyle: TextStyle(color: Colors.white)),
                        autofocus: true,
                        style:
                            const TextStyle(fontSize: 17, letterSpacing: 0.5,color:Colors.white),
                        //when search text changes then updated search list
                        onChanged: (val) {
                          //search logic
                          _searchList.clear();

                          val = val.toLowerCase();

                          for (var i in _list) {
                            if (i.name.toLowerCase().contains(val) ||
                                i.email.toLowerCase().contains(val)) {
                              _searchList.add(i);
                            }
                          }
                          setState(() => _searchList);
                        },
                      )
                    : const Text('I Chat',
                        style: TextStyle(color: Colors.white)),
                actions: [
                  //search user button
                  IconButton(
                      tooltip: 'Search',color: Colors.white,
                      onPressed: () =>
                          setState(() => _isSearching = !_isSearching),
                      icon: Icon(
                        _isSearching
                            ? CupertinoIcons.clear_circled_solid
                            : CupertinoIcons.search,
                        color: Colors.white,
                      )),

                  //add new user
                  IconButton(
                      tooltip: 'Add User',
                      padding: const EdgeInsets.only(right: 8),
                      onPressed: _addChatUserDialog,
                      icon: const Icon(
                        CupertinoIcons.person_add,
                        size: 25,
                        color: Colors.white,
                      ))
                ],
              ),

              //floating button to add new user
              // floatingActionButton: Padding(
              //   padding: const EdgeInsets.only(bottom: 10),
              //   child: FloatingActionButton(
              //       backgroundColor: Colors.white,
              //       onPressed: () {
              //
              //       child: Lottie.asset('assets/lottie/ai.json', width: 40)),
              // ),

              //body
              body: StreamBuilder(
                stream: APIs.getMyUsersId(),

                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    //if data is loading
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const Center(child: CircularProgressIndicator());

                    //if some or all data is loaded then show it
                    case ConnectionState.active:
                    case ConnectionState.done:
                      return StreamBuilder(
                        stream: APIs.getAllUsers(
                            snapshot.data?.docs.map((e) => e.id).toList() ??
                                []),

                        //get only those user, who's ids are provided
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            //if data is loading
                            case ConnectionState.waiting:
                            case ConnectionState.none:
                            // return const Center(
                            //     child: CircularProgressIndicator());

                            //if some or all data is loaded then show it
                            case ConnectionState.active:
                            case ConnectionState.done:
                              final data = snapshot.data?.docs;
                              _list = data
                                      ?.map((e) => ChatUser.fromJson(e.data()))
                                      .toList() ??
                                  [];

                              if (_list.isNotEmpty) {
                                return ListView.builder(
                                    itemCount: _isSearching
                                        ? _searchList.length
                                        : _list.length,
                                    padding:
                                        EdgeInsets.only(top: mq.height * .01),
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return ChatUserCard(
                                          user: _isSearching
                                              ? _searchList[index]
                                              : _list[index]);
                                    });
                              } else {
                                return const Center(
                                  child: Text('No Connections Found!',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white)),
                                );
                              }
                          }
                        },
                      );
                  }
                },
              ),
            ),
          ),
        ));
  }

  // for adding new chat user
  void _addChatUserDialog() {
    String email = '';

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              backgroundColor: bgcolor,
              contentPadding: const EdgeInsets.only(
                  left: 24, right: 24, top: 20, bottom: 10),

              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),

              //title
              title: const Row(
                children: [
                  Icon(
                    Icons.person_add,
                    color: Colors.blue,
                    size: 28,
                  ),
                  Text(
                    '  Add User',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),

              content: TextFormField(
                style: TextStyle(color: Colors.white),
                maxLines: null,
                onChanged: (value) => email = value,
                decoration: const InputDecoration(
                    hintText: 'Email Id',
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(Icons.email, color: Colors.blue),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
              ),

              //actions
              actions: [
                //cancel button
                MaterialButton(
                    onPressed: () {
                      //hide alert dialog
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel',
                        style: TextStyle(color: Colors.blue, fontSize: 16))),

                //add button
                MaterialButton(
                    onPressed: () async {
                      //hide alert dialog
                      Navigator.pop(context);
                      if (email.trim().isNotEmpty) {
                        await APIs.addChatUser(email).then((value) {
                          if (!value) {
                            Dialogs.showSnackbar(
                                context, 'User does not Exists!');
                          }
                        });
                      }
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ))
              ],
            ));
  }
}
