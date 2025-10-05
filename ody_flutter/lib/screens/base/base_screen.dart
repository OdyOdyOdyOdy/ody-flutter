import "dart:async";

import "package:flutter/material.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/assets/fonts/pretendard_fonts.dart";
import "package:ody_flutter/screens/base/base_view_model.dart";

class BaseScreen<T extends BaseViewModel> extends StatefulWidget {
  const BaseScreen({
    required this.viewModel,
    required this.builder,
    super.key,
  });

  final T viewModel;
  final Widget Function(BuildContext context) builder;

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState<T extends BaseViewModel> extends State<BaseScreen<T>> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  StreamSubscription<String>? _snackBarSubscription;

  @override
  void initState() {
    super.initState();
    _snackBarSubscription = widget.viewModel.snackBarStream.listen((message) {
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: PretendardFonts.regular14.copyWith(
              color: CommonColors.cream,
            ),
          ),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(bottom: 12, left: 8, right: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: CommonColors.gray_850,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) => ScaffoldMessenger(
        key: _scaffoldMessengerKey,
        child: ListenableBuilder(
          listenable: widget.viewModel,
          builder: (context, child) => Stack(
            children: [
              widget.builder(context),
              if (widget.viewModel.isLoading)
                const ColoredBox(
                  color: Colors.black54,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: CommonColors.purple_800,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );

  @override
  Future<void> dispose() async {
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    await _snackBarSubscription?.cancel();
    super.dispose();
  }
}
