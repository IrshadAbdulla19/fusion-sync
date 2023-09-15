import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/message_notification_service.dart';
import 'package:fusion_sync/controller/messege_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MessegeScreen extends StatelessWidget {
  MessegeScreen({super.key});
  final msgCntrl = Get.put(MessegeController());
  @override
  Widget build(BuildContext context) {
    msgCntrl.allUsersGet();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            color: kBlackColor,
            icon: const Icon(
              Icons.arrow_back,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Messege",
          style: normalTextStyleBlackHead,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => FollowersListForMessage());
              },
              color: kBlackColor,
              icon: const Icon(Icons.search))
        ],
      ),
      body: StreamBuilder(
          stream: msgCntrl.getUsersChatList
              .doc(msgCntrl.auth.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(
                "There is an Error ${snapshot.error}",
                style: normalTextStyleBlack,
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text(
                "Loading...",
                style: normalTextStyleBlack,
              );
            }
            List list = [];
            try {
              list = snapshot.data!['ChatList'] as List;
            } catch (e) {
              print(
                  "the erorr for the list is >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$e");
            }
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                var username = '';
                var profilePic = '';
                var fcmToken = '';
                var uid = list[index];
                try {
                  for (var element in msgCntrl.allUserDetiles) {
                    if (uid == element['uid']) {
                      username = element['username'];
                      profilePic = element['profilePic'];
                      try {
                        fcmToken = element['fcmToken'];
                      } catch (e) {
                        fcmToken = '';
                      }
                    }
                  }
                } catch (e) {
                  print("the erorr catch is >>>>>>>>>>>>>>>>>>>>$e");
                }
                return GestureDetector(
                  onTap: () => Get.to(() => MessegeInbox(
                        username: username,
                        profilePic: profilePic,
                        recevierUid: uid,
                        fcmToken: fcmToken,
                      )),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            profilePic == '' ? nonUserNonProfile : profilePic),
                      ),
                      title: Text(
                        username,
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}

class FollowersListForMessage extends StatelessWidget {
  FollowersListForMessage({super.key});
  final msgCntrl = Get.put(MessegeController());
  @override
  Widget build(BuildContext context) {
    msgCntrl.getAllUsers();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) {
                  msgCntrl.searchUserGet(value);
                },
                decoration: InputDecoration(
                    prefixIcon: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.search)),
                    suffixIcon: IconButton(
                        onPressed: () {
                          msgCntrl.searchList.clear();
                        },
                        icon: const Icon(Icons.cancel)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            Flexible(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: msgCntrl.searchList.length,
                  itemBuilder: (context, index) {
                    var user = msgCntrl.searchList[index];
                    String username = user['username'];
                    String profile = user['profilePic'];
                    String fcmToken = '';
                    try {
                      fcmToken = user['fcmToken'];
                    } catch (e) {
                      fcmToken = '';
                    }
                    String thisUserId = user['uid'];
                    return GestureDetector(
                      onTap: () => Get.to(() => MessegeInbox(
                            username: username,
                            profilePic: profile,
                            recevierUid: thisUserId,
                            fcmToken: fcmToken,
                          )),
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                profile == '' ? nonUserNonProfile : profile),
                          ),
                          title: Text(
                            username,
                            style: normalTextStyleBlack,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class MessegeInbox extends StatelessWidget {
  MessegeInbox(
      {super.key,
      required this.recevierUid,
      required this.profilePic,
      required this.username,
      required this.fcmToken});
  final messageCntrl = Get.put(MessegeController());
  String recevierUid;
  String username;
  String fcmToken;
  String profilePic = '';
  String thisDate = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                color: kBlackColor,
                icon: const Icon(
                  Icons.arrow_back,
                )),
            CircleAvatar(
              backgroundImage: NetworkImage(
                  profilePic == '' ? nonUserNonProfile : profilePic),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              username,
              style: normalTextStyleBlackHead,
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          Card(
            shadowColor: kBlackColor,
            elevation: 7,
            color: kWhiteColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 5),
                    child: TextFormField(
                      controller: messageCntrl.messageCntrl,
                      decoration: InputDecoration(
                          hintText: 'Message',
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                              onPressed: () async {
                                if (messageCntrl.messageCntrl.text != '') {
                                  await messageCntrl.sendMessage(recevierUid);
                                  LocalNotificationService.sendNotification(
                                      title: "New message",
                                      message: messageCntrl.messageCntrl.text,
                                      token: fcmToken);
                                  messageCntrl.messageCntrl.clear();
                                }
                              },
                              icon: const Icon(Icons.send))),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: messageCntrl.getMessage(
          messageCntrl.auth.currentUser!.uid, recevierUid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(
            "Error${snapshot.hasError}",
            style: normalTextStyleBlack,
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text(
            "Waiting...",
            style: normalTextStyleBlack,
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: snapshot.data!.docs
                .map((document) => _buildMessageItem(document))
                .toList(),
          ),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var alignment = (data['SenderId'] == messageCntrl.auth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    var color = (data['SenderId'] == messageCntrl.auth.currentUser!.uid)
        ? kBlackColor
        : kWhiteColor;
    var txtStyle = (data['SenderId'] == messageCntrl.auth.currentUser!.uid)
        ? normalTextStyleWhite
        : normalTextStyleBlack;
    var format = DateFormat.jm().format(data['Time'].toDate());
    String date = DateFormat.yMMMMd('en_US').format(data['Time'].toDate());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: date != thisDate
              ? Text(thisDate = date)
              : const SizedBox(
                  height: 1,
                ),
        ),
        Container(
          alignment: alignment,
          child: Card(
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        data['Messege'],
                        style: txtStyle.copyWith(fontSize: 18),
                      ),
                      Text(
                        format,
                        style: txtStyle.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
      ],
    );
  }
}
