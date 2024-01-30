part of super_text_field;

class SuperValidator extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperValidator({
    required this.width,
    required this.validator,
    required this.focusNode,
    required this.font,
    this.autoValidate = true,
    this.scrollPadding,
    this.enabledBorderColor = const Color.fromARGB(0, 255, 255, 255),
    this.disabledBorderColor = const Color.fromARGB(0, 255, 255, 255),
    this.errorBorderColor = const Color.fromARGB(0, 255, 255, 255),
    this.borderCorners = 0,

    this.textHeight = 20,
    this.errorTextColor = const Color.fromARGB(125, 233, 0, 0),
        super.key
  }); 
  /// --------------------------------------------------------------------------
  final double? width;
  final String? Function(String? text)? validator;
  final bool autoValidate;
  final FocusNode? focusNode;
  final EdgeInsets? scrollPadding;
  final Color enabledBorderColor;
  final Color disabledBorderColor;
  final Color errorBorderColor;
  final double? borderCorners;

  final double textHeight;
  final Color? errorTextColor;
  final String? font;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Center(
      child: SizedBox(
        width: width,
        child: TextFormField(

          focusNode: focusNode,

          /// VALIDATION
          autovalidateMode: autoValidate == true ? AutovalidateMode.always : AutovalidateMode.disabled,
          validator: validator == null ? null : (String? text) => validator!(text),

          /// SPAN SPACING
          scrollPadding: scrollPadding ?? SuperTextFieldController.adaptiveScrollPadding(
            context: context,
          ),

          /// DISABLE TEXT FIELD
          readOnly: true,
          enabled: true,

          // textDirection: textDirection,
          // textAlign: ,
          // textAlignVertical: ,

          /// BOX STYLING => COLLAPSE BOX HEIGHT TO ZERO + MAKE BORDER TRANSPARENT
          decoration: InputDecoration(

            /// COLLAPSES FIELD HEIGHT TO THE MINIMUM TEXT HEIGHT GIVEN
            isCollapsed: true,

            /// as field is enabled : this overrides the ( enabledBorder )
            enabledBorder: SuperTextFieldController.createOutlineBorder(
              borderColor: enabledBorderColor,
              corners: borderCorners,
            ),
            /// as field is disabled : this overrides the ( disabledBorder )
            disabledBorder: SuperTextFieldController.createOutlineBorder(
              borderColor: disabledBorderColor,
              corners: borderCorners,
            ),
            /// as field is in error : this overrides the ( errorBorder )
            errorBorder: SuperTextFieldController.createOutlineBorder(
              borderColor: errorBorderColor,
              corners: borderCorners,
            ),

            /// ERROR TEXT STYLE
            errorStyle: SuperTextFieldController.createErrorStyle(
              textHeight: textHeight,
              textItalic: true,
              errorTextColor: errorTextColor,
              font: font,
            ),
            errorMaxLines: 3,
            // errorText: 'initial state error text',

          ),

          /// TEXT STYLING => TO COLLAPSE ITS HEIGHT TO ZERO
          style: const TextStyle(
            height: 0,
            fontSize: 0,
          ),

          /// MAIN
          // key: ,
          // controller: ,
          // initialValue: ,
          // inputFormatters: [],
          // restorationId: ,
          /// SCROLLING
          // scrollController: ,
          // scrollPhysics: ,
          /// FOCUS
          // autofocus: ,
          /// CURSOR
          // showCursor: ,
          // cursorColor: ,
          // cursorHeight: ,
          // cursorRadius: ,
          // cursorWidth: ,
          // mouseCursor: ,
          /// FUNCTIONS
          // onTap: ,
          // onChanged: ,
          // onEditingComplete: ,
          // onFieldSubmitted: ,
          // onSaved: ,
          // onTapOutside: ,
          /// SIZING
          // maxLines: ,
          // minLines: ,
          // expands: ,
          // maxLength: ,
          // maxLengthEnforcement: ,
          /// COUNTER
          // buildCounter: ,
          /// BEHAVIOUR
          // autocorrect: ,
          // autofillHints: ,
          // enableIMEPersonalizedLearning: ,
          // enableInteractiveSelection: ,
          // enableSuggestions: ,
          /// OBSCURITY
          // obscureText: ,
          // obscuringCharacter: ,
          /// MENU BAR
          // contextMenuBuilder: ,
          // toolbarOptions: ,
          /// SELECTION
          // selectionControls: ,
          /// KEYBOARD
          // keyboardAppearance: ,
          // keyboardType: ,
          // textInputAction: ,
          /// STYLING
          // smartDashesType: ,
          // smartQuotesType: ,
          // strutStyle: ,
          // textCapitalization: ,


        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
