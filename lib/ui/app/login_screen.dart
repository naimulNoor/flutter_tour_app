import 'package:flutter_tour_app_firebase/stores/firebase_user/firebaseuser_store.dart';
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

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin{
  //text controllers:-----------------------------------------------------------


  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = false;
  bool _obscure = false;

  int currentTap=0;

  //stores:---------------------------------------------------------------------

  late ThemeStore _themeStore;
  late LanguageStore _languageStore;
  late FirebaseUser _firebaseUserStore;


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
    _firebaseUserStore=Provider.of<FirebaseUser>(context);


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
      child: SingleChildScrollView(
        child: Column(
          children: [
            //Form(
            // key: _loginFormKey,
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  Icon(Icons.lock,size: 50.0,),
                  SizedBox(height: 15,),
                  Text("Velkommen til \n Kjetils Bussreiser!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                  SizedBox(height: 20,),



                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please Enter Valid Info';
                      }else{
                        return null;
                      }
                    },
                    // focusNode: _emailNode,
                    textInputAction: TextInputAction.next,
                    //onEditingComplete: () => FocusScope.of(context).requestFocus(_passNode),
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        //labelText: 'Enter username',
                        hintText: "E-post",
                        enabledBorder:OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red,width: 5),
                          borderRadius: BorderRadius.circular(10),
                        )
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please Enter Valid Info';
                      }else{
                        return null;
                      }
                    },
                    // focusNode: _emailNode,
                    textInputAction: TextInputAction.next,
                    //onEditingComplete: () => FocusScope.of(context).requestFocus(_passNode),
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        //labelText: 'Enter username',
                        hintText: "Password",
                        enabledBorder:OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red,width: 5),
                          borderRadius: BorderRadius.circular(10),
                        )
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,

                      children: [
                        Text("Forgot password ?"),
                        Text("Reset",style: TextStyle(color: Colors.blue),)
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  MaterialButton(
                    color: Colors.blue,
                    onPressed: (){
                      _loginTask();
                 },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                    minWidth: MediaQuery.of(context).size.width,
                    height: 50,

                    child: Text(
                      'Neste',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white
                    ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Text("Don't have an account ?"),
                        SizedBox(width: 10,),
                        SizedBox(height: 10,),
                        InkWell(
                            onTap: (){
                              navigate(context,2);
                            },
                            child: Text("Signup",style: TextStyle(color: Colors.blue),))
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),

                  Observer(
                    builder: (context) {
                      print("show-msg");
                      print( _firebaseUserStore.showMessage);
                      return Visibility(
                        visible: _firebaseUserStore.showMessage,
                        child: Text(_firebaseUserStore.errorMsg),
                      );
                    },
                  ),
                  SizedBox(height: 30,),
                  Observer(
                    builder: (context) {
                      return Visibility(
                        visible: _firebaseUserStore.loading,
                        child: CircularProgressIndicator(color: Colors.blue,),
                      );
                    },
                  ),
                  Observer(
                    builder: (context) {
                      print("sucess ::${_firebaseUserStore.userLogin}");
                      return  _firebaseUserStore.userLogin
                          ?navigate(context,1)
                          :Container(); //unsecess message
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget navigate(BuildContext context,int type) {
    if(type==1){
      Future.delayed(Duration(milliseconds: 0), () {
        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.home, (Route<dynamic> route) => false);
      });
      _firebaseUserStore.userLogin=false;
    }
    else if(type==2){
      Future.delayed(Duration(milliseconds: 0), () {
        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.register, (Route<dynamic> route) => false);
      });
    }


    return Container();
  }


  void _loginTask() {
    print('login user');
    _firebaseUserStore.loginUser(_emailController.text,_passwordController.text,context);
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
   _emailController.dispose();
   _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }






}
