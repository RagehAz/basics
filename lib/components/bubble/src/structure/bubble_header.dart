part of bubble;

class BubbleHeader extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const BubbleHeader({
    required this.viewModel,
    super.key
  });
  // --------------------
  final BubbleHeaderVM? viewModel;
  // -----------------------------------------------------------------------------
  bool checkShowEmptyBox(){
    return  viewModel!.headlineText == null
            &&
            viewModel!.leadingIcon == null
            &&
            viewModel!.switchValue == false
            &&
            viewModel!.hasMoreButton == false;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (viewModel == null) {
      return const SizedBox();
    }

    else {
      // --------------------
      /// LEADING ICON
      final bool _hasIcon = viewModel!.leadingIcon != null;
      // --------------------
      /// SWITCHER
      final double _switcherWidth = viewModel!.hasSwitch == true ? BubbleScale.switcherButtonWidth : 0;
      // --------------------
      /// HEADLINE
      final double _headlineWidth = BubbleScale.headlineWidth(
          context: context,
          hasLeadingIcon: _hasIcon,
          hasSwitch: viewModel!.hasSwitch,
          hasMoreButton: viewModel!.hasMoreButton,
      );
      // --------------------
      if (checkShowEmptyBox() == true){
        return const SizedBox();
      }
      // --------------------
      else {

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            /// LEADING BUTTON
            if (_hasIcon == true)
              SuperBox(
                width: BubbleScale.headerButtonSize,
                height: BubbleScale.headerButtonSize,
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

            /// HEADLINE
            SuperText(
              boxWidth: _headlineWidth,
              text: viewModel!.headlineText,
              textColor: viewModel!.headlineColor,
              textHeight: viewModel!.headlineHeight,
              maxLines: viewModel!.headlineMaxLines,
              centered: viewModel!.centered,
              redDot: viewModel!.redDot,
              margins: const EdgeInsets.only(
                top: BubbleScale.verseBottomMargin,
                left: 10,
                right: 10,
              ),
              highlight: viewModel!.headlineHighlight,
              font: viewModel!.font,
              textDirection: viewModel!.textDirection,
              appIsLTR: viewModel!.appIsLTR,
            ),

            /// EXPANDER
            const Expander(),

            /// SWITCH
            if (viewModel!.hasSwitch == true)
              BubbleSwitcher(
                width: _switcherWidth,
                height: BubbleScale.headerButtonSize,
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

            /// MORE BUTTON
            if (viewModel!.hasMoreButton == true)
              SuperBox(
                height: BubbleScale.headerButtonSize,
                width: BubbleScale.headerButtonSize,
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
