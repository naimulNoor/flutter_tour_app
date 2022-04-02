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

class TripDetailsScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<TripDetailsScreen> with TickerProviderStateMixin{
  //text controllers:-----------------------------------------------------------


  int checkedIndex = 0;

  List cardNames = [
    'Driver',
    'Verdor',
  ];

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


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.blue,
      appBar: EmptyAppBar(),
      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
   return   SafeArea(
     child: Center(
       child: Stack(
         children: [
           Stack(
             children: [
               Image.network(
                 'https://images.pexels.com/photos/417074/pexels-photo-417074.jpeg',
               ),
               Icon(Icons.chevron_left),

             ],
           ),
           Container(
             margin: EdgeInsets.fromLTRB(0, 200, 0, 0),
             width: double.infinity,
             height: MediaQuery.of(context).size.height,
             padding: const EdgeInsets.all(30),
             decoration: BoxDecoration(
              color: Colors.white,
               borderRadius: const BorderRadius.vertical(
                 top: Radius.circular(40),
               ),
             ),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Row(
                   children: [
                     Icon(Icons.calendar_today,size: 15.0,),
                     SizedBox(width: 10.0,),
                     Text("06/06/2021")
                   ],
                 ),
                 const SizedBox(height: 16),
                 Text('Norge',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                 Text('Test trip details',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w500,color: Colors.grey),),
                 const SizedBox(height: 16),
                 Text('We can also use the fit parameter to define whether our stack should expand to fill the parent widget, or whether it should pass through the fit of child objects directly to the children in the Stack.Broadly speaking, these only apply in more advanced layout scenarios, so we should be fine leaving the fit as StackFit.loose, which is the default.We can also position widgets within the stack itself by using Positioned. If we add a Container with a blue background, place some text in it, and position it at the bottom center, the widget lays out accordingly within the bounds of the Stack.',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w500,color: Colors.grey),),
                 const SizedBox(height: 16),
                 MaterialButton(
                   color: Colors.redAccent,
                   onPressed: (){},
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
               ],
             ),
           ),

         ],
       ),
     ),
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


}
