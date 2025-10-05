import "package:flutter/material.dart";
import "package:ody_flutter/assets/colors/colors.dart";
import "package:ody_flutter/screens/base/base_view_model.dart";

class BaseScreen<T extends BaseViewModel> extends StatelessWidget {

  const BaseScreen({
    required this.viewModel, required this.builder, super.key,
  });
  final T viewModel;
  final Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context) => ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) => Stack(
          children: [
            builder(context),
            if (viewModel.isLoading)
              ColoredBox(
                color: Colors.black.withValues(alpha: 0.5),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: CommonColors.purple_800,
                  ),
                ),
              ),
          ],
        ),
    );
}
