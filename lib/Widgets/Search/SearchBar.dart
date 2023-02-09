// ignore_for_file: prefer_const_constructors, file_names,prefer_const_literals_to_create_immutables,library_prefixes
import 'package:beep/Utilities/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart' as IC;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class SearchBar extends StatelessWidget {
  SearchBar({super.key});
  final FocusNode _node = FocusNode();

  @override
  Widget build(BuildContext context) {
    final col = context.theme;
    return Row(
      children: [
        Expanded(
          child: Container(
            width: 100.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: col.primaryColor,
            ),
            child: TextField(
              focusNode: _node,
              controller:
                  usersProvider(context, listen: false).searchController,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.none,
              textAlign: TextAlign.left,
              style: GoogleFonts.openSans(color: col.hintColor),
              showCursor: true,
              autofocus: false,
              cursorColor: col.hintColor,
              decoration: InputDecoration(
                  hintText: "Search for a user",
                  hintStyle: GoogleFonts.openSans(color: Colors.grey),
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    IC.Feather.search,
                    color: col.hintColor,
                    size: 17.sp,
                  ),
                  suffixIcon: usersProvider(context, listen: true).users != null
                      ? IconButton(
                          icon: Icon(IC.Feather.x,
                              size: 24.sp, color: col.hintColor),
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onPressed: () {
                            usersProvider(context, listen: false).clearSearch();
                          },
                        )
                      : null),
              onChanged: (input) {
                if (input.isNotEmpty) {
                  usersProvider(context, listen: false).search(
                      context,
                      input.toLowerCase(),
                      FirebaseAuth.instance.currentUser!.uid);
                } else {
                  usersProvider(context, listen: false).clearSearch();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
