import "package:flutter/cupertino.dart";
import "package:injectable/injectable.dart";
import "package:ody_flutter/data/entity/gathering/gathering_request.dart";
import "package:ody_flutter/domain/model/location.dart";
import "package:ody_flutter/domain/model/new_gathering.dart";
import "package:ody_flutter/domain/repository/gathering_repository.dart";
import "package:ody_flutter/screens/base/base_view_model.dart";

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

@injectable
class GatheringCreatorViewModel extends BaseViewModel {
  GatheringCreatorViewModel(this._gatheringRepository) {
    _init();
  }

  final GatheringRepository _gatheringRepository;
  NewGathering? gathering;

  final pageController = PageController();

  final ValueNotifier<String> text = ValueNotifier("");
  final ValueNotifier<DateTime> date = ValueNotifier(DateTime.now());
  final ValueNotifier<int> hour = ValueNotifier(0);
  final ValueNotifier<int> minute = ValueNotifier(0);
  final ValueNotifier<String> locationText = ValueNotifier("");
  final ValueNotifier<bool> isConfirmEnabled = ValueNotifier(false);

  LocationModel location = LocationModel.init();
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

    for (final notifier in [hour, minute]) {
      notifier.addListener(_checkIfConfirmEnabled);
    }
  }

  @override
  Future<void> dispose() async {
    pageController.dispose();
    text.dispose();
    date.dispose();
    hour.dispose();
    minute.dispose();
    locationText.dispose();
    isConfirmEnabled.dispose();
    await super.dispose();
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
    if (_currentScreenType == GatheringCreatorScreenType.time) {
      final now = DateTime.now();
      final selectedDateTime = DateTime(
        date.value.year,
        date.value.month,
        date.value.day,
        hour.value,
        minute.value,
      );

      if (!selectedDateTime.isAfter(now)) {
        final selectedDateOnly =
            DateTime(date.value.year, date.value.month, date.value.day);
        final todayDateOnly = DateTime(now.year, now.month, now.day);
        if (selectedDateOnly.isBefore(todayDateOnly)) {
          showSnackBar("오늘 이후의 날짜를 선택해 주세요!");
        } else {
          showSnackBar("현재 이후의 시간을 선택해 주세요!");
        }
        return;
      }
    }

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
      targetLatitude: "${location.latitude}",
      targetLongitude: "${location.longitude}",
    );

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
      case GatheringCreatorScreenType.time:
        final now = DateTime.now();
        final selectedDateTime = DateTime(
          date.value.year,
          date.value.month,
          date.value.day,
          hour.value,
          minute.value,
        );
        isConfirmEnabled.value = selectedDateTime.isAfter(now);
      case GatheringCreatorScreenType.location:
        isConfirmEnabled.value = locationText.value.isNotEmpty;
      default:
        isConfirmEnabled.value = true;
    }
    notifyListeners();
  }
}
