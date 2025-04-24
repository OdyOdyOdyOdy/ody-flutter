import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/fonts/pretendard_fonts.dart";
import "package:ody_flutter/assets/images/images.dart";
import "package:ody_flutter/components/ody_alert.dart";
import "package:ody_flutter/components/ody_top_bar.dart";
import "package:ody_flutter/config/routes.dart";
import "package:ody_flutter/data/db/service/auth_token_service.dart";
import "package:ody_flutter/data/network/base/base_service.dart";
import "package:ody_flutter/data/network/service/auth_service.dart";
import "package:ody_flutter/data/repository/auth_repository_impl.dart";
import "package:ody_flutter/screens/settings/model/notification_setting.dart";
import "package:ody_flutter/screens/settings/model/use_of_service_setting.dart";
import "package:ody_flutter/screens/settings/settings_navigate_action.dart";
import "package:ody_flutter/screens/settings/settings_view_model.dart";
import "package:webview_flutter/webview_flutter.dart";

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
  late final SettingViewModel _viewModel;
  bool _showWebView = false;
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _viewModel = SettingViewModel(
        AuthRepositoryImpl(AuthService(BaseService()), AuthTokenService()),
    );
    _viewModel.navigation.addListener(_onNavigationChanged);
    _webViewController = WebViewController();
  }

  Future<void> _onNavigationChanged() async {
    final action = _viewModel.navigation.value;
    if (action != null) {
      if (action is NavigateToLogin) {
        await Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.login,
          (route) => false,
        );
      }
      // 다른 액션에 대한 처리도 추가 가능
    }
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        backgroundColor: CommonColors.cream,
        body: SafeArea(
          child: _showWebView
              ? Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: _handleWebViewBack,
                    ),
                    backgroundColor: CommonColors.white,
                  ),
                  body: WebViewWidget(controller: _webViewController),
                )
              : Column(
                  children: [
                    OdyTopBar(
                      title: "설정",
                      leftIcon: CommonImages.icArrowBack,
                      onLeftIcon: () => Navigator.pop(context),
                    ),
                    const SizedBox(height: 26),
                    _buildNotificationSettings(),
                    const SizedBox(height: 14),
                    const Divider(
                      color: CommonColors.gray_350,
                      thickness: 1,
                      height: 1,
                    ),
                    const SizedBox(height: 36),
                    _buildServiceSettings(),
                  ],
                ),
        ),
      );

  Widget _buildNotificationSettings() => Column(
        children: [
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
          for (final setting in notificationSettings)
            Container(
              margin: const EdgeInsets.only(top: 16, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 30),
                      SvgPicture.asset(setting.icon),
                      const SizedBox(width: 16),
                      Text(
                        setting.description,
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
        ],
      );

  Widget _buildServiceSettings() => Column(
        children: [
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
          for (final setting in useOfServiceSettings)
            Container(
              margin: const EdgeInsets.only(top: 16, bottom: 16),
              child: Row(
                children: [
                  const SizedBox(width: 30),
                  SvgPicture.asset(setting.icon),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () async => _handleServiceItemTap(setting),
                    child: Text(
                      setting.description,
                      style: PretendardFonts.medium18.copyWith(
                        color: CommonColors.gray_900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      );

  Future<void> _handleServiceItemTap(UseOfServiceSetting setting) async {
    switch (setting.useOfServiceType) {
      case UseOfServiceType.privacyPolicy:
        _handleWebViewBack();
        await _webViewController.loadRequest(
          Uri.parse(
            "https://sly-face-106.notion.site/fecbe589eb23471ba2d0685cb3c2d274?pvs=4",
          ),
        );
      case UseOfServiceType.term:
        _handleWebViewBack();
        await _webViewController.loadRequest(
          Uri.parse(
            "https://sly-face-106.notion.site/beb204b6e6724ecbbb83496448fc7b53?pvs=4",
          ),
        );
      case UseOfServiceType.logout:
      case UseOfServiceType.withdraw:
        await showDialog(
          context: context,
          builder: (context) => OdyAlert(
            image: CommonImages.icSadOdy,
            title: "정말 오디를 떠나시겠어요?",
            description: "참여한 약속들이 모두 사라져요.",
            confirmText: "탈퇴",
            onConfirm: () => _viewModel.appleWithdrawal(),
          ),
        );
    }
  }

  void _handleWebViewBack() {
    setState(() {
      _showWebView = !_showWebView;
    });
  }
}
