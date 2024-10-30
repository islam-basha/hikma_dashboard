
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/core/api/dio.dart';
import '../../../app/core/api/end_points.dart';
import '../domain/ahadith_model.dart';
import '../domain/hadith_model.dart';

class GetAhadithRepository {

  static GetAhadithRepository? _instance;

  // Private constructor
  GetAhadithRepository._();

  factory GetAhadithRepository() {
    _instance ??= GetAhadithRepository._();
    return _instance!;
  }

  Future<List<AhadithModel>?> showFutureAhadith(AutoDisposeAsyncNotifierProviderRef<dynamic> ref) async {
    try {
      var response= await ApiManager.dio.get(
        '${EndPoints.BASEURL}${EndPoints.GetAllAhadith}',
      );
      if (response.statusCode == 200) {
        var data = response.data as List<dynamic>;
        return data.map((t) => AhadithModel.fromJson(t)).toList();
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } on Exception catch (failure) {
      print(failure);
      return null;
    }
  }

  Future<HadithModel?> showFuturehadithById(String id) async {
    try {
      var response= await ApiManager.dio.get(
        '${EndPoints.BASEURL}${EndPoints.GethadithById}?id=$id',
      );
      if (response.statusCode == 200){
        var a=HadithModel.fromJson(response.data);
        return a;
      }else{
        print('Error: ${response.statusCode}');
        return null;
      }
    } on Exception catch (failure) {
      print(failure);
      return null;
    }
  }

}