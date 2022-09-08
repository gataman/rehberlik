///Dart import
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class FileSaveHelper {
  //static const MethodChannel _platformCall = MethodChannel('launchFile');

  static Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    final path = (await getExternalStorageDirectory())?.path;
    if (path != null) {
      final file = File('$path/$fileName');
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open('$path/$fileName');
    }
  }

  /*
  static Future<void> saveAndLaunchFile(
      List<int> bytes, String fileName) async {
    String? path;
    if (Platform.isAndroid ||
        Platform.isIOS ||
        Platform.isLinux ||
        Platform.isWindows) {
      final Directory directory = await getApplicationSupportDirectory();
      path = directory.path;
    } else {
      path = await PathProviderPlatform.instance.getApplicationSupportPath();
    }
    final File file =
        File(Platform.isWindows ? '$path\\$fileName' : '$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    if (Platform.isAndroid || Platform.isIOS) {
      final Map<String, String> argument = <String, String>{
        'file_path': '$path/$fileName'
      };
      try {
        //ignore: unused_local_variable
        final Future<Map<String, String>?> result =
            _platformCall.invokeMethod('viewPdf', argument);
      } catch (e) {
        throw Exception(e);
      }
    } else if (Platform.isWindows) {
      await Process.run('start', <String>['$path\\$fileName'],
          runInShell: true);
    } else if (Platform.isMacOS) {
      await Process.run('open', <String>['$path/$fileName'], runInShell: true);
    } else if (Platform.isLinux) {
      await Process.run('xdg-open', <String>['$path/$fileName'],
          runInShell: true);
    }
  }

   */
}
