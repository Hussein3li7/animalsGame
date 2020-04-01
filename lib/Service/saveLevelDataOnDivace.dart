import 'dart:io';

import 'package:path_provider/path_provider.dart';

class SaveLevelData { 

  Future<String> get localPath async {
    final path = await getApplicationDocumentsDirectory();
    return path.path;
  }

  Future<File> get localFile async {
    final file = await localPath;
    return new File('$file/levelData.txt');
  }

  Future<File> writeData(String level) async {
    final file = await localFile;
    return file.writeAsString(level);
  }

  Future<String> readData() async {
    try {
      final file = await localFile;
      String data = await file.readAsString();
      return data;
    } catch (e) {
      print('No Data');
      return e;
    }
  }
}
