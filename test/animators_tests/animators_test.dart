import 'package:basics/animators/helpers/animators.dart';
import 'package:basics/animators/helpers/sliders.dart';
import 'package:flutter_test/flutter_test.dart';

/*
for the following flutter method, write group of test methods in one test group to assure its
perfectly working
 */

void main() {
// -----------------------------------------------------------------------------

  /// getSwipeDirection

// --------------------
  group('Animators.getSwipeDirection tests', () {
    test('Should return SwipeDirection.next when newIndex > oldIndex', () {
      // Arrange
      const oldIndex = 2;
      const newIndex = 5;

      // Act
      final swipeDirection = Animators.getSwipeDirection(oldIndex: oldIndex, newIndex: newIndex);

      // Assert
      expect(swipeDirection, SwipeDirection.next);
    });

    test('Should return SwipeDirection.back when newIndex < oldIndex', () {
      // Arrange
      const oldIndex = 5;
      const newIndex = 2;

      // Act
      final swipeDirection = Animators.getSwipeDirection(oldIndex: oldIndex, newIndex: newIndex);

      // Assert
      expect(swipeDirection, SwipeDirection.back);
    });

    test('Should return SwipeDirection.freeze when newIndex == oldIndex', () {
      // Arrange
      const oldIndex = 5;
      const newIndex = 5;

      // Act
      final swipeDirection = Animators.getSwipeDirection(oldIndex: oldIndex, newIndex: newIndex);

      // Assert
      expect(swipeDirection, SwipeDirection.freeze);
    });

    test('Should return SwipeDirection.next when newIndex == oldIndex + 1', () {
      // Arrange
      const oldIndex = 2;
      const newIndex = 3;

      // Act
      final swipeDirection = Animators.getSwipeDirection(oldIndex: oldIndex, newIndex: newIndex);

      // Assert
      expect(swipeDirection, SwipeDirection.next);
    });

    test('Should return SwipeDirection.back when newIndex == oldIndex - 1', () {
      // Arrange
      const oldIndex = 5;
      const newIndex = 4;

      // Act
      final swipeDirection = Animators.getSwipeDirection(oldIndex: oldIndex, newIndex: newIndex);

      // Assert
      expect(swipeDirection, SwipeDirection.back);
    });

    test('Should return SwipeDirection.freeze when oldIndex and newIndex are both zero', () {
      // Arrange
      const oldIndex = 0;
      const newIndex = 0;

      // Act
      final swipeDirection = Animators.getSwipeDirection(oldIndex: oldIndex, newIndex: newIndex);

      // Assert
      expect(swipeDirection, SwipeDirection.freeze);
    });

    test('Should return SwipeDirection.next when oldIndex is negative and newIndex is positive',
        () {
      // Arrange
      const oldIndex = -2;
      const newIndex = 2;

      // Act
      final swipeDirection = Animators.getSwipeDirection(oldIndex: oldIndex, newIndex: newIndex);

      // Assert
      expect(swipeDirection, SwipeDirection.next);
    });

    test('Should return SwipeDirection.back when oldIndex is positive and newIndex is negative',
        () {
      // Arrange
      const oldIndex = 5;
      const newIndex = -3;

      // Act
      final swipeDirection = Animators.getSwipeDirection(oldIndex: oldIndex, newIndex: newIndex);

      // Assert
      expect(swipeDirection, SwipeDirection.back);
    });

    test('Should return SwipeDirection.freeze if oldIndex is null', () {
      // Arrange
      const oldIndex = null;
      const newIndex = 5;

      // Act
      final swipeDirection = Animators.getSwipeDirection(oldIndex: oldIndex, newIndex: newIndex);

      // Assert
      expect(swipeDirection, SwipeDirection.freeze);
    });

    test('Should return SwipeDirection.freeze if newIndex is null', () {
      // Arrange
      const oldIndex = 3;
      const newIndex = null;

      // Act
      final swipeDirection = Animators.getSwipeDirection(oldIndex: oldIndex, newIndex: newIndex);

      // Assert
      expect(swipeDirection, SwipeDirection.freeze);
    });

    test('Should return SwipeDirection.freeze if both oldIndex and newIndex are null', () {
      // Arrange
      const oldIndex = null;
      const newIndex = null;

      // Act
      final swipeDirection = Animators.getSwipeDirection(oldIndex: oldIndex, newIndex: newIndex);

      // Assert
      expect(swipeDirection, SwipeDirection.freeze);
    });
  });
// -----------------------------------------------------------------------------

  /// getSwipeDirection

// --------------------
  /*
  group('animateDouble tests', () {

    test('Should return the expected animation with default curve', () {
      // Arrange
      const begin = 0.0;
      const end = 1.0;
      final controller = AnimationController(vsync: const TestVSync());

      // Act
      final animation = Animators.animateDouble(begin: begin, end: end, controller: controller);

      // Assert
      expect(animation.value, begin);
      controller.value = 0.5;
      expect(animation.value, 0.5);
      controller.value = 1.0;
      expect(animation.value, end);
    });

    test('Should return the expected animation with custom curve', () {
      // Arrange
      const begin = 0.0;
      const end = 1.0;
      const curve = Curves.bounceIn;
      final controller = AnimationController(vsync: const TestVSync());

      // Act
      final animation =
          Animators.animateDouble(begin: begin, end: end, controller: controller, curve: curve);

      // Assert
      expect(animation.value, begin);
      controller.value = 0.5;
      expect(animation.value, curve.transform(0.5) * (end - begin) + begin);
      controller.value = 1.0;
      expect(animation.value, end);
    });

    test('Should return the expected animation with custom reverse curve', () {
      // Arrange
      const begin = 0.0;
      const end = 1.0;
      const reverseCurve = Curves.bounceIn;
      final controller = AnimationController(vsync: const TestVSync());

      // Act
      final animation = Animators.animateDouble(
          begin: begin, end: end, controller: controller, reverseCurve: reverseCurve);

      // Assert
      expect(animation.value, begin);
      controller.value = 0.5;
      expect(animation.value, reverseCurve.transform(0.5) * (end - begin) + begin);
      controller.value = 1.0;
      expect(animation.value, end);
    });

  });
   */
// -----------------------------------------------------------------------------

  /// getSwipeDirection

// --------------------
  group('limitTweenImpact  tests', () {

    test('limitTweenImpact returns minDouble when tweenValue is 0', () {
      final double result = Animators.limitTweenImpact(maxDouble: 100, minDouble: 50, tweenValue:
      0);
      expect(result, equals(50));
    });

    test('limitTweenImpact returns maxDouble when tweenValue is 1', () {
      final double result =
          Animators.limitTweenImpact(maxDouble: 100, minDouble: 50, tweenValue: 1);
      expect(result, equals(100));
    });

    test('limitTweenImpact returns correct value for tweenValue between 0 and 1', () {
      final double result =
          Animators.limitTweenImpact(maxDouble: 100, minDouble: 50, tweenValue: 0.5);
      expect(result, equals(75));
    });

    test('limitTweenImpact throws assertion error if minDouble is bigger than maxDouble', () {
      expect(() => Animators.limitTweenImpact(maxDouble: 50, minDouble: 100, tweenValue: 0.5),
          throwsAssertionError);
    });

    test(
        'limitTweenImpact returns correct value for zero minDouble and tweenValue between 0 and 1', () {
      final double result = Animators.limitTweenImpact(
          maxDouble: 100, minDouble: 0, tweenValue: 0.5);
      expect(result, equals(50));
    });

    test('limitTweenImpact returns maxDouble when minDouble is equal to maxDouble', () {
      final double result = Animators.limitTweenImpact(
          maxDouble: 100, minDouble: 100, tweenValue: 0.5);
      expect(result, equals(100));
    });


  });
// -----------------------------------------------------------------------------
}
