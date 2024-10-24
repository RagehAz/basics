// import 'dart:typed_data';
// import 'package:basics/bldrs_theme/classes/colorz.dart';
// import 'package:bldrs/f_helpers/drafters/contextual.dart';
// import 'package:basics/layouts/views/floating_list.dart';
// import 'package:bldrs/b_screens/h_media_screens/editor_scale.dart';
// import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
// import 'package:flutter/material.dart';
//
// class BldrsCropperPanel extends StatelessWidget {
//   // --------------------------------------------------------------------------
//   const BldrsCropperPanel({
//     required this.panelIsOn,
//     required this.bytezz,
//     required this.onImageTap,
//     required this.currentImageIndex,
//     required this.aspectRatio,
//     super.key
//   });
//   // --------------------
//   final bool panelIsOn;
//   final List<Uint8List> bytezz;
//   final Function(int index) onImageTap;
//   final ValueNotifier<int> currentImageIndex;
//   final double aspectRatio;
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
//       final double _screenWidth = context.screenWidth;
//       final double _panelHeight = EditorScale.panelZoneHeight(isOn: true);
//       final double _miniImageHeight = _panelHeight * 0.5;
//       final double _miniImageWidth = _miniImageHeight * aspectRatio;
//
//       return ValueListenableBuilder(
//           valueListenable: currentImageIndex,
//           builder: (_, int imageIndex, Widget? confirmButton){
//
//           return FloatingList(
//             width: _screenWidth,
//             height: _panelHeight,
//             scrollDirection: Axis.horizontal,
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             columnChildren: <Widget>[
//
//               ...List.generate(bytezz.length, (index){
//
//                 final Uint8List _bytes = bytezz[index];
//
//                 final bool _isSelected = imageIndex == index;
//
//                 return Center(
//                   child: BldrsBox(
//                     width: _miniImageWidth,
//                     height: _miniImageHeight,
//                     icon: _bytes,
//                     corners: const BorderRadius.all(Radius.circular(5)),
//                     borderColor: _isSelected == true ? Colorz.white200 : null,
//                     margins: const EdgeInsets.symmetric(horizontal: 5),
//                     onTap: () => onImageTap(index),
//                     bubble: false,
//                   ),
//                 );
//
//               }),
//
//             ],
//           );
//         }
//       );
//     }
//     // --------------------
//   }
//   // --------------------------------------------------------------------------
// }
