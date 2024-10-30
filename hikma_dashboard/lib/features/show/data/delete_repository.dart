
import '../../../app/core/api/dio.dart';
import '../../../app/core/api/end_points.dart';

class DeleteReposirory {

  static DeleteReposirory? _instance;

  // Private constructor
  DeleteReposirory._();

  factory DeleteReposirory() {
    _instance ??= DeleteReposirory._();
    return _instance!;
  }

  Future<String?> deleteHadith(int id) async {
    try {
      final response = await ApiManager.dio.get(
        '${EndPoints.BASEURL}${EndPoints.DeleteHadith}?id=$id',
      );
      return response.data.toString();
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }


}