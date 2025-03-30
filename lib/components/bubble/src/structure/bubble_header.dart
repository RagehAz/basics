part of bubble;
/// => TAMAM
class _BubbleHeader extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const _BubbleHeader({
    required this.viewModel,
    required this.bubbleWidthOverride,
    // super.key
  });
  // --------------------
  final BubbleHeaderVM? viewModel;
  final double bubbleWidthOverride;
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

    return UnNullify(
      key: const ValueKey<String>('_BubbleHeader'),
      value: viewModel,
      builder: (BubbleHeaderVM _viewModel){
        // --------------------
        if (checkShowEmptyBox() == true){
          return const SizedBox();
        }
        // --------------------
        else {
            // --------------------
            /// LEADING ICON
            final bool _hasIcon = _viewModel.leadingIcon != null;
            // --------------------
            /// SWITCHER
            final double _switcherWidth = _viewModel.hasSwitch == true ? BubbleScale.switcherButtonWidth : 0;
            // --------------------
            /// HEADLINE
            final double _headlineWidth = BubbleScale.headlineWidth(
                context: context,
                hasLeadingIcon: _hasIcon,
                hasSwitch: _viewModel.hasSwitch,
                hasMoreButton: _viewModel.hasMoreButton,
                bubbleWidthOverride: bubbleWidthOverride
            );
            // --------------------
            return SizedBox(
              width: BubbleScale.clearWidth(context: context, bubbleWidthOverride: bubbleWidthOverride),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  /// LEADING BUTTON
                  if (_hasIcon == true)
                    SuperBox(
                      width: BubbleScale.headerButtonSize,
                      height: BubbleScale.headerButtonSize,
                      icon: _viewModel.leadingIcon,
                      iconColor: _viewModel.leadingIconColor,
                      iconSizeFactor: _viewModel.leadingIconSizeFactor,
                      color: _viewModel.leadingIconBoxColor,
                      // margins: EdgeInsets.zero,
                      bubble: false,
                      borderColor: _viewModel.onLeadingIconTap == null ? null : Colorz.white50,
                      onTap: _viewModel.onLeadingIconTap,
                      textFont: _viewModel.font,
                      loading: _viewModel.loading,
                      loadingIsPulse: true,
                    ),

                  /// HEADLINE
                  Container(
                    width: _headlineWidth,
                    constraints: const BoxConstraints(
                      minHeight: BubbleScale.headerButtonSize,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: BubbleScale.paddingValue),
                    child: SuperText(
                      boxWidth: _headlineWidth - BubbleScale.bothPaddingsValue,
                      // boxHeight: viewModel!.headlineMaxLines == 1 ? BubbleScale.headerButtonSize : null,
                      text: _viewModel.headlineText,
                      textColor: _viewModel.headlineColor,
                      textHeight: _viewModel.headlineHeight,
                      maxLines: _viewModel.headlineMaxLines,
                      centered: _viewModel.centered,
                      redDot: _viewModel.redDot,
                      // margins: const EdgeInsets.only(
                      //   top: BubbleScale.verseBottomMargin,
                      //   left: 10,
                      //   right: 10,
                      // ),
                      highlight: _viewModel.headlineHighlight,
                      font: _viewModel.font,
                      textDirection: _viewModel.textDirection,
                      appIsLTR: _viewModel.appIsLTR,
                    ),
                  ),

                  /// SWITCH
                  if (_viewModel.hasSwitch == true)
                    BubbleSwitcher(
                      width: _switcherWidth,
                      height: BubbleScale.headerButtonSize,
                      switchIsOn: _viewModel.switchValue,
                      onSwitch: _viewModel.onSwitchTap,
                      switchActiveColor: _viewModel.switchActiveColor,
                      switchDisabledColor: _viewModel.switchDisabledColor,
                      switchDisabledTrackColor: _viewModel.switchDisabledTrackColor,
                      switchFocusColor: _viewModel.switchFocusColor,
                      switchTrackColor: _viewModel.switchTrackColor,
                    ),

                  /// SPACING
                  if (_viewModel.hasMoreButton == true)
                    const Spacing(size: BubbleScale.paddingValue),

                  /// MORE BUTTON
                  if (_viewModel.hasMoreButton == true)
                    SuperBox(
                      height: BubbleScale.headerButtonSize,
                      width: BubbleScale.headerButtonSize,
                      icon: _viewModel.moreButtonIcon,
                      iconSizeFactor: _viewModel.moreButtonIconSizeFactor,
                      onTap: _viewModel.onMoreButtonTap,
                      textFont: _viewModel.font,
                      bubble: false,
                      borderColor: Colorz.white50,
                      // margins: const EdgeInsets.symmetric(horizontal: 5),
                    ),

                ],
              ),
            );
            // --------------------
          }
          // --------------------
        },
    );


  }
  // -----------------------------------------------------------------------------
}
