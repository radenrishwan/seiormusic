import 'dart:io';

import 'package:ffmpeg_cli/ffmpeg_cli.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:seiormusic/exception/file_exception.dart';
import 'package:seiormusic/models/audio.dart';
import 'package:seiormusic/repository/audio_repository.dart';
import 'package:seiormusic/repository/impl/audio_repository_impl.dart';

class SettingProvider extends ChangeNotifier {
  final String _initialDirectory = Platform.environment['HOME'] ?? '/';
  final AudioRepository _audioRepository = AudioRepositoryImpl();

  Future<FilePickerResult?> findFilePath() async {
    final files = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      allowedExtensions: ['mp3', 'wav', 'flac', 'm4a'],
      initialDirectory: _initialDirectory,
    );

    if (files == null) {
      return null;
    }

    for (var file in files.files) {
      if (file.extension != 'mp3' && file.extension != 'wav' && file.extension != 'flac' && file.extension != 'm4a') {
        throw FileException('${file.name} is not a valid file type');
      }
    }

    return files;
  }

  Future<void> addToDatabase() async {
    final FilePickerResult? filePaths = await findFilePath();

    if (filePaths == null) {
      throw FileException('No file selected');
    }

    for (var file in filePaths.files) {
      final attribute = await Ffprobe.run(file.path!);

      _audioRepository.insert(Audio(
        artist: 'Unknown',
        duration: (attribute.format!.duration ?? '').toString(),
        path: file.path!,
        title: file.name,
        thumbnail: '',
        favorite: false,
      ));
    }
  }
}
