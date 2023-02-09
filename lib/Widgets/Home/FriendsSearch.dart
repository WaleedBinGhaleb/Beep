// ignore_for_file: prefer_const_constructors, file_names,prefer_const_literals_to_create_immutables,library_prefixes
import 'package:beep/Models/UsersModel.dart';
import 'package:beep/Pages/Chat.dart';
import 'package:beep/Pages/UserProfile.dart';
import 'package:beep/Utilities/Colors.dart';
import 'package:beep/Utilities/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart' as IC;
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class FriendsSearch extends StatefulWidget {
  const FriendsSearch({super.key});

  @override
  State<FriendsSearch> createState() => _FriendsSearchState();
}

class _FriendsSearchState extends State<FriendsSearch> {
  @override
  Widget build(BuildContext context) {
    final col = context.theme;
    return Padding(
      padding: EdgeInsets.only(top: 3.h, left: 3.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: usersProvider(context, listen: true).friends,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox.shrink();
              }
              if (snapshot.data!.size == 0) {
                return Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: Icon(
                          IC.FontAwesome5Regular.sad_tear,
                          size: 24.sp,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                "No friends found",
                                style: GoogleFonts.openSans(
                                    fontSize: 14.sp, color: col.hintColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return FutureBuilder(
                      future: usersRef
                          .doc(snapshot.data!.docs[index]['UserId'])
                          .get(),
                      builder: (context, userSnapshot) {
                        if (userSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return FriendSearchShimmer();
                        }
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: 1,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            Users users = Users.fromDoc(userSnapshot.data!);
                            return GFListTile(
                                padding: EdgeInsets.zero,
                                onTap: () {
                                  Get.to(
                                      () => UserProfile(
                                            users: userSnapshot.data!,
                                          ),
                                      transition: Transition.rightToLeft,
                                      preventDuplicates: true);
                                },
                                title: Row(
                                  children: [
                                    Text(
                                      users.name,
                                      style: GoogleFonts.openSans(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: col.hintColor),
                                    ),
                                    if (users.verified == true)
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 0.5.h, left: 2.w),
                                        child: Icon(
                                          Icons.verified,
                                          size: 12.sp,
                                          color: Colours.teal,
                                        ),
                                      )
                                  ],
                                ),
                                subTitle: Text(
                                  '@${users.username}',
                                  style: GoogleFonts.openSans(
                                      fontSize: 12.sp, color: Colors.grey),
                                ),
                                avatar: GFAvatar(
                                  radius: 25.sp,
                                  backgroundColor: col.primaryColor,
                                  child: Text(
                                    users.name.substring(0, 1).toUpperCase(),
                                    style: GoogleFonts.openSans(
                                        fontSize: 12.sp,
                                        color: col.hintColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                icon: IconButton(
                                    splashColor: Colors.transparent,
                                    onPressed: () {
                                      Get.to(
                                          () => Chat(users: userSnapshot.data!),
                                          transition: Transition.rightToLeft,
                                          preventDuplicates: true);
                                    },
                                    icon: Icon(IC.Feather.message_circle)));
                          },
                        );
                      });
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class FriendSearchShimmer extends StatelessWidget {
  const FriendSearchShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[300]!,
            child: GFListTile(
              padding: EdgeInsets.zero,
              avatar: GFAvatar(radius: 25.sp),
              title: Container(
                height: 2.h,
                width: 25.w,
                decoration: BoxDecoration(
                  color: context.theme.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              subTitle: Padding(
                padding: EdgeInsets.only(top: 1.h),
                child: Container(
                  height: 2.h,
                  width: 15.w,
                  decoration: BoxDecoration(
                    color: context.theme.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              icon: CircleAvatar(),
            ),
          );
        });
  }
}
