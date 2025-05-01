// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
// import 'package:basics/mediator/models/media_models.dart';
// import 'package:flutter_test/flutter_test.dart';
//
// void main() {
//
//   group('findMediaByUploadPath tests', () {
//
//     // 1. Test: Finding the media with a matching upload path
//     test('should find media with matching upload path', () {
//       final media1 = MediaModel(
//         id: '1',
//         bytes: null,
//         meta: MediaMetaModel(
//           ownersIDs: ['owner1'],
//           fileExt: null,
//           uploadPath: 'storage/collection/file1.ext',
//           name: 'File 1',
//         ),
//       );
//       final media2 = MediaModel(
//         id: '2',
//         bytes: null,
//         meta: MediaMetaModel(
//           ownersIDs: ['owner2'],
//           fileExt: null,
//           uploadPath: 'storage/collection/file2.ext',
//           name: 'File 2',
//         ),
//       );
//
//       final foundMedia = MediaModel.findMediaByUploadPath(
//         medias: [media1, media2],
//         uploadPath: 'storage/collection/file1.ext',
//       );
//
//       expect(foundMedia, equals(media1));
//     });
//
//     // 2. Test: No media with the given upload path exists
//     test('should return null when no media matches the upload path', () {
//       final media1 = MediaModel(
//         id: '1',
//         bytes: null,
//         meta: MediaMetaModel(
//           ownersIDs: ['owner1'],
//           fileExt: null,
//           uploadPath: 'storage/collection/file1.ext',
//           name: 'File 1',
//         ),
//       );
//       final media2 = MediaModel(
//         id: '2',
//         bytes: null,
//         meta: MediaMetaModel(
//           ownersIDs: ['owner2'],
//           fileExt: null,
//           uploadPath: 'storage/collection/file2.ext',
//           name: 'File 2',
//         ),
//       );
//
//       final foundMedia = MediaModel.findMediaByUploadPath(
//         medias: [media1, media2],
//         uploadPath: 'storage/collection/file3.ext',
//       );
//
//       expect(foundMedia, isNull);
//     });
//
//     // 3. Test: Empty media list
//     test('should return null when the media list is empty', () {
//       final foundMedia = MediaModel.findMediaByUploadPath(
//         medias: [],
//         uploadPath: 'storage/collection/file1.ext',
//       );
//
//       expect(foundMedia, isNull);
//     });
//
//     // 4. Test: Null upload path
//     test('should return null when the upload path is null', () {
//       final media = MediaModel(
//         id: '1',
//         bytes: null,
//         meta: MediaMetaModel(
//           ownersIDs: ['owner1'],
//           fileExt: null,
//           uploadPath: 'storage/collection/file1.ext',
//           name: 'File 1',
//         ),
//       );
//
//       final foundMedia = MediaModel.findMediaByUploadPath(
//         medias: [media],
//         uploadPath: null,
//       );
//
//       expect(foundMedia, isNull);
//     });
//
//     // 5. Test: Media list has only one item
//     test('should find media when there is only one media item in the list', () {
//       final media = MediaModel(
//         id: '1',
//         bytes: null,
//         meta: MediaMetaModel(
//           ownersIDs: ['owner1'],
//           fileExt: null,
//           uploadPath: 'storage/collection/file1.ext',
//           name: 'File 1',
//         ),
//       );
//
//       final foundMedia = MediaModel.findMediaByUploadPath(
//         medias: [media],
//         uploadPath: 'storage/collection/file1.ext',
//       );
//
//       expect(foundMedia, equals(media));
//     });
//
//     // 6. Test: Media with null upload path in the list
//     test('should return null when media in the list has null upload path', () {
//       final media = MediaModel(
//         id: '1',
//         bytes: null,
//         meta: MediaMetaModel(
//           ownersIDs: ['owner1'],
//           fileExt: null,
//           uploadPath: null,
//           name: 'File 1',
//         ),
//       );
//
//       final foundMedia = MediaModel.findMediaByUploadPath(
//         medias: [media],
//         uploadPath: 'storage/collection/file1.ext',
//       );
//
//       expect(foundMedia, isNull);
//     });
//
//     // 7. Test: Media with identical upload paths in the list
//     test('should return the first media when multiple media have the same upload path', () {
//       final media1 = MediaModel(
//         id: '1',
//         bytes: null,
//         meta: MediaMetaModel(
//           ownersIDs: ['owner1'],
//           fileExt: null,
//           uploadPath: 'storage/collection/file1.ext',
//           name: 'File 1',
//         ),
//       );
//       final media2 = MediaModel(
//         id: '2',
//         bytes: null,
//         meta: MediaMetaModel(
//           ownersIDs: ['owner2'],
//           fileExt: null,
//           uploadPath: 'storage/collection/file1.ext',
//           name: 'File 2',
//         ),
//       );
//
//       final foundMedia = MediaModel.findMediaByUploadPath(
//         medias: [media1, media2],
//         uploadPath: 'storage/collection/file1.ext',
//       );
//
//       expect(foundMedia, equals(media1));
//     });
//
//   });
//
//   group('findTheNotUploaded tests', () {
//
//     // 1. Test: All media are uploaded
//     test('should return an empty list when all media are uploaded', () {
//       final media1 = MediaModel(
//         id: '1',
//         bytes: null,
//         meta: MediaMetaModel(
//           ownersIDs: ['owner1'],
//           fileExt: null,
//           uploadPath: 'storage/collection/file1.ext',
//           name: 'File 1',
//         ),
//       );
//       final media2 = MediaModel(
//         id: '2',
//         bytes: null,
//         meta: MediaMetaModel(
//           ownersIDs: ['owner2'],
//           fileExt: null,
//           uploadPath: 'storage/collection/file2.ext',
//           name: 'File 2',
//         ),
//       );
//
//       final result = MediaModel.findTheNotUploaded(
//         allMedias: [media1, media2],
//         uploadedMedias: [media1, media2],
//       );
//
//       expect(result, isEmpty);
//     });
//
//     // 2. Test: None of the media are uploaded
//     test('should return all media when none are uploaded', () {
//       final media1 = MediaModel(
//         id: '1',
//         bytes: null,
//         meta: MediaMetaModel(
//           ownersIDs: ['owner1'],
//           fileExt: null,
//           uploadPath: 'storage/collection/file1.ext',
//           name: 'File 1',
//         ),
//       );
//       final media2 = MediaModel(
//         id: '2',
//         bytes: null,
//         meta: MediaMetaModel(
//           ownersIDs: ['owner2'],
//           fileExt: null,
//           uploadPath: 'storage/collection/file2.ext',
//           name: 'File 2',
//         ),
//       );
//
//       final result = MediaModel.findTheNotUploaded(
//         allMedias: [media1, media2],
//         uploadedMedias: [],
//       );
//
//       expect(result, equals([media1, media2]));
//     });
//
//     // 3. Test: Some media are uploaded
//     test('should return only non-uploaded media', () {
//       final media1 = MediaModel(
//         id: '1',
//         bytes: null,
//         meta: MediaMetaModel(
//           ownersIDs: ['owner1'],
//           fileExt: null,
//           uploadPath: 'storage/collection/file1.ext',
//           name: 'File 1',
//         ),
//       );
//       final media2 = MediaModel(
//         id: '2',
//         bytes: null,
//         meta: MediaMetaModel(
//           ownersIDs: ['owner2'],
//           fileExt: null,
//           uploadPath: 'storage/collection/file2.ext',
//           name: 'File 2',
//         ),
//       );
//
//       final result = MediaModel.findTheNotUploaded(
//         allMedias: [media1, media2],
//         uploadedMedias: [media1],
//       );
//
//       expect(result, equals([media2]));
//     });
//
//     // 4. Test: Empty allMedias list
//     test('should return an empty list when allMedias is empty', () {
//       final media = MediaModel(
//         id: '1',
//         bytes: null,
//         meta: MediaMetaModel(
//           ownersIDs: ['owner1'],
//           fileExt: null,
//           uploadPath: 'storage/collection/file1.ext',
//           name: 'File 1',
//         ),
//       );
//
//       final result = MediaModel.findTheNotUploaded(
//         allMedias: [],
//         uploadedMedias: [media],
//       );
//
//       expect(result, isEmpty);
//     });
//
//     // 5. Test: Empty uploadedMedias list
//     test('should return all media when uploadedMedias is empty', () {
//       final media1 = MediaModel(
//         id: '1',
//         bytes: null,
//         meta: MediaMetaModel(
//           ownersIDs: ['owner1'],
//           fileExt: null,
//           uploadPath: 'storage/collection/file1.ext',
//           name: 'File 1',
//         ),
//       );
//       final media2 = MediaModel(
//         id: '2',
//         bytes: null,
//         meta: MediaMetaModel(
//           ownersIDs: ['owner2'],
//           fileExt: null,
//           uploadPath: 'storage/collection/file2.ext',
//           name: 'File 2',
//         ),
//       );
//
//       final result = MediaModel.findTheNotUploaded(
//         allMedias: [media1, media2],
//         uploadedMedias: [],
//       );
//
//       expect(result, equals([media1, media2]));
//     });
//
//     // 6. Test: No matches between uploaded and allMedias
//     test('should return all media when there are no matches in uploadedMedias', () {
//       final media1 = MediaModel(
//         id: '1',
//         bytes: null,
//         meta: MediaMetaModel(
//           ownersIDs: ['owner1'],
//           fileExt: null,
//           uploadPath: 'storage/collection/file1.ext',
//           name: 'File 1',
//         ),
//       );
//       final media2 = MediaModel(
//         id: '2',
//         bytes: null,
//         meta: MediaMetaModel(
//           ownersIDs: ['owner2'],
//           fileExt: null,
//           uploadPath: 'storage/collection/file2.ext',
//           name: 'File 2',
//         ),
//       );
//
//       final uploadedMedia = MediaModel(
//         id: '3',
//         bytes: null,
//         meta: MediaMetaModel(
//           ownersIDs: ['owner3'],
//           fileExt: null,
//           uploadPath: 'storage/collection/file3.ext',
//           name: 'File 3',
//         ),
//       );
//
//       final result = MediaModel.findTheNotUploaded(
//         allMedias: [media1, media2],
//         uploadedMedias: [uploadedMedia],
//       );
//
//       expect(result, equals([media1, media2]));
//     });
//
//     // 7. Test: Some media have null upload path
//     test('should handle media with null upload path gracefully', () {
//       final media1 = MediaModel(
//         id: '1',
//         bytes: null,
//         meta: MediaMetaModel(
//           ownersIDs: ['owner1'],
//           fileExt: null,
//           uploadPath: null,
//           name: 'File 1',
//         ),
//       );
//       final media2 = MediaModel(
//         id: '2',
//         bytes: null,
//         meta: MediaMetaModel(
//           ownersIDs: ['owner2'],
//           fileExt: null,
//           uploadPath: 'storage/collection/file2.ext',
//           name: 'File 2',
//         ),
//       );
//
//       final result = MediaModel.findTheNotUploaded(
//         allMedias: [media1, media2],
//         uploadedMedias: [],
//       );
//
//       expect(result, equals([media1, media2]));
//     });
//
//   });
//
// }
