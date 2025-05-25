import "package:flutter/cupertino.dart";
import "package:ody_flutter/data/entity/gathering/gathering_request.dart";
import "package:ody_flutter/domain/model/gathering.dart";
import "package:ody_flutter/domain/repository/gathering_repository.dart";

enum GatheringCreatorScreenType {
  title(0),
  date(1),
  time(2),
  location(3);

  const GatheringCreatorScreenType(this.customIndex);

  final int customIndex;

  static GatheringCreatorScreenType fromIndex(int? index) =>
      GatheringCreatorScreenType.values.firstWhere(
        (e) => e.customIndex == index,
      );
}

class GatheringCreatorViewModel extends ChangeNotifier {
  GatheringCreatorViewModel(this._gatheringRepository) {
    _init();
  }

  final GatheringRepository _gatheringRepository;
  Gathering? gathering;

  final pageController = PageController();

  final ValueNotifier<String> text = ValueNotifier("");
  final ValueNotifier<DateTime> date = ValueNotifier(DateTime.now());
  final ValueNotifier<int> hour = ValueNotifier(0);
  final ValueNotifier<int> minute = ValueNotifier(0);
  final ValueNotifier<String> locationText = ValueNotifier("");
  final ValueNotifier<bool> isConfirmEnabled = ValueNotifier(false);

  String targetLatitude = "";
  String targetLongitude = "";
  bool isGoingPrevious = false;

  GatheringCreatorScreenType _currentScreenType =
      GatheringCreatorScreenType.title;
  GatheringCreatorScreenType get currentScreenType => _currentScreenType;

  void _init() {
    pageController.addListener(() {
      final currentPageIndex = pageController.page ?? 0;

      if (GatheringCreatorScreenType.values
          .any((e) => e.customIndex == currentPageIndex)) {
        isGoingPrevious = false;
        setCurrentScreenType(currentPageIndex.toInt());
        _checkIfConfirmEnabled();
      }

      if (isGoingPrevious !=
          (currentPageIndex <= _currentScreenType.customIndex)) {
        isGoingPrevious = currentPageIndex <= _currentScreenType.customIndex;
        notifyListeners();
      }
    });

    text.addListener(() {
      isConfirmEnabled.value = text.value.isNotEmpty;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    text.dispose();
    date.dispose();
    hour.dispose();
    minute.dispose();
    locationText.dispose();
    isConfirmEnabled.dispose();
    super.dispose();
  }

  void setCurrentScreenType(int? index) {
    _currentScreenType = GatheringCreatorScreenType.fromIndex(index);
  }

  Future<void> goToPreviousPage() async {
    await pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> goToNextPage() async {
    await pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> createGathering() async {
    final GatheringRequest request = GatheringRequest(
      name: text.value,
      date: _dateToString(),
      time: _timeToString(),
      targetAddress: locationText.value,
      targetLatitude: targetLatitude,
      targetLongitude: targetLongitude,
    );

    debugPrint("""
=== [CreateGathering] =========================================
🚀 Request Info:
  • name: ${request.name}
  • date: ${request.date}
  • time: ${request.time}
  • address: ${request.targetAddress}
  • latitude: ${request.targetLatitude}
  • longitude: ${request.targetLongitude}
============================================================
""");

    gathering = await _gatheringRepository.createGathering(request);
  }

  String _dateToString() {
    final String dateString = date.value.toString().split(" ")[0];
    return dateString;
  }

  String _timeToString() {
    final String hourString = hour.value.toString().padLeft(2, "0");
    final String minuteString = minute.value.toString().padLeft(2, "0");
    return "$hourString:$minuteString";
  }

  void _checkIfConfirmEnabled() {
    switch (_currentScreenType) {
      case GatheringCreatorScreenType.title:
        isConfirmEnabled.value = text.value.isNotEmpty;
      case GatheringCreatorScreenType.location:
        isConfirmEnabled.value = locationText.value.isNotEmpty;
      default:
        isConfirmEnabled.value = true;
    }
    notifyListeners();
  }
}
