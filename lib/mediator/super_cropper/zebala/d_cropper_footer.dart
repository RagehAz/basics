// part of super_cropper;
//
// class CropperFooter extends StatelessWidget {
//   /// -----------------------------------------------------------------------------
//   const CropperFooter({
//     required this.currentImageIndex,
//     required this.onCropImages,
//     required this.pics,
//     required this.onImageTap,
//     required this.aspectRatio,
//     required this.screenHeight,
//     required this.appIsLTR,
//     required this.confirmText,
//     required this.loading,
//     super.key
//   });
//   // -----------------------------------------------------------------------------
//   final Wire<int> currentImageIndex;
//   final Function onCropImages;
//   final List<MediaModel>? pics;
//   final Function(int index) onImageTap;
//   final double aspectRatio;
//   final double screenHeight;
//   final bool appIsLTR;
//   final String confirmText;
//   final Wire<bool> loading;
//   // --------------------
//   static const double imagesSpacing = 5;
//   // --------------------
//   static double getMiniImageHeight(){
//     const double _imagesFooterHeight = Ratioz.horizon * 0.8;
//     return _imagesFooterHeight - (imagesSpacing * 2);
//   }
//   // --------------------
//   static double getMiniImagesWidth({
//     required double aspectRatio,
//   }){
//     final double _miniImageHeight = getMiniImageHeight();
//     final double _miniImageWidth = _miniImageHeight * aspectRatio;
//     return _miniImageWidth;
//   }
//   // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     // --------------------
//     final double _screenWidth = Scale.screenWidth(context);
//     const double _imagesFooterHeight = Ratioz.horizon;
//     // --------------------
//     final double _miniImageHeight = getMiniImageHeight();
//     final double _miniImageWidth = getMiniImagesWidth(
//       aspectRatio: aspectRatio,
//     );
//     // --------------------
//     return Container(
//       width: _screenWidth,
//       height: _imagesFooterHeight,
//       alignment: Alignment.bottomLeft,
//       child: LiveWire(
//         wire: currentImageIndex,
//         builder: (int imageIndex, Widget? confirmButton){
//
//           return Stack(
//             children: <Widget>[
//
//               /// MINI PICTURES
//               if (Lister.superLength(pics) > 1)
//               SizedBox(
//                 width: _screenWidth,
//                 height: _imagesFooterHeight,
//                 child: ListView.builder(
//                   physics: const BouncingScrollPhysics(),
//                   scrollDirection: Axis.horizontal,
//                   itemCount: pics?.length,
//                   padding: Scale.superInsets(
//                     context: context,
//                     appIsLTR: appIsLTR,
//                     enRight: _screenWidth * 0.5,
//                     enLeft: 10,
//                   ),
//                   itemBuilder: (_, int index){
//
//                     final bool _isSelected = imageIndex == index;
//
//                     return GestureDetector(
//                       onTap: () => onImageTap(index),
//                       child: Center(
//                         child: Container(
//                           width: _miniImageWidth,
//                           height: _miniImageHeight,
//                           margin: Scale.superInsets(
//                             context: context,
//                             appIsLTR: appIsLTR,
//                             enRight: 5,
//                           ),
//                           decoration: BoxDecoration(
//                             color: _isSelected == true ? Colorz.white125 : Colorz.white50,
//                             borderRadius: const BorderRadius.all(Radius.circular(5)),
//                             border: _isSelected == true ? Border.all(color: Colorz.white200) : null,
//                           ),
//                           child: SuperImage(
//                             width: _miniImageWidth,
//                             height: _miniImageWidth,
//                             pic: pics?[index],
//                             loading: false, //loading,
//                           ),
//                         ),
//                       ),
//                     );
//
//                   },
//                 ),
//               ),
//
//               /// CONFIRM BUTTON
//               confirmButton!,
//
//             ],
//           );
//
//         },
//         child: Align(
//           alignment: Aligner.bottom(
//             appIsLTR: appIsLTR,
//             inverse: true,
//           ),
//           child: ValueListenableBuilder(
//             valueListenable: loading,
//             builder: (_, bool loading, Widget? child) {
//               return SuperBox(
//                 height: _miniImageHeight,
//                 width: _miniImageHeight * 3,
//                 text: confirmText,
//                 onTap: onCropImages,
//                 color: Colorz.green255,
//                 appIsLTR: appIsLTR,
//                 textScaleFactor: 0.7,
//                 textFont: BldrsThemeFonts.fontHead,
//                 textItalic: true,
//                 margins: 10,
//                 loading: loading,
//               );
//             }
//           ),
//         ),
//       ),
//
//     );
//     // --------------------
//   }
// // -----------------------------------------------------------------------------
// }
