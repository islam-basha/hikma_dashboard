import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hikma_dashboard/features/add/domain/books_model.dart';
import '../../../app/core/api/dio.dart';
import '../../../app/core/api/end_points.dart';

class AddReposirory {

  static AddReposirory? _instance;

  // Private constructor
  AddReposirory._();

  factory AddReposirory() {
    _instance ??= AddReposirory._();
    return _instance!;
  }

  Future<List<BooksModel>?> showFutureBooks() async {
    try {
      return await ApiManager.dio.get(

        '${EndPoints.BASEURL}${EndPoints.GetAllBooks}',
      ).then((response){
        var data = response.data as List<dynamic>;
        print(data);
        return data.map((t)=>BooksModel.fromJson(t)).toList();
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