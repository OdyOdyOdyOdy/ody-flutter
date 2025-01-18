import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/fonts/pretendard_fonts.dart";
import "package:ody_flutter/assets/images/images.dart";
import "package:ody_flutter/components/ody_top_bar.dart";
import "package:ody_flutter/screens/settings/model/notification_setting.dart";
import "package:ody_flutter/screens/settings/model/use_of_service_setting.dart";

final List<NotificationSetting> notificationSettings =
    NotificationSetting.values.cast<NotificationSetting>();
final List<UseOfServiceSetting> useOfServiceSettings =
    UseOfServiceSetting.values.cast<UseOfServiceSetting>();

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(final BuildContext context) => Scaffold(
        backgroundColor: CommonColors.cream,
        body: SafeArea(
          child: Column(
            children: [
              OdyTopBar(
                title: "설정",
                leftIcon: CommonImages.icArrowBack,
                onLeftIcon: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 26),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "알림",
                    style: PretendardFonts.bold18.copyWith(
                      color: CommonColors.gray_600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              for (var i = 0; i < notificationSettings.length; i++)
                Container(
                  margin: const EdgeInsets.only(top: 16, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 30),
                          SvgPicture.asset(notificationSettings[i].icon),
                          const SizedBox(width: 16),
                          Text(
                            notificationSettings[i].description,
                            style: PretendardFonts.medium18.copyWith(
                              color: CommonColors.gray_900,
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 30),
                        child: SizedBox(
                          width: 39,
                          height: 24,
                          child: Switch(
                            value: false,
                            onChanged: null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 14),
              const Divider(
                color: CommonColors.gray_350,
                thickness: 1,
                height: 1,
              ),
              const SizedBox(height: 36),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "서비스 이용",
                    style: PretendardFonts.bold18.copyWith(
                      color: CommonColors.gray_600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 26),
              for (var i = 0; i < useOfServiceSettings.length; i++)
                Container(
                  margin: const EdgeInsets.only(top: 16, bottom: 16),
                  child: Row(
                    children: [
                      const SizedBox(width: 30),
                      SvgPicture.asset(useOfServiceSettings[i].icon),
                      const SizedBox(width: 16),
                      GestureDetector(
                        child: Text(
                          useOfServiceSettings[i].description,
                          style: PretendardFonts.medium18.copyWith(
                            color: CommonColors.gray_900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      );
}
