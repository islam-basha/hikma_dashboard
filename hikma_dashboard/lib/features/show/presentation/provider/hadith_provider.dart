import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/get_ahadith_repository.dart';
import '../../domain/hadith_model.dart';

class HadithNotifier extends AutoDisposeFamilyAsyncNotifier<void, String> {

  Object? key;
  HadithModel? hadith;


  @override
  FutureOr build(String companyId) {
    key = Object();
    ref.onDispose(() {
      key = null;
    });
    return showHadithById(companyId);
  }

  Future showHadithById(
      String id
      ) async {
    state = const AsyncValue.loading();
    final key = this.key;
    try{
      hadith = await GetAhadithRepository().showFuturehadithById(id);
      if (key != this.key) {
        return null;
      }
      state=AsyncValue.data(hadith);
      return hadith;
    }catch(ex){
      print('============  $ex');
    }

  }

}

final hadithNotifier = AsyncNotifierProvider.autoDispose.family<HadithNotifier, void, String>(HadithNotifier.new);