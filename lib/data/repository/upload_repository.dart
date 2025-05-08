abstract class UploadRepository {
  Future<void> upload({
    String? filePath,
    String? fileName,
  });
  Future<void> sharePoster({
    String? filePath
  });
}
