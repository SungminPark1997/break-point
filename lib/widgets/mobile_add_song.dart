import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

Future<io.File?> pickFileMobile() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['mp3', 'wav', 'm4a'],
  );

  if (result != null && result.files.isNotEmpty) {
    return io.File(result.files.single.path!);
  }
  return null;
}

Future<bool> uploadFileMobile(io.File file) async {
  final request = http.MultipartRequest(
    'POST',
    Uri.parse('https://your-server.com/upload'),
  );

  request.files.add(await http.MultipartFile.fromPath('file', file.path));
  final response = await request.send();

  return response.statusCode == 200;
}
