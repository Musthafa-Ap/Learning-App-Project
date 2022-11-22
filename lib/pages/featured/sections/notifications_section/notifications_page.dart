import 'package:flutter/material.dart';
import 'package:nuox_project/pages/featured/services/featured_section/featured_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    get();
    super.initState();
  }

  String? access;
  void get() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    access = shared.getString("access_token");
    String? refresh = shared.getString("refresh_token");
    print("refresh token === $refresh");
  }

  @override
  Widget build(BuildContext context) {
    final featuredProvider = Provider.of<FeaturedProvider>(context);
    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   Transform.scale(
        //       scale: .8,
        //       child: ValueListenableBuilder(
        //         valueListenable: featuredProvider.toggleNotifier,
        //         builder: (context, value, child) {
        //           return CupertinoSwitch(
        //             trackColor: Colors.grey,
        //             value: value,
        //             onChanged: (newValue) {
        //               print(newValue);
        //               featuredProvider.toggleNotifier.value = newValue;
        //               if (newValue == true) {
        //                 featuredProvider.disableNotificaton(
        //                     disabled: "true", context: context);
        //               } else if (newValue == false) {
        //                 featuredProvider.disableNotificaton(
        //                     disabled: "false", context: context);
        //               }
        //             },
        //           );
        //         },
        //       )),
        //   kWidth10
        // ],
        centerTitle: true,
        title: const Text("Notifications"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: featuredProvider.notificationList == null ||
              featuredProvider.notificationList!.data!.isEmpty ||
              access == null
          ? const Center(
              child: Text(
                "No notifications",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: featuredProvider.notificationList?.data?.length,
              padding: const EdgeInsets.all(15),
              itemBuilder: (context, index) {
                final datas = featuredProvider.notificationList?.data?[index];
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                          "https://www.citypng.com/public/uploads/preview/-11594730224ty2a7hmakh.png"),
                      radius: 22,
                    ),
                    title: Text(
                      datas!.subIdentifier.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      datas.createdAt.toString(),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
