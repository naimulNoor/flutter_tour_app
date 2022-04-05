import 'package:cloud_firestore/cloud_firestore.dart';
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

class BookedTripScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<BookedTripScreen> with TickerProviderStateMixin{
  //text controllers:-----------------------------------------------------------


  int checkedIndex = 0;


  TextEditingController _phoneController = TextEditingController();
  bool _obscureText = false;
  bool _obscure = false;

  int currentTap=0;

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


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar:AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Icon(Icons.chevron_left,color: Colors.blue,),
        title: Text("Booked Trip",style: TextStyle(color: Colors.blue),),
      ),
      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return  SafeArea(
        child: Column(
            children: [
              _searchBar(),
              Expanded(
                child: _bookedTrip(),
              )
            ],
      ),
    );
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
      margin: EdgeInsets.all(20),
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

  Widget _bookedTrip() {
    return Container(
      padding: EdgeInsets.all(15.0),
            child: StreamBuilder<QuerySnapshot>(
                stream: _tripStore.getBookedTripList(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){

                    print(snapshot.data?.docs[0].id.toString());
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data?.size,
                        itemBuilder: (context,i){
                          return Container(
                            width: 300,
                            margin: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Stack(
                                      clipBehavior: Clip.none,
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Colors.blue,
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(snapshot.data?.docs[i].get("trip_img"))
                                              )
                                          ),
                                          height: 100,width: 120,
                                        ),

                                      ],
                                    ),
                                    SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(snapshot.data?.docs[i].get("trip_name"),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
                                        SizedBox(height: 2,),
                                        Container(
                                            width: 100,
                                            child: Text(snapshot.data?.docs[i].get("subtitle"),overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.grey,fontSize: 12.0),)),
                                        SizedBox(height: 2,),
                                        Row(
                                          children: [
                                            Icon(Icons.calendar_today,size: 15.0,),
                                            SizedBox(width: 10.0,),
                                            Text(snapshot.data?.docs[i].get("date"))
                                          ],
                                        ),
                                        SizedBox(height: 2,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(snapshot.data?.docs[i].get("ndkdata"),style: TextStyle(color: Colors.blue),),
                                                SizedBox(width: 10.0),
                                                Text(snapshot.data?.docs[i].get("dager"),style: TextStyle(color: Colors.grey),),

                                              ],
                                            ),

                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),

                                InkWell(
                                    onTap: (){
                                      navigate(context,snapshot.data?.docs[i],1);
                                    },
                                    child: CircleAvatar(child: Icon(Icons.arrow_forward,color: Colors.white,),backgroundColor: Colors.orange,)),


                              ],
                            ),
                          );
                        });
                  }
                  return Container(
                      child: CircularProgressIndicator());

                }
            ),
          );
  }

  navigate(BuildContext context, QueryDocumentSnapshot<Object?>? doc, int i) {

    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushNamed(Routes.trip_details,arguments:
      {
        "data":doc,
        "type":i,
      }
      );
    });
  }


  // General Methods:-----------------------------------------------------------

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
   _phoneController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }


}
