// import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:http/http.dart' as http;
// import 'package:vision_bc_app/app/core/style/app_colors.dart';
// import 'package:vision_bc_app/app/core/utils/helper/print_log.dart';
// import 'package:path_provider/path_provider.dart';
//
// class FirebaseInitialize {
//   final FirebaseMessaging fcm = FirebaseMessaging.instance;
//
//   Future initialise() async {
//     await fcm.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//   }
//
//   static void initFirebaseState(BuildContext context) async {
//     FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
//     AndroidNotificationChannel channel = const AndroidNotificationChannel(
//         'msg_channel', 'High Notifications',
//         description: 'This channel is used for important notifications.',
//         importance: Importance.high,
//         playSound: true);
//
//     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//
//     Future<void> generateSimpleNotication(String title, String msg) async {
//       var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         channel.id,
//         channel.name,
//         channelDescription: channel.description,
//         playSound: true,
//         icon: '@mipmap/ic_launcher',
//       );
//       var iosDetail = const IOSNotificationDetails();
//
//       var platformChannelSpecifics = NotificationDetails(
//           android: androidPlatformChannelSpecifics, iOS: iosDetail);
//       await flutterLocalNotificationsPlugin.show(
//           0, title, msg, platformChannelSpecifics);
//     }
//
//     Future<String> downloadAndSaveImage(String url, String fileName) async {
//       var directory = await getApplicationDocumentsDirectory();
//       var filePath = '${directory.path}/$fileName';
//       var response = await http.get(Uri.parse(url));
//
//       var file = File(filePath);
//       await file.writeAsBytes(response.bodyBytes);
//       return filePath;
//     }
//
//     Future<void> generateImageNotication(
//         String title, String msg, String image) async {
//       // var largeIconPath = await _downloadAndSaveImage(image, 'largeIcon');
//       // var bigPicturePath = await _downloadAndSaveImage(image, 'bigPicture');
//       var bigPictureStyleInformation = BigPictureStyleInformation(
//           FilePathAndroidBitmap(image),
//           hideExpandedLargeIcon: true,
//           contentTitle: title,
//           htmlFormatContentTitle: true,
//           summaryText: msg,
//           htmlFormatSummaryText: true);
//       var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//           channel.id, channel.name,
//           channelDescription: channel.description,
//           playSound: true,
//           icon: '@mipmap/ic_launcher',
//           largeIcon: FilePathAndroidBitmap(image),
//           styleInformation: bigPictureStyleInformation);
//
//       var platformChannelSpecifics =
//           NotificationDetails(android: androidPlatformChannelSpecifics);
//       await flutterLocalNotificationsPlugin.show(
//         0,
//         title,
//         msg,
//         platformChannelSpecifics,
//       );
//     }
//
//     FirebaseMessaging.instance.getInitialMessage().then((message) {
//       if (message != null) {
//         printLog('instance ${message.data}');
//         showDialog(
//           context: context,
//           barrierDismissible: true,
//           builder: (context) => AlertDialog(
//             contentPadding: const EdgeInsets.all(10),
//             titlePadding: const EdgeInsets.all(10),
//             actionsPadding: EdgeInsets.zero,
//             content: ListTile(
//               title: Row(
//                 children: [
//                   Image.asset(
//                     'assets/icons/icon.png',
//                     height: 50,
//                     width: 50,
//                   ),
//                   const SizedBox(
//                     width: 5,
//                   ),
//                   Expanded(
//                     child: Text(
//                         message.notification!.title.toString().contains("null")
//                             ? "Notification"
//                             : message.notification!.title.toString(),
//                         maxLines: 3,
//                         softWrap: false,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.w400)),
//                   )
//                 ],
//               ),
//               subtitle: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Text(message.notification!.body.toString().contains('null')
//                       ? ""
//                       : message.notification!.body.toString()),
//                 ],
//               ),
//             ),
//             actions: <Widget>[
//               TextButton(
//                 child: const Text(
//                   'CLOSE',
//                   style: TextStyle(
//                       color: AppColors.primaryColor,
//                       fontWeight: FontWeight.w500),
//                 ),
//                 onPressed: () => {
//                   Navigator.pop(context),
//                 },
//               ),
//             ],
//           ),
//         );
//       }
//     });
//
//     firebaseMessaging.getToken().then((value) {
//       printLog('--token--$value');
//     });
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       printLog('--on message--$message');
//
//       RemoteNotification notification = message.notification!;
//       var title = notification.title ?? '';
//       var body = notification.body ?? '';
//       var image = notification.android!.imageUrl;
//       if (image != null && image != 'null' && image != '') {
//         generateImageNotication(title, body, image);
//         showDialog(
//           context: context,
//           barrierDismissible: true,
//           builder: (context) => AlertDialog(
//             contentPadding: const EdgeInsets.all(10),
//             titlePadding: const EdgeInsets.all(10),
//             actionsPadding: EdgeInsets.zero,
//             content: ListTile(
//               title: Row(
//                 children: [
//                   Image.asset(
//                     'assets/icons/icon.png',
//                     height: 50,
//                     width: 50,
//                   ),
//                   const SizedBox(
//                     width: 5,
//                   ),
//                   Expanded(
//                     child: Text(title,
//                         maxLines: 3,
//                         softWrap: false,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.w400)),
//                   )
//                 ],
//               ),
//               subtitle: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     body,
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   CachedNetworkImage(
//                     imageUrl: image,
//                     progressIndicatorBuilder:
//                         (context, url, downloadProgress) =>
//                             CircularProgressIndicator(
//                       value: downloadProgress.progress,
//                       color: AppColors.primaryColor,
//                     ),
//                     errorWidget: (context, url, error) => const Icon(Icons.error),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                 ],
//               ),
//             ),
//             actions: <Widget>[
//               TextButton(
//                 child: const Text(
//                   'CLOSE',
//                   style: TextStyle(
//                       color: AppColors.primaryColor,
//                       fontWeight: FontWeight.w500),
//                 ),
//                 onPressed: () => {
//                   Navigator.pop(context),
//                 },
//               ),
//             ],
//           ),
//         );
//       } else {
//         generateSimpleNotication(title, body);
//         showDialog(
//           context: context,
//           barrierDismissible: true,
//           builder: (context) => AlertDialog(
//             contentPadding: const EdgeInsets.all(10),
//             titlePadding: const EdgeInsets.all(10),
//             actionsPadding: EdgeInsets.zero,
//             content: ListTile(
//               title: Row(
//                 children: [
//                   Image.asset(
//                     'assets/icons/icon.png',
//                     height: 50,
//                     width: 50,
//                   ),
//                   const SizedBox(
//                     width: 5,
//                   ),
//                   Expanded(
//                     child: Text(
//                         message.notification!.title.toString().contains("null")
//                             ? "Notification"
//                             : message.notification!.title.toString(),
//                         softWrap: false,
//                         maxLines: 3,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.w400)),
//                   )
//                 ],
//               ),
//               subtitle: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     message.notification!.body.toString().contains('null')
//                         ? ""
//                         : message.notification!.body.toString(),
//                     softWrap: true,
//                   ),
//                 ],
//               ),
//             ),
//             actions: <Widget>[
//               TextButton(
//                 child: const Text(
//                   'CLOSE',
//                   style: TextStyle(
//                       color: AppColors.primaryColor,
//                       fontWeight: FontWeight.w500),
//                 ),
//                 onPressed: () => {
//                   Navigator.pop(context),
//                 },
//               ),
//             ],
//           ),
//         );
//       }
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
//       RemoteNotification notification = message.notification!;
//       var title = notification.title ?? '';
//       var body = notification.body ?? '';
//       var image = notification.android!.imageUrl;
//       if (image != null && image != 'null' && image != '') {
//         generateImageNotication(title, body, image);
//         showDialog(
//           context: context,
//           barrierDismissible: true,
//           builder: (context) => AlertDialog(
//             contentPadding: const EdgeInsets.all(10),
//             titlePadding: const EdgeInsets.all(10),
//             actionsPadding: EdgeInsets.zero,
//             content: ListTile(
//               title: Row(
//                 children: [
//                   Image.asset(
//                     'assets/icons/icon.png',
//                     height: 50,
//                     width: 50,
//                   ),
//                   const SizedBox(
//                     width: 5,
//                   ),
//                   Expanded(
//                     child: Text(title,
//                         maxLines: 3,
//                         softWrap: false,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.w400)),
//                   )
//                 ],
//               ),
//               subtitle: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     body,
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   CachedNetworkImage(
//                     imageUrl: image,
//                     progressIndicatorBuilder:
//                         (context, url, downloadProgress) =>
//                             CircularProgressIndicator(
//                       value: downloadProgress.progress,
//                       color: AppColors.primaryColor,
//                     ),
//                     errorWidget: (context, url, error) => const Icon(Icons.error),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                 ],
//               ),
//             ),
//             actions: <Widget>[
//               TextButton(
//                 child: const Text(
//                   'CLOSE',
//                   style: TextStyle(
//                       color: AppColors.primaryColor,
//                       fontWeight: FontWeight.w500),
//                 ),
//                 onPressed: () => {
//                   Navigator.pop(context),
//                 },
//               ),
//             ],
//           ),
//         );
//       } else {
//         generateSimpleNotication(title, body);
//         showDialog(
//           context: context,
//           barrierDismissible: true,
//           builder: (context) => AlertDialog(
//             contentPadding: const EdgeInsets.all(10),
//             titlePadding: const EdgeInsets.all(10),
//             actionsPadding: EdgeInsets.zero,
//             content: ListTile(
//               title: Row(
//                 children: [
//                   Image.asset(
//                     'assets/icons/icon.png',
//                     height: 50,
//                     width: 50,
//                   ),
//                   const SizedBox(
//                     width: 5,
//                   ),
//                   Expanded(
//                     child: Text(
//                         message.notification!.title.toString().contains("null")
//                             ? "Notification"
//                             : message.notification!.title.toString(),
//                         softWrap: false,
//                         maxLines: 3,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                             color: Colors.black, fontWeight: FontWeight.w400)),
//                   )
//                 ],
//               ),
//               subtitle: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     message.notification!.body.toString().contains('null')
//                         ? ""
//                         : message.notification!.body.toString(),
//                     softWrap: true,
//                   ),
//                 ],
//               ),
//             ),
//             actions: <Widget>[
//               TextButton(
//                 child: const Text(
//                   'CLOSE',
//                   style: TextStyle(
//                       color: AppColors.primaryColor,
//                       fontWeight: FontWeight.w500),
//                 ),
//                 onPressed: () => {
//                   Navigator.pop(context),
//                 },
//               ),
//             ],
//           ),
//         );
//       }
//     });
//   }
// }
