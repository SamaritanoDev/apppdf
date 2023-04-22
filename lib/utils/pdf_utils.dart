class PdfUtils {
  static String getFileName(String path) {
    final split = path.split('/');
    return split.last;
  }
}
