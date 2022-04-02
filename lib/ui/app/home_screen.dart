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

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  //text controllers:-----------------------------------------------------------


  int checkedIndex = 0;


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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text("Turer"),
      ),
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
                  _searchBar(),
                  _innenlandsturerSection(),
                  _utenlandsturerSection(),

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

  Widget _searchBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      margin: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(
              Icons.search,
              color: Colors.grey,
              size: 20,
            ),
          ),
          new Expanded(
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search by trip",
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding:
                EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                isDense: true,
              ),
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget _innenlandsturerSection() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Innenlandsturer",style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),),
              Row(
                children: [
                  Text("Se aile",style: TextStyle(color: Colors.blue),),
                  SizedBox(width: 5,),
                  Icon(Icons.arrow_forward,size: 15.0,color: Colors.blue,)
                ],
              ),

            ],
          ),
          SizedBox(height: 10.0,),
          Container(
            height: 300,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context,i){
                  return Container(
                    width: 300,
                    margin: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.blue,
                              ),
                              height: 180,width: MediaQuery.of(context).size.width,
                            ),
                            Positioned(
                                bottom:-20,
                                right:10,
                                child: CircleAvatar(child: Icon(Icons.arrow_forward,color: Colors.white,),backgroundColor: Colors.orange,))
                          ],
                        ),

                        SizedBox(height: 10.0,),
                        Text("Norge",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
                        Text("Demo Tour Details",style: TextStyle(color: Colors.grey,fontSize: 12.0),),
                        SizedBox(height: 18.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.calendar_today,size: 15.0,),
                                SizedBox(width: 10.0,),
                                Text("06/06/2021")
                              ],
                            ),
                            Row(
                              children: [
                                Text("NDK 19990",style: TextStyle(color: Colors.blue),),
                                SizedBox(width: 10.0),
                                Text("9 Dager",style: TextStyle(color: Colors.grey),),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),

    );
  }
  Widget _utenlandsturerSection() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Innenlandsturer",style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),),
              Row(
                children: [
                  Text("Se aile",style: TextStyle(color: Colors.blue),),
                  SizedBox(width: 5,),
                  Icon(Icons.arrow_forward,size: 15.0,color: Colors.blue,)
                ],
              ),

            ],
          ),
          SizedBox(height: 10.0,),
          Container(
            height: 300,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context,i){
                  return Container(
                    width: 300,
                    margin: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.blue,
                              ),
                              height: 180,width: MediaQuery.of(context).size.width,
                            ),
                            Positioned(
                                bottom:-20,
                                right:10,
                                child: CircleAvatar(child: Icon(Icons.arrow_forward,color: Colors.white,),backgroundColor: Colors.orange,))
                          ],
                        ),

                        SizedBox(height: 10.0,),
                        Text("Norge",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
                        Text("Demo Tour Details",style: TextStyle(color: Colors.grey,fontSize: 12.0),),
                        SizedBox(height: 18.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.calendar_today,size: 15.0,),
                                SizedBox(width: 10.0,),
                                Text("06/06/2021")
                              ],
                            ),
                            Row(
                              children: [
                                Text("NDK 19990",style: TextStyle(color: Colors.blue),),
                                SizedBox(width: 10.0),
                                Text("9 Dager",style: TextStyle(color: Colors.grey),),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),

    );
  }




}
