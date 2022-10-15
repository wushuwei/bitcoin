import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/model/android_battery_info.dart';
//import for android
// import 'package:battery_info/model/iso_battery_info.dart';
//import for iOS
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState(){
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

  String batterylevel = "",
      batteryhealth = "",
      chargingstatus = "",
      pluggedstatus = "";

  @override
  void initState() {

    AndroidBatteryInfo? infoandroid = AndroidBatteryInfo();
    //IosBatteryInfo infoios = IosBatteryInfo(); use for iOS
    //only battery level and charging status are retrived from iOS

    Future.delayed(Duration.zero, () async { //there is async (await) execution inside it
      infoandroid = await BatteryInfoPlugin().androidBatteryInfo;
      // infoios = await BatteryInfoPlugin().iosBatteryInfo;  for iOS
      batterylevel = infoandroid!.batteryLevel.toString();
      batteryhealth = infoandroid!.health.toString();
      chargingstatus = infoandroid!.chargingStatus.toString();
      pluggedstatus = infoandroid!.pluggedStatus.toString();

      setState(() {
        //refresh UI
      });
    });

    BatteryInfoPlugin().androidBatteryInfoStream.listen((AndroidBatteryInfo? batteryInfo) {
      //add listiner to update values if there is changes
      infoandroid = batteryInfo;
      batterylevel = infoandroid!.batteryLevel.toString();
      batteryhealth = infoandroid!.health.toString();
      chargingstatus = infoandroid!.chargingStatus.toString();
      pluggedstatus = infoandroid!.pluggedStatus.toString();

      setState(() {
        //refresh UI
      });
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test App",
      home: Scaffold(
          appBar: AppBar(
            title: Text("Battery Info"),
            backgroundColor: Colors.redAccent,
          ),

          body: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text("Battery Level: $batterylevel %"),
                  Text("Battery Health: $batteryhealth"),
                  Text("Charging Status: $chargingstatus"),
                  //values: ChargingStatus.charging, discharging, full, unkown
                  //
                  Text("Plugged Status : $pluggedstatus"),
                ],
              )
          )
      ),
    );
  }
}