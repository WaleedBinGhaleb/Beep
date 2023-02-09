// ignore_for_file: prefer_const_constructors, file_names,prefer_const_literals_to_create_immutables,library_prefixes
import 'package:beep/Pages/ChangeTheme.dart';
import 'package:beep/Pages/EditProfile.dart';
import 'package:beep/Utilities/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart' as IC;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

class BottomSheetMenu extends StatelessWidget {
  const BottomSheetMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final col = context.theme;
    return Padding(
      padding: EdgeInsets.only(right: 3.w),
      child: IconButton(
          splashColor: Colors.transparent,
          onPressed: () => showCupertinoModalBottomSheet(
              expand: false,
              useRootNavigator: true,
              backgroundColor: col.primaryColor,
              context: context,
              builder: (context) => Padding(
                    padding: EdgeInsets.only(top: 0.5.h),
                    child: Container(
                      height: 30.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15.0),
                            topLeft: Radius.circular(15.0)),
                        color: col.primaryColor,
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 0.5.h,
                            width: 7.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: col.hintColor,
                            ),
                          ),
/*
                                                                                * Edit Profile
*/
                          Padding(
                              padding: EdgeInsets.only(top: 3.h, left: 1.w),
                              child: SizedBox(
                                width: 100.w,
                                child: ElevatedButton.icon(
                                  label: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Edit profile",
                                      style: GoogleFonts.openSans(
                                          color: col.hintColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.sp),
                                    ),
                                  ),
                                  icon: Icon(
                                    IC.MaterialIcons.edit,
                                    color: col.hintColor,
                                  ),
                                  style: ButtonStyle(
                                      elevation:
                                          MaterialStateProperty.resolveWith(
                                              (states) => 0.0),
                                      backgroundColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) => col.primaryColor),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ))),
                                  onPressed: () {
                                    Get.back();
                                    Get.to(() => EditProfile(),
                                        transition: Transition.rightToLeft,
                                        preventDuplicates: true);
                                  },
                                ),
                              )),
/*
                                                                                * Change Theme button
*/
                          Padding(
                              padding: EdgeInsets.only(top: 1.h, left: 1.w),
                              child: SizedBox(
                                width: 100.w,
                                child: ElevatedButton.icon(
                                  label: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Change theme",
                                      style: GoogleFonts.openSans(
                                          color: col.hintColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.sp),
                                    ),
                                  ),
                                  icon: Icon(
                                    IC.MaterialCommunityIcons.theme_light_dark,
                                    color: col.hintColor,
                                  ),
                                  style: ButtonStyle(
                                      elevation:
                                          MaterialStateProperty.resolveWith(
                                              (states) => 0.0),
                                      backgroundColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) => col.primaryColor),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ))),
                                  onPressed: () {
                                    Get.back();
                                    Get.to(() => ChangeTheme(),
                                        transition: Transition.rightToLeft,
                                        preventDuplicates: true);
                                  },
                                ),
                              )),
/*
                                                                                * Logout
*/
                          Padding(
                              padding: EdgeInsets.only(top: 1.h, left: 1.w),
                              child: SizedBox(
                                width: 100.w,
                                child: ElevatedButton.icon(
                                  label: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Logout",
                                      style: GoogleFonts.openSans(
                                          color: col.hintColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.sp),
                                    ),
                                  ),
                                  icon: Icon(
                                    IC.MaterialIcons.logout,
                                    color: col.hintColor,
                                  ),
                                  style: ButtonStyle(
                                      elevation:
                                          MaterialStateProperty.resolveWith(
                                              (states) => 0.0),
                                      backgroundColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) => col.primaryColor),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ))),
                                  onPressed: () {
                                    Get.back();
                                    authServiceProvider(context, listen: false)
                                        .signOut();
                                  },
                                ),
                              )),
                        ],
                      ),
                    ),
                  )),
          icon: Icon(
            IC.Entypo.dots_three_horizontal,
            color: col.hintColor,
            size: 18.sp,
          )),
    );
  }
}
