
import 'package:cloud_firestore/cloud_firestore.dart';
import 'driver.dart';
class Trip {
  String? id;
  String? tripName;
  String? subtitle;
  String? tripImg;
  String? details;
  String? date;
  String? ndkdata;
  String? dager;
  bool? isBooked;
  int? type;


  Trip({this.id,this.tripName,this.subtitle,this.tripImg,this.details,this.date,this.ndkdata,this.dager,this.isBooked,this.type });

  factory Trip.fromSnapshot(DocumentSnapshot snapshot) {
    final trip = Trip.fromJson(snapshot.data() as Map<String, dynamic>);
    trip.id = snapshot.reference.id;
    return trip;
  }

  factory Trip.fromJson(Map<String, dynamic> json) => _tripFromJson(json);

  Map<String, dynamic> toJson() => _TripToJson(this);

}

Trip _tripFromJson(Map<String, dynamic> json) {
  return Trip(

    id: json['id'] as String?,
    tripName: json['trip_name'] as String?,
    subtitle: json['subtitle'] as String?,
    tripImg: json['trip_img'] as String?,
    details: json['details'] as String?,
    date: json['date'] as String?,
    ndkdata: json['ndkdata'] as String?,
    dager: json['dager'] as String?,
    isBooked: json['isbooked'] as bool?,
    type: json['type'] as int?,

  );
}



Map<String, dynamic> _TripToJson(Trip instance) => <String, dynamic>{
  'id': instance.id,
  'trip_name': instance.tripName,
  'subtitle': instance.subtitle,
  'trip_img': instance.tripImg,
  'details': instance.details,
  'date': instance.date,
  'ndkdata': instance.ndkdata,
  'dager': instance.dager,
  'isbooked': instance.isBooked,
  'type': instance.type,

};

