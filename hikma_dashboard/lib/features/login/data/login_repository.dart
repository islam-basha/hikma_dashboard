import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hikma_dashboard/features/add/domain/books_model.dart';
import '../../../app/core/api/dio.dart';
import '../../../app/core/api/end_points.dart';

class LogInRepository {

  static LogInRepository? _instance;

  // Private constructor
  LogInRepository._();

  factory LogInRepository() {
    _instance ??= LogInRepository._();
    return _instance!;
  }

  Future<bool?> logIn(String username, String password) async {
    try {
      return await ApiManager.dio.get(

        '${EndPoints.BASEURL}${EndPoints.LogIn}?username=$username&password=$password',
      ).then((response){
        var data = response.data;
        return data;
      });
    } on Exception catch (failure) {
      print(failure);
      return null;
    }
  }

  Future<String?> addHadith(String hadith, String hokm, String bookId) async {
    try {
      final response = await ApiManager.dio.post(
        '${EndPoints.BASEURL}${EndPoints.AddNewHadith}?hadith=$hadith&hokm=$hokm&bookId=$bookId',
      );
      return response.data.toString();
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }


}