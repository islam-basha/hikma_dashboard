import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:motion_toast/motion_toast.dart';

import '../data/login_repository.dart';


class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController textFieldTextController = TextEditingController();
  FocusNode textFieldFocusNode1 = FocusNode();

  TextEditingController textController2 = TextEditingController();
  FocusNode textFieldFocusNode2 = FocusNode();

  LogInRepository logInRepository=LogInRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          toolbarHeight: 170,
          backgroundColor: Color(0xFF994EF8),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
          ),
          automaticallyImplyLeading: false,
          title: const Text(
            'لوحة المشرفين',
            style: TextStyle(
              fontFamily: 'Cairo',
              color: Colors.white,
              fontSize: 28.0,
              letterSpacing: 0.0,
            ),
          ),
          centerTitle: true,
          elevation: 2.0,
          //leading: Icon(Icons.arrow_back,color: Colors.white,),
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Image.asset('assets/images/login.png',width: 350,),
                ),
                SizedBox(
                  width: 300.0,
                  child: TextFormField(
                    controller: textFieldTextController,
                    focusNode: textFieldFocusNode1,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    autofocus: false,
                    obscureText: false,
                    decoration: InputDecoration(
                      isDense: true,
                      labelStyle: TextStyle(
                        fontFamily: 'Cairo',
                        letterSpacing: 0.0,
                      ),
                      hintText: 'اسم المستخدم',
                      hintStyle: TextStyle(
                        fontFamily: 'Cairo',
                        letterSpacing: 0.0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                    ),
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      letterSpacing: 0.0,
                    ),
                    textAlign: TextAlign.end,
                    // validator: _model.textFieldTextControllerValidator
                    //     .asValidator(context),
                  ),
                ),
                SizedBox(height: 10,),
                SizedBox(
                  width: 300.0,
                  child: TextFormField(
                    controller: textController2,
                    focusNode: textFieldFocusNode2,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    autofocus: false,
                    obscureText: false,
                    decoration: InputDecoration(
                      isDense: true,
                      labelStyle: TextStyle(
                        fontFamily: 'Inter',
                        letterSpacing: 0.0,
                      ),
                      hintText: 'كلمة المرور',
                      hintStyle: TextStyle(
                        fontFamily: 'Cairo',
                        letterSpacing: 0.0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                    ),
                    style: TextStyle(
                      fontFamily: 'Inter',
                      letterSpacing: 0.0,
                    ),
                    textAlign: TextAlign.end,
                    // validator: _model.textController2Validator
                    //     .asValidator(context),
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: ()async{
                    if(textFieldTextController.text.isNotEmpty && textController2.text.isNotEmpty){
                      if(textController2.text.length < 4){
                        MotionToast m=MotionToast(
                          description: const Text("يجب أن يتكون الرمز السري على الأقل من 4 رموز.",textDirection: TextDirection.rtl,
                            style: TextStyle(color: Colors.white,fontSize: 11),),
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
                      }else{
                        var result = await logInRepository.logIn(textFieldTextController.text.toString(), textController2.text.toString());
                        if(result == true){
                          context.pushNamed('home');
                        }else{
                          MotionToast m=MotionToast(
                            description: const Text("حدث خطأ ما.. الرجاء التأكد من اسم المستخدم وكلمة السر والاتصال بالانترنت.",textDirection: TextDirection.rtl,
                              style: TextStyle(color: Colors.white,fontSize: 11),),
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
                      }
                    }else{
                      MotionToast m=MotionToast(
                        description: const Text("يجب أن تُدخل اسم المستخدم وكلمة السر لتتمكن من الدخول للوحة التحكم!",textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.white,fontSize: 11),),
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

                  },
                  child: Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFF994EF8),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'دخول', style: TextStyle(color: Colors.white,fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
