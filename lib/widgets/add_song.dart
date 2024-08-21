import 'dart:io' as io;
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

class AddSong extends StatefulWidget {
  const AddSong({super.key});

  @override
  _AddSongState createState() => _AddSongState();
}

class _AddSongState extends State<AddSong> {
  io.File? _selectedFile;

  Future<void> _pickFile() async {
    // 모바일 및 데스크톱 환경에서 파일 선택
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'm4a'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedFile = io.File(result.files.single.path!);
      });
    }
  }

  Future<void> _uploadFile() async {
    if (_selectedFile == null) return;

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('https://your-server.com/upload'),
    );

    request.files.add(await http.MultipartFile.fromPath(
      'file',
      _selectedFile!.path,
    ));

    final response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('File uploaded successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('File upload failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add a New Song',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white, // 화살표 색상을 하얀색으로 설정
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _pickFile,
              child: const Text('Select a Song File'),
            ),
            const SizedBox(height: 16.0),
            if (!kIsWeb && _selectedFile != null)
              Text(
                'Selected file: ${_selectedFile!.path.split('/').last}',
                style: const TextStyle(color: Colors.white),
              ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _uploadFile,
              child: const Text('Upload Song'),
            ),
          ],
        ),
      ),
    );
  }
}
