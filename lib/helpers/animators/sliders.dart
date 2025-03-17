// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/wire/wire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum SwipeDirection {
  next,
  back,
  freeze,
}

/// => TAMAM
abstract class Sliders {
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  // static getPage({
  //   required PageController controller,
  // }){
  //
  //   double getPixelsFromPage(double page) {
  //     return page * viewportDimension * viewportFraction + _initialPageOffset;
  //   }
  //
  // }
  // -----------------------------------------------------------------------------

  /// SLIDE TO

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<int> slideToNextAndGetNewIndex({
    required PageController? pageController,
    required int? numberOfSlides,
    required int currentSlide,
    Duration duration = const Duration(milliseconds: 100),
    Curve curve = Curves.easeOut,
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
    Duration duration = const Duration(milliseconds: 100),
    Curve curve = Curves.easeOut,
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
    required int toIndex,
  }) {

    if (pageController != null) {
      pageController.jumpToPage(
        toIndex,
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
      final double _nextLimit = details.metrics.maxScrollExtent - (_backLimit*2);
      // blog('offset: $_offset : backLimit: $_backLimit : nextLimit: $_nextLimit');

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
      if (controller.hasClients == true){
      await controller.animateTo(
        offset,
        duration: duration,
        curve: curve,
      );
      }
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

      if (duration.inMilliseconds < 50){
        controller.jumpTo(controller.position.maxScrollExtent);
      }
      else {
        await controller.animateTo(
          controller.position.maxScrollExtent,
          duration: duration,
          curve: curve,
        );
      }

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
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogScrollController({
    required ScrollController? controller,
  }){

    blog('Blogging ScrollController =================> START');

    if (controller == null){
      blog('Scroll Controller is null');
    }

    else {

      // controller.offset
      blog('controller.offset : ${controller.offset}');
      // controller.hasClients
      blog('controller.hasClients : ${controller.hasClients}');
      // controller.initialScrollOffset
      blog('controller.initialScrollOffset : ${controller.initialScrollOffset}');
      // controller.keepScrollOffset
      blog('controller.keepScrollOffset : ${controller.keepScrollOffset}');
      // controller.positions.length
      blog('controller.positions.length : ${controller.positions.length}');
      // controller.hasListeners
      blog('controller.hasListeners : ${controller.hasListeners}');
      // controller.position.keepScrollOffset
      blog('controller.position.keepScrollOffset : ${controller.position.keepScrollOffset}');
      // controller.position.isScrollingNotifier.value
      blog('controller.position.isScrollingNotifier.value : ${controller.position.isScrollingNotifier.value}');
      // controller.position.activity.delegate.axisDirection
      blog('controller.position.activity.delegate.axisDirection : ${controller.position.activity?.delegate.axisDirection}');
      // controller.position.activity.isScrolling
      blog('controller.position.activity.isScrolling : ${controller.position.activity?.isScrolling}');
      // controller.position.activity.shouldIgnorePointer
      blog('controller.position.activity.shouldIgnorePointer : ${controller.position.activity?.shouldIgnorePointer}');
      // controller.position.activity.velocity
      blog('controller.position.activity.velocity : ${controller.position.activity?.velocity}');
      // controller.position.devicePixelRatio
      blog('controller.position.devicePixelRatio : ${controller.position.devicePixelRatio}');
      // controller.position.allowImplicitScrolling
      blog('controller.position.allowImplicitScrolling : ${controller.position.allowImplicitScrolling}');
      // controller.position.hasContentDimensions
      blog('controller.position.hasContentDimensions : ${controller.position.hasContentDimensions}');
      // controller.position.hasPixels
      blog('controller.position.hasPixels : ${controller.position.hasPixels}');
      // controller.position.hasViewportDimension
      blog('controller.position.hasViewportDimension : ${controller.position.hasViewportDimension}');
      // controller.position.haveDimensions
      blog('controller.position.haveDimensions : ${controller.position.haveDimensions}');
      // controller.position.maxScrollExtent
      blog('controller.position.maxScrollExtent : ${controller.position.maxScrollExtent}');
      // controller.position.minScrollExtent
      blog('controller.position.minScrollExtent : ${controller.position.minScrollExtent}');
      // controller.position.extentAfter
      blog('controller.position.extentAfter : ${controller.position.extentAfter}');
      // controller.position.extentBefore
      blog('controller.position.extentBefore : ${controller.position.extentBefore}');
      // controller.position.extentInside
      blog('controller.position.extentInside : ${controller.position.extentInside}');
      // controller.position.extentTotal
      blog('controller.position.extentTotal : ${controller.position.extentTotal}');
      // controller.position.viewportDimension
      blog('controller.position.viewportDimension : ${controller.position.viewportDimension}');
      // controller.position.axisDirection
      blog('controller.position.axisDirection : ${controller.position.axisDirection}');
      // controller.position.axis
      blog('controller.position.axis : ${controller.position.axis}');
      // controller.position.userScrollDirection
      blog('controller.position.userScrollDirection : ${controller.position.userScrollDirection}');
      // controller.position.atEdge
      blog('controller.position.atEdge : ${controller.position.atEdge}');
      // controller.position.pixels
      blog('controller.position.pixels : ${controller.position.pixels}');
      // controller.position.outOfRange
      blog('controller.position.outOfRange : ${controller.position.outOfRange}');

    }

    blog('Blogging ScrollController =================> END');

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
  /*
  /// TESTED : WORKS PERFECT
  static void createPaginationListener({
    required ScrollController? controller,
    required ValueNotifier<bool> isPaginating,
    required ValueNotifier<bool> canKeepReading,
    required Future<void> Function()? onPaginate,
    required bool mounted,
  }){

    if (controller != null){

      controller.addListener(() => paginationListener(
        controller: controller,
        isPaginating: isPaginating,
        canKeepReading: canKeepReading,
        onPaginate: onPaginate,
        mounted: mounted,
      ));

    }

  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> paginationListener({
    required ScrollController? controller,
    required ValueNotifier<bool> isPaginating,
    required ValueNotifier<bool> canKeepReading,
    required Future<void> Function()? onPaginate,
    required bool mounted,
  }) async {

    if (controller != null){

      final bool _canPaginate = Sliders.canPaginate(
        scrollController: controller,
        isPaginating: isPaginating.value,
        canKeepReading: canKeepReading.value,
        paginationHeight: 100,
      );

      if (_canPaginate == true){

        isPaginating.set(mounted: mounted, value: true);

        if (onPaginate != null){
          await onPaginate.call();
        }

        isPaginating.set(mounted: mounted, value: false);

      }
    }

  }
  // -----------------------------------------------------------------------------
}
