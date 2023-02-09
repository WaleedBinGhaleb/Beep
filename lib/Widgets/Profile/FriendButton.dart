// ignore_for_file: prefer_const_constructors, file_names,prefer_const_literals_to_create_immutables,library_prefixes
import 'package:beep/Utilities/Colors.dart';
import 'package:beep/Utilities/Constants.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart' as IC;

class FriendButton extends StatefulWidget {
  final DocumentSnapshot users;
  const FriendButton({super.key, required this.users});

  @override
  State<FriendButton> createState() => _FriendButtonState();
}

final currentUser = FirebaseAuth.instance.currentUser!.uid;

class _FriendButtonState extends State<FriendButton> {
  @override
  Widget build(BuildContext context) {
    final col = context.theme;

/*
                                                                          * Friend Requests Collection StreamBuilder
*/
    return Expanded(
      child: StreamBuilder2(
          streams: StreamTuple2(
              usersRef
                  .doc(currentUser)
                  .collection('FriendRequests')
                  .doc(widget.users.id)
                  .snapshots(),
              usersRef.doc(currentUser).snapshots()),
          builder: (context, snapshots) {
            if (snapshots.snapshot1.connectionState ==
                ConnectionState.waiting) {
              return SizedBox.shrink();
            }
/*
                                                                            * If there's no Requests ongoing ~ Add Friend
*/
            if (!snapshots.snapshot1.data!.exists) {
              return Container(
                  height: 5.h,
                  width: 40.w,
                  margin: EdgeInsets.symmetric(
                    horizontal: 5.w,
                  ),
                  child: ElevatedButton(
                      onPressed: () {
                        databaseProvider(context, listen: false).sendFrRequest(
                            widget.users.id,
                            currentUser,
                            snapshots.snapshot2.data!['SearchKey'],
                            widget.users['SearchKey']);
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => col.primaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ))),
                      child: Center(
                          child: Text(
                        "Add friend",
                        style: GoogleFonts.openSans(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: col.hintColor),
                      ))));
            }
/*
                                                                            * if Snapshot has data & Approved = True ~ Remove Friend
*/
            if (snapshots.snapshot1.hasData) {
              if (snapshots.snapshot1.data!['Approved'] == true) {
                return Container(
                    height: 5.h,
                    width: 40.w,
                    margin: EdgeInsets.symmetric(
                      horizontal: 5.w,
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          Get.dialog(AlertDialog(
                            backgroundColor: context.theme.primaryColorLight,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            icon: Icon(
                              IC.MaterialIcons.remove_circle_outline,
                              color: context.theme.hintColor,
                            ),
                            title: Text(
                              "Remove friend",
                              style: GoogleFonts.openSans(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: context.theme.hintColor),
                            ),
                            content: Text(
                              "Are you sure you want to remove '${widget.users['FullName']}' from your friends?",
                              style: GoogleFonts.openSans(
                                  color: context.theme.hintColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w300),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    Get.back();
                                    databaseProvider(context, listen: false)
                                        .deleteFriend(widget.users.id);
                                    BotToast.showText(
                                        text:
                                            "You and ${widget.users['FullName']} are no longer friends",
                                        duration: const Duration(seconds: 3),
                                        animationDuration:
                                            const Duration(seconds: 1),
                                        clickClose: true,
                                        contentColor: Colors.red,
                                        textStyle: GoogleFonts.openSans(
                                            color: Colours.wht,
                                            fontSize: 12.sp),
                                        borderRadius:
                                            BorderRadius.circular(30));
                                  },
                                  child: Text(
                                    "Yes",
                                    style: GoogleFonts.openSans(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    "No",
                                    style: GoogleFonts.openSans(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ],
                          ));
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => Colors.red),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ))),
                        child: Center(
                            child: Text(
                          "Remove friend",
                          style: GoogleFonts.openSans(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colours.darkWht),
                        ))));
              }
/*
                                                                            * Cancel Friend Request
*/
              return Container(
                height: 5.h,
                width: 40.w,
                margin: EdgeInsets.symmetric(
                  horizontal: 5.w,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (snapshots.snapshot1.data!['Sender'] == false) {
                      databaseProvider(context, listen: false).acceptFriend(
                        widget.users.id,
                        widget.users['SearchKey'],
                        snapshots.snapshot2.data!['SearchKey'],
                      );
                      BotToast.showText(
                          text:
                              "You and ${widget.users['FullName']} are friends now",
                          duration: const Duration(seconds: 3),
                          animationDuration: const Duration(seconds: 1),
                          clickClose: true,
                          contentColor: Colours.teal,
                          textStyle: GoogleFonts.openSans(
                              color: Colours.wht, fontSize: 12.sp),
                          borderRadius: BorderRadius.circular(30));
                    }
                    if (snapshots.snapshot1.data!['Sender'] == true) {
                      databaseProvider(context, listen: false)
                          .cancelFriend(widget.users.id);
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => col.primaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ))),
                  child: Center(
                      child: snapshots.snapshot1.data!['Sender']
                          ? Text(
                              "Cancel request",
                              style: GoogleFonts.openSans(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: col.hintColor),
                            )
                          : Text(
                              "Accept request",
                              style: GoogleFonts.openSans(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: col.hintColor),
                            )),
                ),
              );
            }
            return SizedBox.shrink();
          }),
    );
  }
}
