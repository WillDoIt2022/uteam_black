import 'package:dio/dio.dart';
import '../globals.dart' as globals;
// ignore_for_file: prefer_const_constructors

getUULID(uulidLevel, levelTarget) async {
  Dio dio = Dio(); //initilize dio package
  print("levelTarget");
  print(levelTarget);
  int i = levelTarget - 1;

  if (globals.uulidDB.length > levelTarget && levelTarget != 0) {
    globals.uulidDB.length = levelTarget;

    List<String> strarray = globals.fullPath.split(".");
    strarray.length = i;
    globals.fullPath = strarray.join(".");
    print("Path length after substring");
    print(globals.uulidDB);
    print(globals.fullPath);
    //globals.fullPath = globals.fullPath.substring(0, ((i * 2) - 1));
    //print(globals.fullPath.substring(0, ((i * 2) - 1)));
  }
  if (levelTarget == 0) {
    globals.fullPath = "";
  } else if (levelTarget == 1) {
    globals.fullPath = globals.fullPath + uulidLevel.toString();
  } else if (levelTarget > 1) {
    globals.fullPath = globals.fullPath + '.' + uulidLevel.toString();
  }
  print("fullPath");
  print(globals.fullPath);
  String apiurl =
      "https://5mrtknmr59.execute-api.ap-southeast-1.amazonaws.com/dev/uulid/get?startNode=${globals.fullPath}";
  //String apiurl ="https://5mrtknmr59.execute-api.ap-southeast-1.amazonaws.com/dev/uulid/get?startNode=1";
  List<String> labels = [];
  try {
    Response response = await dio.get(apiurl);
    if (response.statusCode == 200) {
      print("I'm here");
      print(response.data);

      response.data.forEach((item) {
        //print(item);

        //if (item["n"]["properties"]["Label_FR"] != null) {
          if (item["n"]["properties"]["ID label"] != null) {
          final label = item["n"]["properties"]["ID label"].toString();
          print(label);
          labels.add(label);
          //Labelss.add(uulidText);
        }
      });
      if (labels.isNotEmpty) {
        globals.uulidDB.add({levelTarget.toString(): labels});
        print("globals.uulidDB");
        print(globals.uulidDB);

        //return labels;
      } else {
        //Checking, delete last user uulid path, if he is selecting another one uulid on the last Level of uulid
        String fullPathLength =
            globals.fullPath.replaceAll(RegExp('[^0-9]'), '');
        if (fullPathLength.length != globals.uulidDB.length) {
          globals.fullPath =
              globals.fullPath.substring(0, ((globals.fullPath.length) - 4));
          globals.fullPath = globals.fullPath + '.' + uulidLevel.toString();
        }

        print("globals.uulidDB");
        print(globals.uulidDB);
        print(globals.fullPath);
        print(globals.uulidDB.length);
        print(fullPathLength.length);
        //return labels;
      }
      print("Возвращаю labels");
      print(globals.uulidDB);
      print(labels);
      print(globals.fullPath);
      return labels;
      //print(globals.uulidDBLevelTwo);
      //print(Labels);

    } else {
      print("error while fetching uulid data");
      return "misstake";
    }
  } catch (e) {
    print(e);
    print("error while fetching uulid data2");
    return e.toString();
  } //send get request to API URL
}
