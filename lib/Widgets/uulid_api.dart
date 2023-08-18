import 'package:dio/dio.dart';
import '../globals.dart' as globals;
// ignore_for_file: prefer_const_constructors

getUULID(uulidLevel, levelTarget) async {
  Dio dio = Dio(); //initilize dio package

  String apiurl =
      "https://5mrtknmr59.execute-api.ap-southeast-1.amazonaws.com/dev/uulid/get?startNode=$uulidLevel";
  //String apiurl ="https://5mrtknmr59.execute-api.ap-southeast-1.amazonaws.com/dev/uulid/get?startNode=1";
  try {
    Response response = await dio.get(apiurl);
    if (response.statusCode == 200) {
      print("I'm here");
      print(response.data);
      List<String> Labels = [];
      response.data.forEach((item) {
        print(item);
        final label = item["n"]["properties"]["Label_FR"];
        //{"Label_FR":item["n"]["properties"]["Label_FR"];}
        Labels.add(label);
        globals.uulidDB = Labels;
      });
      print(Labels);
      return true;
    } else {
      print("error while fetching uulid data");
      return false;
    }
  } catch (e) {
    print(e);
    return false;
  } //send get request to API URL
}
