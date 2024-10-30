import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hikma_dashboard/features/show/presentation/provider/get_ahadit_provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:motion_toast/motion_toast.dart';

import '../data/delete_repository.dart';
import '../domain/ahadith_model.dart';

class ShowPage extends ConsumerStatefulWidget {
  const ShowPage({super.key});

  @override
  ConsumerState<ShowPage> createState() => _ShowPageState();
}

class _ShowPageState extends ConsumerState<ShowPage> {
  final TextEditingController _searchController = TextEditingController();
  late List<AhadithModel> ahadith;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var mainSearchNotifier = ref.watch(mainSearchProvider);
    ahadith = ref.read(mainSearchProvider.notifier).ahadithList ?? [];

    // Filter cards based on user input
    List<AhadithModel> filteredCards = ahadith.where((hadith) {
      return hadith.hadith.toLowerCase().contains(_searchController.text.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.deepPurple),
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: ()=>ref.invalidate(mainSearchProvider),
              child: Icon(Icons.refresh,),
            ),
          ),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: TextField(
                    controller: _searchController,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.search,
                    style: const TextStyle(fontSize: 14),
                    onChanged: (value) {
                      setState(() {}); // Rebuild the widget on input change
                    },
                    onTapOutside: (event) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color(0xffF4F4F4),
                      hintText: "ابحث ..",
                      hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
                      suffixIcon: Icon(
                        Icons.search_sharp,
                        size: 30,
                        color: Color(0xffCCCCCC),
                      ),
                      contentPadding: EdgeInsets.only(right: 10, bottom: 5, top: 10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              mainSearchNotifier.when(
                  data: (data) {
                    return Expanded(
                      child: ListView.separated(
                        itemCount: filteredCards.length,
                        itemBuilder: (context, index) {
                          final hadith = filteredCards[index];
                          return ListTile(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
                                side:  BorderSide(color: Colors.grey.shade300,width: 2)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 1),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('الحديث '+hadith.id.toString(),maxLines: 1,style: TextStyle(fontSize: 10,fontWeight: FontWeight.w200,color: Colors.grey),),
                                Text(hadith.hadith,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap:(){
                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.noHeader,
                                          dismissOnTouchOutside: true,
                                          animType: AnimType.scale,
                                          showCloseIcon: true,
                                          title: 'حذف الحديث',
                                          desc: 'هل أنت متأكد من رغبتك في حذف هذا الحديث نهائيا من التطبيق؟',
                                          btnCancelOnPress: () {},
                                          btnOkOnPress: () async{
                                            var response = await DeleteReposirory().deleteHadith(hadith.id);

                                              MotionToast m=MotionToast(
                                                description: const Text('تمت عملية حذف الحديث بنجاح',textDirection: TextDirection.rtl,
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
                                          padding: EdgeInsets.all(5),
                                          btnCancelColor: Colors.green,
                                          btnCancelText: 'إلغاء',
                                          btnOkText: 'نعم',
                                          btnOkColor: Colors.red,
                                          transitionAnimationDuration: Duration(milliseconds: 400),
                                          titleTextStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),
                                          buttonsBorderRadius: BorderRadius.circular(10),

                                        ).show();
                                      },
                                      child: Container(
                                        width: 80,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.redAccent
                                        ),
                                        child: Center(child: Text('حذف', style: TextStyle(color: Colors.white),)),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    GestureDetector(
                                      onTap: (){
                                        context.pushNamed('edit',extra: hadith.id.toString());
                                      },
                                      child: Container(
                                        width: 80,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.green
                                        ),
                                        child: Center(child: Text('تعديل', style: TextStyle(color: Colors.white),)),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            leading: Image.asset(
                              'assets/images/arabic.png',
                              fit: BoxFit.fill,
                              width: 40,
                              height: 40,
                            ),
                          );
                        }, separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 10,);
                      },

                      ),
                    );
                  },
                  loading: () {
                    return Center(child: LoadingAnimationWidget.inkDrop(color: Colors.deepPurpleAccent, size: 30));
                  },
                  error: (error, stack){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('لا توجد أحاديث في الوقت الحالي!',style: TextStyle(fontSize: 16),)
                          ],),

                      ],
                    );
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
