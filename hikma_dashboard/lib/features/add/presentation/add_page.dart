import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hikma_dashboard/features/add/presentation/provider/books_provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:motion_toast/motion_toast.dart';

import '../data/add_repository.dart';


class TextNotifier extends StateNotifier<String> {
  TextNotifier() : super('صحيح');

  void reset(String v) {
    state = v; // Reset the state
  }
}

final textProvider = StateNotifierProvider<TextNotifier, String>((ref) {
  return TextNotifier();
});

class BookNotifier extends StateNotifier<int> {
  BookNotifier() : super(1);

  void reset(int v) {
    state = v; // Reset the state
  }
}

final bookProvider = StateNotifierProvider<BookNotifier, int>((ref) {
  return BookNotifier();
});

class AddPage extends ConsumerStatefulWidget {
  const AddPage({super.key});

  @override
  ConsumerState<AddPage> createState() => _AddPageState();
}

class _AddPageState extends ConsumerState<AddPage> {
  AddReposirory addReposirory=AddReposirory();

  @override
  Widget build(BuildContext context) {

    TextEditingController textEditingController1 = TextEditingController();

    var dataNotifier = ref.watch(booksNotifier);
    var data = ref.read(booksNotifier.notifier);
    
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        scrolledUnderElevation: 0,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('أدخل بيانات الحديث :',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w400),),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text('حكم الحديث :  ',style: TextStyle(fontSize: 18),),
                  Container(
                    width: 150,
                    height: 44,
                    padding: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade400,width: 1.5)
                    ),
                    alignment: Alignment.center,
                    child:DropdownButton<String>(
                      value:  ref.watch(textProvider),
                      alignment: Alignment.center,
                      onChanged: (String? value) {
                        ref.read(textProvider.notifier).reset(value!);
                      },
                      items: <String>['منكر','ضعيف','حسن','صحيح']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 16),
                          ),
                        );
                      }).toList(),
                      underline: const Text(""),

                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text('من كتاب :  ',style: TextStyle(fontSize: 18),),
                  dataNotifier.when(data: (_){
                    var list=data.cardsList;
                    var selected=data.cardsList![0].id;
                    return Container(
                      width: 180,
                      height: 44,
                      padding: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade400,width: 1.5)
                      ),
                      alignment: Alignment.center,
                      child:DropdownButtonFormField(
                        value: selected,
                        items:List.generate(list!.length, (index) =>
                            DropdownMenuItem(value: list![index].id,
                                child: Text( list![index].name,style: const TextStyle(fontSize: 14),)),),
                        onChanged: (int? newValue){
                          setState(() {
                            selected=newValue!;
                          });
                          ref.read(bookProvider.notifier).reset(newValue!);
                        },
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                            border: OutlineInputBorder(borderSide: BorderSide.none),
                            contentPadding: EdgeInsets.all(5)
                        ),
                        padding: const EdgeInsets.all(0.5),
                      ),
                    );
                  },
                      error: (Object error, StackTrace stackTrace) {
                        return const Column(
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('حدث خطأ ما!!',style: TextStyle(fontSize: 16),)
                              ],),
                          ],
                        );
                      },
                      loading: () {
                        return Center(child: LoadingAnimationWidget.hexagonDots(color: Colors.deepPurpleAccent, size: 50));
                      }),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 2,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: TextField(
                  controller: textEditingController1,
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  decoration: InputDecoration(
                      hintText: 'أدخل نصّ الحديث ...',
                      hintStyle: TextStyle(fontSize: 16,color: Colors.grey),
                      border: InputBorder.none
                  ),
                  maxLines: 10,
                ),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: ()async{
                  if(textEditingController1.text.isNotEmpty){
                    var result = await addReposirory.addHadith(textEditingController1.text.toString(), ref.watch(textProvider), ref.watch(bookProvider).toString());
                    if(result=="1"){
                      MotionToast m=MotionToast(
                        description: const Text('تمت عملية إضافة الحديث بنجاح',textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.white),),
                        toastDuration: const Duration(seconds: 3),
                        //layoutOrientation: TextDirection.rtl,
                        primaryColor: Colors.green,
                        secondaryColor: Colors.white,
                        displaySideBar: false,
                        icon: Icons.check_circle_outline,
                        height: 60,
                        width: double.infinity,
                      );
                      m.show(context);
                      context.pushNamed('home');
                    }else{
                      MotionToast m=MotionToast(
                        description: const Text("حدث خطأ ما.. الرجاء المحاولة لاحقا والتأكد من اتصالك بالانترنت.",textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.white),),
                        toastDuration: const Duration(seconds: 3),
                        layoutOrientation: TextDirection.rtl,
                        primaryColor: Colors.red,
                        secondaryColor: Colors.white,
                        displaySideBar: false,
                        icon: Icons.error,
                        height: 60,
                        width: double.infinity,
                      );
                      m.show(context);
                    }
                  }else{
                    MotionToast m=MotionToast(
                      description: const Text("الرجاء كتابة نص الحديث .",textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.white),),
                      toastDuration: const Duration(seconds: 1),
                      layoutOrientation: TextDirection.rtl,
                      primaryColor: Colors.red,
                      secondaryColor: Colors.white,
                      displaySideBar: false,
                      icon: Icons.error,
                      height: 60,
                      width: double.infinity,
                    );
                    m.show(context);
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xffA265FE),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(child: Text('إضافة الحديث' ,style: TextStyle(color: Colors.white,fontSize: 16),)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
