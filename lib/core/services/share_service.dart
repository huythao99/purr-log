import 'package:share_plus/share_plus.dart';

class ShareService {
  Future<void> shareFile(String filePath, {String? subject}) async {
    final file = XFile(filePath);
    await Share.shareXFiles(
      [file],
      subject: subject,
    );
  }

  Future<void> shareText(String text, {String? subject}) async {
    await Share.share(text, subject: subject);
  }
}
