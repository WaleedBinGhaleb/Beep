// ignore_for_file: prefer_const_constructors, file_names,prefer_const_literals_to_create_immutables,library_prefixes
import 'package:beep/Pages/Chat.dart';
import 'package:beep/Utilities/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import 'package:sizer/sizer.dart';

import '../../Utilities/Colors.dart';

class MessageButton extends StatefulWidget {
  final DocumentSnapshot users;
  const MessageButton({super.key, required this.users});

  @override
  State<MessageButton> createState() => _MessageButtonState();
}

class _MessageButtonState extends State<MessageButton> {
  @override
  Widget build(BuildContext context) {
    final col = context.theme;
    final currentUser = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder2(
        streams: StreamTuple2(
            usersRef
                .doc(currentUser)
                .collection('FriendRequests')
                .doc(widget.users.id)
                .snapshots(),
            usersRef.doc(currentUser).snapshots()),
        builder: (context, snapshots) {
          if (snapshots.snapshot1.connectionState == ConnectionState.waiting) {
            return SizedBox.shrink();
          }
          if (!snapshots.snapshot1.data!.exists) {
            return SizedBox.shrink();
          }
          if (snapshots.snapshot1.hasData) {
            if (snapshots.snapshot1.data!['Approved'] == true) {
              return Container(
                height: 5.h,
                width: 40.w,
                margin: EdgeInsets.symmetric(
                  horizontal: 5.w,
                ),
                child: ElevatedButton(
                  onPressed: () => {
                    Get.to(() => Chat(users: widget.users),
                        transition: Transition.rightToLeft,
                        preventDuplicates: true)
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colours.teal),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ))),
                  child: Center(
                    child: Text(
                      "Message",
                      style: GoogleFonts.openSans(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: col.indicatorColor),
                    ),
                  ),
                ),
              );
            }
          }
          return SizedBox.shrink();
          // return Container(
          //   height: 6.h,
          //   width: 40.w,
          //   margin: EdgeInsets.symmetric(
          //     horizontal: 5.w,
          //   ),
          //   child: ElevatedButton(
          //     onPressed: () => {
          //       Get.to(() => Chat(users: widget.users),
          //           transition: Transition.rightToLeft,
          //           preventDuplicates: true)
          //     },
          //     style: ButtonStyle(
          //         backgroundColor: MaterialStateProperty.resolveWith(
          //             (states) => Colours.teal),
          //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //             RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(15.0),
          //         ))),
          //     child: Center(
          //       child: Text(
          //         "Message",
          //         style: GoogleFonts.openSans(
          //             fontSize: 12.sp,
          //             fontWeight: FontWeight.w500,
          //             color: col.indicatorColor),
          //       ),
          //     ),
          //   ),
          // );
        });
  }
}
