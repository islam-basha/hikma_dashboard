
import '../../../app/core/api/dio.dart';
import '../../../app/core/api/end_points.dart';

class EditRepository {

  static EditRepository? _instance;

  // Private constructor
  EditRepository._();

  factory EditRepository() {
    _instance ??= EditRepository._();
    return _instance!;
  }

  Future<String?> editHadith(String id,String hadith, String hokm) async {
    try {
      final response = await ApiManager.dio.get(
        '${EndPoints.BASEURL}${EndPoints.UpdateHadith}?id=$id&hadith=$hadith&hokm=$hokm',
      );
      return response.data.toString();
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }


}