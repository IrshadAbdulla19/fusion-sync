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
        title: const Text(
          "Messege",
          style: normalTextStyleBlackHead,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => FollowersListForMessage());
              },
              color: kBlackColor,
              icon: const Icon(Icons.add))
        ],
      ),
      body: StreamBuilder(
          stream: msgCntrl.getUsersChatList
              .doc(msgCntrl.auth.currentUser?.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(
                "There is an Error ${snapshot.error}",
                style: normalTextStyleBlack,
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text(
                "Loading...",
                style: normalTextStyleBlack,
              );
            }
            List list = snapshot.data!['ChatList'] as List;
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                var uid = list[index];
                var username = '';
                var profilePic = '';
                var fcmToken = '';
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
  @override
  Widget build(BuildContext context) {
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
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  profilePic == '' ? nonUserNonProfile : profilePic),
            ),
            Text(
              username,
              style: normalTextStyleBlackHead,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Card(
              color: Color.fromARGB(255, 92, 133, 161),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: messageCntrl.messageCntrl,
                        decoration: InputDecoration(
                            hintText: 'Text here',
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  await messageCntrl.sendMessage(recevierUid);
                                  LocalNotificationService.sendNotification(
                                      title: "New message",
                                      message: messageCntrl.messageCntrl.text,
                                      token: fcmToken);
                                  messageCntrl.messageCntrl.clear();
                                },
                                icon: const Icon(Icons.send))),
                      ),
                    ),
                  )
                ],
              ),
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
          return const Text(
            "Waiting...",
            style: normalTextStyleBlack,
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
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
        ? Colors.blue
        : Colors.grey;
    var format = DateFormat.jm().format(data['Time'].toDate());
    return Container(
      margin: const EdgeInsets.all(2),
      alignment: alignment,
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
                  style: normalTextStyleBlack.copyWith(fontSize: 18),
                ),
                Text(
                  format,
                  style: normalTextStyleBlack.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
