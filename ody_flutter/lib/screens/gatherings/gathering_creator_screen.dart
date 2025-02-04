import "package:flutter/material.dart";
import "package:ody_flutter/data/network/base/base_service.dart";
import "package:ody_flutter/data/network/service/gathering_service_impl.dart";
import "package:ody_flutter/data/repository/gathering_repository_impl.dart";
import "package:ody_flutter/screens/gatherings/gathering_creator_view_model.dart";

class GatheringCreatorScreen extends StatelessWidget {
  GatheringCreatorScreen({super.key});

  // 추후에 주입 필요
  final _viewModel = GatheringCreatorViewModel(
    GatheringRepositoryImpl(GatheringService(BaseService())),
  );

  @override
  Widget build(final BuildContext context) => ListenableBuilder(
        listenable: _viewModel,
        builder: (BuildContext context, Widget? child) => ElevatedButton(
          onPressed: () async {
            // await _viewModel.createGathering(Gathering());
          },
          child: Text(_viewModel.gathering?.name?.toString() ?? "No Name"),
        ),
      );
}
