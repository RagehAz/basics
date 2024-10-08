import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/components/bubbles/bubble/bubble_switcher.dart';
import 'package:basics/components/bubbles/model/bubble_header_vm.dart';
import 'package:basics/components/drawing/expander.dart';
import 'package:basics/components/super_box/super_box.dart';
import 'package:basics/components/texting/super_text/super_text.dart';
import 'package:flutter/material.dart';

class BubbleHeader extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BubbleHeader({
    required this.viewModel,
    super.key
  });
  /// --------------------------------------------------------------------------
  final BubbleHeaderVM? viewModel;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (viewModel == null) {
      return const SizedBox();
    }
    else {
          // --------------------
    final double _bubbleWidth = Bubble.clearWidth(
      context: context,
      bubbleWidthOverride: viewModel!.headerWidth,
    );
    // --------------------
    /// LEADING ICON
    final bool _hasIcon = viewModel!.leadingIcon != null;
    final double _leadingIconWidth = _hasIcon == true ? BubbleHeaderVM.leadingIconBoxSize : 0;
    // --------------------
    /// SWITCHER
    final double _switcherWidth = viewModel!.hasSwitch == true ? BubbleHeaderVM
        .switcherButtonWidth : 0;
    // --------------------
    /// MORE BUTTON
    final double _moreButtonWidth = viewModel!.hasMoreButton == true ? BubbleHeaderVM
        .moreButtonSize + 10 : 0;
    // --------------------
    /// HEADLINE
    final double _headlineWidth = _bubbleWidth - _leadingIconWidth - _switcherWidth - _moreButtonWidth;
    // --------------------
    if (
        viewModel!.headlineText == null
        &&
        viewModel!.leadingIcon == null
        &&
        viewModel!.switchValue == false
        &&
        viewModel!.hasMoreButton == false
    ){
      return const SizedBox();
    }
    // --------------------
    else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          /// --- LEADING ICON
          if (_hasIcon == true)
            SuperBox(
              width: BubbleHeaderVM.leadingIconBoxSize,
              height: BubbleHeaderVM.leadingIconBoxSize,
              icon: viewModel!.leadingIcon,
              // iconColor: Colorz.Green255,
              iconSizeFactor: viewModel!.leadingIconSizeFactor,
              color: viewModel!.leadingIconBoxColor,
              margins: EdgeInsets.zero,
              bubble: false,
              borderColor: viewModel!.onLeadingIconTap == null ? null : Colorz.white50,
              onTap: viewModel!.onLeadingIconTap,
              textFont: viewModel!.font,
              loading: viewModel!.loading,
            ),

          /// --- HEADLINE
          SuperText(
            boxWidth: _headlineWidth,
            text: viewModel!.headlineText,
            textColor: viewModel!.headlineColor,
            textHeight: viewModel!.headlineHeight,
            maxLines: viewModel!.headlineMaxLines,
            centered: viewModel!.centered,
            redDot: viewModel!.redDot,
            margins: const EdgeInsets.only(
              top: BubbleHeaderVM.verseBottomMargin,
              left: 10,
              right: 10,
            ),
            highlight: viewModel!.headlineHighlight,
            font: viewModel!.font,
            textDirection: viewModel!.textDirection,
            appIsLTR: viewModel!.appIsLTR,
          ),

          const Expander(),

          if (viewModel!.hasSwitch == true)
            BubbleSwitcher(
              width: _switcherWidth,
              height: BubbleHeaderVM.leadingIconBoxSize,
              switchIsOn: viewModel!.switchValue,
              onSwitch: viewModel!.onSwitchTap,
              switchActiveColor: viewModel!.switchActiveColor,
              switchDisabledColor: viewModel!.switchDisabledColor,
              switchDisabledTrackColor: viewModel!.switchDisabledTrackColor,
              switchFocusColor: viewModel!.switchFocusColor,
              switchTrackColor: viewModel!.switchTrackColor,
            ),

          // const SizedBox(
          //   width: 5,
          // ),

          if (viewModel!.hasMoreButton == true)
            SuperBox(
              height: BubbleHeaderVM.moreButtonSize,
              width: BubbleHeaderVM.moreButtonSize,
              icon: viewModel!.moreButtonIcon,
              iconSizeFactor: viewModel!.moreButtonIconSizeFactor,
              onTap: viewModel!.onMoreButtonTap,
              textFont: viewModel!.font,
              bubble: false,
              borderColor: Colorz.white50,
              // margins: const EdgeInsets.symmetric(horizontal: 5),
            ),

        ],
      );
    }
    // --------------------

    }

  }
  // -----------------------------------------------------------------------------
}
