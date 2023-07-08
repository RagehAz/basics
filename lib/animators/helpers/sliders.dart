import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum SwipeDirection {
  next,
  back,
  freeze,
}

/// => TAMAM
class Sliders {
  // -----------------------------------------------------------------------------

  const Sliders();

  // -----------------------------------------------------------------------------

  /// SLIDE TO

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<int> slideToNextAndGetNewIndex({
    required PageController? pageController,
    required int? numberOfSlides,
    required int currentSlide,
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.easeInOutCirc,
  }) async {

    if ((currentSlide + 1 == numberOfSlides) || pageController == null) {
      // blog('Can not slide forward');
      return currentSlide;
    }

    else {

      await pageController.animateToPage(currentSlide + 1,
          duration: duration,
          curve: curve
      );

      return currentSlide + 1;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<int> slideToBackAndGetNewIndex({
    required PageController? pageController,
    required int currentSlide,
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.easeInOutCirc,
  }) async {

    /// this checks if its the first slide, it won't change index and won't slide, otherwise
    /// will slide back and return decreased index

    if (currentSlide == 0 || pageController == null) {
      // blog('can not slide back');
      return currentSlide;
    }

    else {

      await pageController.animateToPage(currentSlide - 1,
          duration: duration,
          curve: curve,
      );

      return currentSlide - 1;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> slideToNext({
    required PageController? pageController,
    required int numberOfSlides,
    required int currentSlide,
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.easeInOutCirc,
  }) async {

    if (pageController != null) {
      await pageController.animateToPage(
        currentSlide + 1,
        duration: duration,
        curve: curve,
      );
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> slideToBackFrom({
    required PageController? pageController,
    required int currentSlide,
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.easeInOutCirc,
  }) async {

    if (currentSlide == 0 || pageController == null) {
      // blog('can not slide back');
    }

    else {
      await pageController.animateToPage(
        currentSlide - 1,
        duration: duration,
        curve: curve,
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> slideToIndex({
    required PageController? pageController,
    required int? toIndex,
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeInOutCirc,
  }) async {

    if (pageController != null && toIndex != null) {

      await pageController.animateToPage(toIndex,
          duration: duration,
          curve: curve,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> slideToOffset({
  required ScrollController? scrollController,
    required double? offset,
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeInOutCirc,
}) async {

    if (scrollController != null && offset != null) {

      if (scrollController.hasClients == true && scrollController.offset != offset) {

        await scrollController.animateTo(offset,
            duration: duration, curve: curve
        );

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// SNAP TO

  // --------------------
  /// TESTED : WORKS PERFECT
  static void snapTo({
    required PageController? pageController,
    required int currentSlide
  }) {

    if (pageController != null) {
      pageController.jumpToPage(
        currentSlide,
      );
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
    static void snapToBack(PageController slidingController, int currentSlide) {

    if (currentSlide == 0){
      blog('can not slide back');
    }

    else {
      slidingController.jumpToPage(currentSlide - 1);
    }
  }
  // -----------------------------------------------------------------------------

  /// CONCLUDERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static SwipeDirection slidingDecision(int numberOfSlides, int currentSlide) {

    if (numberOfSlides == 0){
      return SwipeDirection.freeze;
    }
    else if (numberOfSlides == 1){
      return SwipeDirection.freeze;
    }
    else if (numberOfSlides > 1 && currentSlide + 1 == numberOfSlides){
      return SwipeDirection.back;
    }
    else if (numberOfSlides > 1 && currentSlide == 0){
      return SwipeDirection.next;
    }
    else {
      return SwipeDirection.back;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> slidingAction({
    required PageController slidingController,
    required int numberOfSlides,
    required int currentSlide,
  }) async {

    // blog('i: $currentSlide || #: $numberOfSlides || -> before slidingAction');

    final SwipeDirection _direction = slidingDecision(numberOfSlides, currentSlide);

    if (_direction == SwipeDirection.next){
      await slideToNext(
          pageController: slidingController,
          numberOfSlides: numberOfSlides,
          currentSlide: currentSlide
      );
    }

    else if (_direction == SwipeDirection.back){
      await slideToBackFrom(
          pageController: slidingController,
          currentSlide: currentSlide
      );
    }
    else if (_direction == SwipeDirection.freeze){
      await slideToIndex(
          pageController: slidingController,
          toIndex: currentSlide
      );
    }
    else {
      // blog('no sliding possible ');
    }

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkIsAtTop(ScrollController? scrollController) {
    if (scrollController == null) {
      return false;
    }
    else {
      return scrollController.offset == scrollController.position.minScrollExtent;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkIsAtBottom(ScrollController? scrollController) {
    if (scrollController == null){
      return false;
    }
    else {
      return scrollController.offset == scrollController.position.maxScrollExtent;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool? checkIsGoingDown(ScrollController? scrollController) {
    bool? _goingDown;

    if (scrollController != null) {
        _goingDown = scrollController.position.userScrollDirection ==
            ScrollDirection.forward;
    }

    return _goingDown;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkIsGoingUp(ScrollController scrollController) {
    return scrollController.position.userScrollDirection == ScrollDirection.reverse;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkIsAtPercentFromTop({
    required ScrollController? scrollController,
    required double percent,
    required double maxHeight,
  }) {
    bool _output = false;

    if (scrollController != null) {
      final double _min = scrollController.position.minScrollExtent;
      final double _max = maxHeight; //scrollController.position.maxScrollExtent;
      final double _fraction = percent / 100;
      _output = scrollController.offset <= (_min + (_max * _fraction));
    }
    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkCanSlide({
    required ScrollUpdateNotification? details,
    required double boxDistance,
    required bool goesBackOnly,
    required Axis axis,
    int numberOfBoxes = 2,
    double slideLimitRatio = 0.2,
  }) {

    if (details == null) {
      return false;
    }

    else {
      final double _offset = details.metrics.pixels;
      final double _limitRatio = slideLimitRatio;
      final double _backLimit = boxDistance * _limitRatio * (-1);
      final double _nextLimit = (boxDistance * (numberOfBoxes - 1)) + (_backLimit * (-1));

      if (details.metrics.axis != axis) {
        return false;
      }

      else if (goesBackOnly == true) {
        return _offset < _backLimit;
      }

      else {
        return _offset < _backLimit || _offset > _nextLimit;
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// SCROLL TO

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> scrollTo({
    required ScrollController? controller,
    required double offset,
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeInOutCirc,
  }) async {

    if (controller != null) {
      // if (controller.positions.isEmpty == true){
      await controller.animateTo(
        offset,
        duration: duration,
        curve: curve,
      );
      // }
    }

  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> scrollToEnd({
    required ScrollController? controller,
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeInOutCirc,
  }) async {
    if (controller != null) {
      await controller.animateTo(
        controller.position.maxScrollExtent,
        duration: duration,
        curve: curve,
      );
    }
  }

  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> scrollToTop({
    required ScrollController controller,
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeInOutCirc,
  }) async {

    await controller.animateTo(controller.position.minScrollExtent,
      duration: duration,
      curve: curve,
    );

  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogScrolling({
    required ScrollController scrollController,
    required double paginationHeight,
    required bool isPaginating,
    required bool canKeepReading,
  }) {

    final double max = scrollController.position.maxScrollExtent;
    final double current = scrollController.position.pixels;

    final bool _canPaginate = canPaginate(
      scrollController: scrollController,
      paginationHeight: paginationHeight,
      isPaginating: isPaginating,
      canKeepReading: canKeepReading,
    );

    final double? _max = Numeric.roundFractions(max, 1);
    final double? _current = Numeric.roundFractions(current, 1);
    final double? _diff = Numeric.roundFractions(max-current, 1);
    blog('SHOULD LOAD : (max $_max - current $_current) = $_diff : canPaginate $_canPaginate');

  }
  // -----------------------------------------------------------------------------

  /// PAGINATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool canPaginate({
    required ScrollController? scrollController,
    required double paginationHeight,
    required bool isPaginating,
    required bool canKeepReading,
  }){

    if (isPaginating == true || scrollController == null){
      return false;
    }
    else if (canKeepReading == false){
      return false;
    }
    else {

      final double max = scrollController.position.maxScrollExtent;
      final double current = scrollController.position.pixels;

      return max - current <= paginationHeight;

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void createPaginationListener({
    required ScrollController? controller,
    required ValueNotifier<bool> isPaginating,
    required ValueNotifier<bool> canKeepReading,
    required Future<void> Function()? onPaginate,
    required bool mounted,
  }){

    if (controller != null){

      controller.addListener(() async {

      final bool _canPaginate = Sliders.canPaginate(
        scrollController: controller,
        isPaginating: isPaginating.value,
        canKeepReading: canKeepReading.value,
        paginationHeight: 100,
      );

      // Scrollers.blogScrolling(
      //   scrollController: controller,
      //   isPaginating: isPaginating.value,
      //   canKeepReading: canKeepReading.value,
      //   paginationHeight: 0,
      // );

      if (_canPaginate == true){

        setNotifier(
            notifier: isPaginating,
            mounted: mounted,
            value: true,
        );

        if (onPaginate != null){
          await onPaginate.call();
        }

        setNotifier(
          notifier: isPaginating,
          mounted: mounted,
          value: false,
        );

      }

    });

    }

  }
  // -----------------------------------------------------------------------------
}
