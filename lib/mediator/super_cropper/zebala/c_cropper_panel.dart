// part of super_cropper;
//
// class BldrsCropperPanel extends StatelessWidget {
//   // --------------------------------------------------------------------------
//   const BldrsCropperPanel({
//     required this.panelIsOn,
//     required this.mediaModels,
//     required this.onImageTap,
//     required this.currentImageIndex,
//     required this.aspectRatio,
//     required this.panelHeight,
//     required this.appIsLTR,
//     required this.textDirection,
//     required this.textFont,
//     required this.letterSpacing,
//     required this.textWeight,
//     super.key
//   });
//   // --------------------
//   final bool panelIsOn;
//   final List<MediaModel>? mediaModels;
//   final Function(int index) onImageTap;
//   final ValueNotifier<int> currentImageIndex;
//   final double aspectRatio;
//   final double panelHeight;
//   final bool appIsLTR;
//   final TextDirection textDirection;
//   final String? textFont;
//   final double? letterSpacing;
//   final FontWeight? textWeight;
//   // --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     // --------------------
//     if (panelIsOn == false){
//       return const SizedBox();
//     }
//     // --------------------
//     else {
//
//       final double _screenWidth = Scale.screenWidth(context);
//       final double _miniImageHeight = panelHeight * 0.5;
//       final double _miniImageWidth = _miniImageHeight * aspectRatio;
//
//       return LiveWire(
//           wire: currentImageIndex,
//           builder: (int imageIndex, Widget? confirmButton){
//
//             return FloatingList(
//               width: _screenWidth,
//               height: panelHeight,
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               columnChildren: <Widget>[
//
//                 if (Lister.checkCanLoop(mediaModels) == true)
//                 ...List.generate(mediaModels!.length, (index){
//
//                   final MediaModel _media = mediaModels![index];
//
//                   final bool _isSelected = imageIndex == index;
//
//                   return Center(
//                     child: SuperBox(
//                       appIsLTR: appIsLTR,
//                       textDirection: textDirection,
//                       textFont: textFont,
//                       letterSpacing: letterSpacing,
//                       textWeight: textWeight,
//                       width: _miniImageWidth,
//                       height: _miniImageHeight,
//                       icon: _media,
//                       corners: const BorderRadius.all(Radius.circular(5)),
//                       borderColor: _isSelected == true ? Colorz.white200 : null,
//                       margins: const EdgeInsets.symmetric(horizontal: 5),
//                       onTap: () => onImageTap(index),
//                       bubble: false,
//                     ),
//                   );
//
//                 }),
//
//               ],
//             );
//           }
//       );
//     }
//     // --------------------
//   }
// // --------------------------------------------------------------------------
// }
