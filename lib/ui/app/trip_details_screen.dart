import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tour_app_firebase/models/app/trip_model.dart';
import 'package:flutter_tour_app_firebase/stores/trip/trip_store.dart';
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



  TextEditingController _phoneController = TextEditingController();
  bool _obscureText = false;
  bool _obscure = false;
  var type =0;
  int currentTap=0;
  QueryDocumentSnapshot<Object?>? doc=null;
  //stores:---------------------------------------------------------------------

  late ThemeStore _themeStore;
  late LanguageStore _languageStore;
  late TripStore _tripStore;


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
    _tripStore=Provider.of<TripStore>(context);


    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    doc=arguments['data'];
    type=arguments['type'];
    print("id-details");
    print(doc?.id.toString());


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
                 doc?.get("trip_img"),
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
                     Text(doc?.get("date"))
                   ],
                 ),
                 const SizedBox(height: 16),
                 Text(doc?.get("trip_name"),style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                 Text(doc?.get("subtitle"),style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w500,color: Colors.grey),),
                 const SizedBox(height: 16),
                 Text(doc?.get("details"),style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w500,color: Colors.grey),),
                 const SizedBox(height: 16),
                 MaterialButton(
                   color: Colors.redAccent,
                   onPressed: (){
                     _bookedTrip();
                   },
                   shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(10)),
                   minWidth: MediaQuery.of(context).size.width,
                   height: 50,

                   child: doc?.get("isbooked")==true?
                      Text('Cancle',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white
                      ))
                       :
                     Text('Book now',style: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 15,
                         color: Colors.white
                     ),
                     ),
                 ),
                 const SizedBox(height: 30),


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

  void _bookedTrip() {
    _tripStore.bookedTrip(doc?.id.toString(),type);
  }


   navigate(BuildContext context,int type) {
    if (type == 1) {
      Future.delayed(Duration(milliseconds: 0), () {
        Navigator.of(context).pushNamed(Routes.bookedTrip);
      });
    }

  }

}
