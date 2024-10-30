import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hikma_dashboard/features/show/data/edit_repository.dart';
import 'package:hikma_dashboard/features/show/presentation/provider/hadith_provider.dart';
import 'package:motion_toast/motion_toast.dart';

class EditHadithPage extends ConsumerStatefulWidget {
  const EditHadithPage({super.key,required this.hadithId});
  final String hadithId;

  @override
  ConsumerState<EditHadithPage> createState() => _EditHadithPageState();
}

class _EditHadithPageState extends ConsumerState<EditHadithPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController1 = TextEditingController();
    var dataNotifier = ref.watch(hadithNotifier(widget.hadithId));
    var data = ref.read(hadithNotifier(widget.hadithId).notifier);

    data.hadith != null ? textEditingController1.text=data.hadith!.hadith.toString() : ();

    return Scaffold(
      appBar: AppBar(),
      body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text('عدّل بيانات الحديث :',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w400),),
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
                        hintText: ' نصّ الحديث ...',
                        hintStyle: TextStyle(fontSize: 16,color: Colors.grey),
                        border: InputBorder.none,
                    ),
                    maxLines: 10,
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: ()async{
                    var response = await EditRepository().editHadith(widget.hadithId,textEditingController1.text,data.hadith!.hokm);

                    MotionToast m=MotionToast(
                      description: const Text('تمت عملية تعديل الحديث بنجاح',textDirection: TextDirection.rtl,
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
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xffA265FE),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(child: Text('تعديل الحديث' ,style: TextStyle(color: Colors.white,fontSize: 16),)),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
