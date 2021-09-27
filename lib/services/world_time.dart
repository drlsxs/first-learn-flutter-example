import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';


class WorldTime {
  late String location; // location name for the UI
  late String time;   // the time that location
  late String flag;  // url to an  asset icon
  late String url;  //location url for api endpoint
  late bool isDaytime;


  WorldTime({ required this.location, required this.flag, required this.url });



  Future<void> getTime() async {

    try{
      //make the request
      Response response  = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      //get properties from data
      String datetime = data['datetime'];
      String offset =  data['utc_offset'].substring(1,3);

      // print(datetime);
      // print(offset);
      DateTime now = DateTime.parse(datetime);
      now =  now.add(Duration(hours: int.parse(offset)));



      // set the time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat().add_jm().format(now);
    }catch(e){
      print('caught error $e');
      time = "could not get time data";

    }




  }




}





