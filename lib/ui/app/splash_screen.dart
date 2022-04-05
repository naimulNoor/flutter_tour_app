import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tour_app_firebase/utils/routes/routes.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/foundation.dart';

import 'package:mobx/mobx.dart';


import 'package:flutter_tour_app_firebase/stores/language/language_store.dart';
import 'package:flutter_tour_app_firebase/stores/theme/theme_store.dart';

import 'package:flutter_tour_app_firebase/utils/device/device_utils.dart';
import 'package:flutter_tour_app_firebase/utils/locale/app_localization.dart';
import 'package:flutter_tour_app_firebase/widgets/empty_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  //text controllers:-----------------------------------------------------------



  TextEditingController _phoneController = TextEditingController();
  bool _obscureText = false;
  bool _obscure = false;

  int currentTap=0;

  //stores:---------------------------------------------------------------------

  late ThemeStore _themeStore;
  late LanguageStore _languageStore;


  //focus node:-----------------------------------------------------------------
  late FocusNode _passwordFocusNode;

  //stores:---------------------------------------------------------------------


  TextEditingController? textController1;
  TextEditingController? textController2;
  late bool passwordVisibility;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    passwordVisibility = false;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // initializing stores
    _languageStore = Provider.of<LanguageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _checkUser();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: EmptyAppBar(),
      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return  SafeArea(
      child: Container(
        color: Colors.blue,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text("Tour App",style: TextStyle(fontSize: 30.0,color: Colors.white))),
            SizedBox(height: 50,),
            CircularProgressIndicator()

          ],
        ),

      )
    );
  }





  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        if (message.isNotEmpty) {
          FlushbarHelper.createError(
            message: message,
            title: AppLocalizations.of(context).translate('home_tv_error'),
            duration: Duration(seconds: 3),
          )..show(context);
        }
      });
    }

    return SizedBox.shrink();
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
   _phoneController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Widget navigate(BuildContext context,int type) {
    if(type==1){
      Future.delayed(Duration(milliseconds: 0), () {
        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.login, (Route<dynamic> route) => false);
      });
    }
    else if(type==2){
      Future.delayed(Duration(milliseconds: 0), () {
        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.home, (Route<dynamic> route) => false);
      });
    }


    return Container();
  }


  void _checkUser() async{

      if(FirebaseAuth.instance.currentUser?.uid == null)
      {
        print("logout-user");
        navigate(context,1);
      }
      else{
        print("login-user");
        navigate(context,2);
      }
    }
  }


