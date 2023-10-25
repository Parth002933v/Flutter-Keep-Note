import 'package:flutter/material.dart';
import 'package:flutter_note_taker/common/utils/enums/enums.dart';
import 'package:flutter_note_taker/common/widget/drawer/drawer_button.dart';
import 'package:flutter_note_taker/common/widget/text_widget.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/theme/theme_data.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.isDarkMode,
  });
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: isDarkMode ? DarkThemeData.drawerBackgroundColor : null,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Google image
                Padding(
                  // padding from left of logo

                  padding: EdgeInsets.only(left: 15.w),

                  // Container for resize the logo
                  child: Image.asset(
                    "assets/Google.png",
                    width: 60.spMin,
                    color: isDarkMode ? Colors.white : null,
                    matchTextDirection: true,
                    fit: BoxFit.fitHeight,
                    // alignment: Alignment.center,
                  ),
                ),
                //Text of Keep
                Text(
                  " Keep",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.spMin,
                    color: isDarkMode ? Colors.white : const Color(0xff7c7c7d),
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomDrawerButton(
                  enum_: EnumDrawerItems.notes,
                  label: "Notes",
                  icon: Icon(Icons.lightbulb_outline),
                ),
                const CustomDrawerButton(
                  enum_: EnumDrawerItems.reminder,
                  icon: Icon(Icons.notifications_none_outlined),
                  label: "Reminder",
                ),

                Divider(
                    color: Colors.lightBlueAccent.withOpacity(0.5),
                    thickness: 0.5),

                // Label Text
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text14Normal(text: "Labels", isDarkMode: isDarkMode),
                      TextButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStatePropertyAll(
                            isDarkMode
                                ? DarkThemeData.drawerButton
                                : LightThemeData.drawerButton,
                          ),
                        ),
                        onPressed: () {},
                        child:
                            text14Normal(isDarkMode: isDarkMode, text: "Edit"),
                      )
                    ],
                  ),
                ),

                const CustomDrawerButton(
                  enum_: EnumDrawerItems.dekkd,
                  icon: Icon(Icons.label_outline_rounded),
                  label: "dekkd",
                ),
                const CustomDrawerButton(
                  enum_: EnumDrawerItems.createNewLable,
                  icon: Icon(Icons.add),
                  label: "Create new lable",
                ),

                //Divider
                Divider(
                    color: Colors.lightBlueAccent.withOpacity(0.5),
                    thickness: 0.5),

                const CustomDrawerButton(
                  enum_: EnumDrawerItems.archive,
                  icon: Icon(Icons.archive_outlined),
                  label: "Archive",
                ),
                const CustomDrawerButton(
                  enum_: EnumDrawerItems.delete,
                  icon: Icon(Icons.delete_forever_outlined),
                  label: "Delete",
                ),
                const CustomDrawerButton(
                  enum_: EnumDrawerItems.setting,
                  icon: Icon(Icons.settings_outlined),
                  label: "Setting",
                ),
                const CustomDrawerButton(
                  enum_: EnumDrawerItems.help,
                  icon: Icon(Icons.help_outline),
                  label: "Help & feedback",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
