import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Record_local {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    print('${directory.path}');
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/past_recommend.txt');
  }

  Future<List<String>> read_record() async {
    try {
      final file = await _localFile;

      // Read the file
      var contents = await file.readAsString();
      contents = contents.replaceAll("[", "");
      contents = contents.replaceAll("]", "");
      return contents.split(',').toList();
    } catch (e) {
      // If encountering an error, return 0
      return e;
    }
  }

  Future<File> write_read(String recommend) async {
    final file = await _localFile;
    print("write text :${recommend}");
    // Write the file
    return file.writeAsString('$recommend');
  }
}
