// ignore_for_file: prefer_const_constructors, file_names,prefer_const_literals_to_create_immutables,library_prefixes
import 'package:beep/Pages/FriendList.dart';
import 'package:beep/Utilities/Constants.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart' as IC;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../Utilities/Colors.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({
    super.key,
  });

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    final col = context.theme;
    return FutureBuilder(
      future: usersRef.doc(currentUser).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ProfileShimmer();
        }

        return ListView.builder(
          itemCount: 1,
          // shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemBuilder: (context, index) {
            return Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
/*
                                                                              * Circle Avatar
*/
                  CircleAvatar(
                    radius: 35.sp,
                    backgroundColor: col.primaryColor,
                    child: Text(
                      snapshot.data!['FullName'].substring(0, 1).toUpperCase(),
                      style: GoogleFonts.openSans(
                          fontSize: 12.sp,
                          color: col.hintColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
/*
                                                                              * User name & Handle
*/
                    Padding(
                      padding: EdgeInsets.only(left: 1.w, right: 1.w),
                      child: Text(
                        snapshot.data!['FullName'],
                        style: GoogleFonts.openSans(
                            fontSize: 13.sp,
                            color: col.hintColor,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5),
                      ),
                    ),
                    if (snapshot.data!['Verified'] == true)
                      Icon(
                        Icons.verified,
                        color: Colours.teal,
                        size: 13.sp,
                      ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 0.5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '@${snapshot.data!['Username']}',
                      style: GoogleFonts.openSans(
                          fontSize: 11.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 1.0),
                    )
                  ],
                ),
              ),
/*
                                                                              * Description
*/
              snapshot.data!['About']['Description'].toString().isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 15.w,
                            ),
                            padding: EdgeInsets.only(top: 3.h),
                            child: Center(
                              child: Text(
                                snapshot.data!['About']['Description'],
                                style: GoogleFonts.openSans(
                                    fontSize: 10.sp,
                                    color: col.hintColor,
                                    wordSpacing: 0.5,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
/*
                                                                              * Occupation
*/

              Padding(
                padding: EdgeInsets.only(top: 3.h),
                child: Row(children: [
                  snapshot.data!['About']['Occupation'].toString().isNotEmpty
                      ? Expanded(
                          child: GestureDetector(
                          onTap: () {
                            BotToast.showText(
                                text: snapshot.data!['About']['Occupation'],
                                duration: const Duration(seconds: 3),
                                animationDuration: const Duration(seconds: 1),
                                clickClose: true,
                                contentColor: col.primaryColor,
                                textStyle: GoogleFonts.openSans(
                                    color: col.hintColor, fontSize: 12.sp),
                                borderRadius: BorderRadius.circular(30));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IC.Octicons.briefcase,
                                color: Colors.grey,
                                size: 14.sp,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                snapshot.data!['About']['Occupation'],
                                style: GoogleFonts.openSans(
                                    fontSize: 10.sp,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ))
                      : SizedBox.shrink(),
/*
                                                                              * Origin
*/
                  snapshot.data!['About']['Origin'].toString().isNotEmpty
                      ? Expanded(
                          child: GestureDetector(
                            onTap: () {
                              BotToast.showText(
                                  text: snapshot.data!['About']['Origin'],
                                  duration: const Duration(seconds: 3),
                                  animationDuration: const Duration(seconds: 1),
                                  clickClose: true,
                                  contentColor: col.primaryColor,
                                  textStyle: GoogleFonts.openSans(
                                      color: col.hintColor, fontSize: 12.sp),
                                  borderRadius: BorderRadius.circular(30));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  IC.Octicons.location,
                                  color: Colors.grey,
                                  size: 14.sp,
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  snapshot.data!['About']['Origin'],
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.openSans(
                                      fontSize: 10.sp,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
/*
                                                                              * Relationship
*/
                  snapshot.data!['About']['Relationship'].toString().isNotEmpty
                      ? Expanded(
                          child: GestureDetector(
                          onTap: () {
                            BotToast.showText(
                                text: snapshot.data!['About']['Relationship'],
                                duration: const Duration(seconds: 3),
                                animationDuration: const Duration(seconds: 1),
                                clickClose: true,
                                contentColor: col.primaryColor,
                                textStyle: GoogleFonts.openSans(
                                    color: col.hintColor, fontSize: 12.sp),
                                borderRadius: BorderRadius.circular(30));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IC.Octicons.heart,
                                color: Colors.grey,
                                size: 14.sp,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                snapshot.data!['About']['Relationship'],
                                style: GoogleFonts.openSans(
                                    fontSize: 10.sp,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ))
                      : SizedBox.shrink()
                ]),
              ),
/*
                                                                              * Friends
*/
              Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => FriendList(friends: snapshot.data!),
                            transition: Transition.rightToLeft,
                            preventDuplicates: true);
                      },
                      child: Column(
                        children: [
                          Text(
                            snapshot.data!['NumFriends'].toString(),
                            style: GoogleFonts.openSans(
                              fontSize: 10.sp,
                              color: col.hintColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Friends",
                            style: GoogleFonts.openSans(
                              fontSize: 10.sp,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ]);
          },
        );
      },
    );
  }
}

/*
                                                                              * Shimmer
*/
class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[400]!,
          highlightColor: Colors.grey[300]!,
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 12.h,
                  width: 30.w,
                  child: CircleAvatar(),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 2.h),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  height: 2.h,
                  width: 20.w,
                  decoration: BoxDecoration(
                    color: context.theme.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(top: 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 2.h,
                    width: 15.w,
                    decoration: BoxDecoration(
                      color: context.theme.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Column(
                  children: [
                    Container(
                      height: 2.h,
                      width: 7.w,
                      decoration: BoxDecoration(
                        color: context.theme.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )
                  ],
                )
              ]),
            )
          ]),
        );
      },
    );
  }
}
