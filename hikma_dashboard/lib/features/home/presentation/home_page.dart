import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        actions:[
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
                onTap: (){
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.noHeader,
                    dismissOnTouchOutside: true,
                    animType: AnimType.scale,
                    showCloseIcon: true,
                    title: 'تسجيل الخروج',
                    desc: 'هل أنت متأكد من رغبتك في تسجيل خروجك من التطبيق؟',
                    btnCancelOnPress: () {},
                    btnOkOnPress: () async{
                      context.pushNamed('intro');
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
                child: Icon(Icons.logout,color: Colors.deepPurple,)),
          ),
        ]
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/card.png'),
              SizedBox(height: 20,),
              Text('يمكنك :',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
              SizedBox(height: 20,),
              Center(
                child: Wrap(
                  spacing: 10,
                  alignment: WrapAlignment.center,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: ()=> context.pushNamed('add'),
                        child: Image.asset('assets/images/addCard.png',width: 150,)),
                    // Image.asset('assets/images/editCard.png',width: 150,),
                    // Image.asset('assets/images/deleteCard.png',width: 150,),
                    GestureDetector(
                        onTap: ()=>context.pushNamed('show'),
                        child: Image.asset('assets/images/showCard.png',width: 150,)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
