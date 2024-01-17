// import 'package:bldrs/z_components/dialogs/center_dialog/center_dialog.dart';
// import 'package:bldrs/z_components/sizing/expander.dart';
// import 'package:contacts_service/contacts_service.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:permission_handler/permission_handler.dart';
// -----------------------------------------------------------------------------
/// GET DEVICE CONTACTS OPS
// Future<List<Contact>> getDeviceContactsOps(BuildContext context) async {
//
//   List<Contact> _contacts = <Contact>[];
//
//   final PermissionStatus _permission = await _checkContactsPermission();
//
//   switch (_permission){
//
//     case PermissionStatus.granted:
//       _contacts = await _getDeviceContacts();
//       break;
//
//     case PermissionStatus.denied:
//       await _showContactsPermissionDenialDialog(context);
//       break;
//
//     case PermissionStatus.permanentlyDenied:
//       await _youNeedToReinstallTheApp(context);
//       break;
//
//     default :
//       await _askForPermission(context);
//   }
//
//   blog('permission is :$_permission');
//
//   return _contacts;
// }
// -----------------------------------------------------------------------------
/// CONTACTS PERMISSION CHECK
// Future<PermissionStatus> _checkContactsPermission() async {
//
//   final PermissionStatus _permission = await Permission.contacts.status;
//
//   if (_permission != PermissionStatus.granted){
//     final _newPermission = await Permission.contacts.request();
//
//     return _newPermission ?? PermissionStatus.denied;
//   }
//   else {
//     return _permission;
//   }
//
//
// }
// -----------------------------------------------------------------------------
/// ON PERMISSION GRANTED
// Future<List<Contact>> _getDeviceContacts() async {
//
//   final List<Contact> _contacts = await ContactsService.getContacts(
//     withThumbnails: false,
//     orderByGivenName: true,
//     // androidLocalizedLabels: '',
//     // iOSLocalizedLabels: '',
//     // photoHighResolution: '',
//     // query: '',
//   );
//
//   return _contacts ?? <Contact>[];
// }
// -----------------------------------------------------------------------------
/// ON PERMISSION DENIED
// Future<void> _showContactsPermissionDenialDialog(BuildContext context) async {
//
//   await CenterDialog.showCenterDialog(
//     context: context,
//     title: 'Permission denied',
//     body: 'Can not import your contacts',
//     // boolDialog: false,
//     confirmButtonText: 'Tamam',
//     // child: Row(
//     //  children: <Widget>[
//     //
//     //    DialogButton(
//     //      verse:  'permit',
//     //      onTap: () async {
//     //        await Permission.contacts.request();
//     //      },
//     //    )
//     //
//     //  ],
//     // )
//   );
//
// }
// -----------------------------------------------------------------------------
/// ON SOMETHING GOES WRONG
// Future<void> _askForPermission(BuildContext context) async {
//
//   await CenterDialog.showCenterDialog(
//     context: context,
//     title: 'Allow access to your contacts',
//     body: 'In order to choose from your contacts, please allow contacts access',
//     boolDialog: true,
//     confirmButtonText: 'ok',
//   );
//
// }
// -----------------------------------------------------------------------------
/// ON PERMANENT DENIED PERMISSION
// Future<void> _youNeedToReinstallTheApp(BuildContext context) async {
//
//   await CenterDialog.showCenterDialog(
//     context: context,
//     title: 'Permanent denied access',
//     body: 'You have denied access to your contacts permanently, to allow access you need to re-install the app, please delete the app and re-install it again \n Or \n'
//         'If you can, just allow contacts permission access in device settings,, just search for Bldrs.net in your device settings and switch on the permissions',
//     // confirmButtonText: 'ok',
//   );
//
// }
