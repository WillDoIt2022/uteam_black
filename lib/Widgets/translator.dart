import 'package:translator/translator.dart';
import '../globals.dart' as globals;

translateLanguage() {
  print("I'm here");
  print(globals.language);
  if (globals.language == "en") {
    return;
  } else {
   final translator = GoogleTranslator();
    globals.generalContentArray.forEach((key, value) {
      translator
          .translate(value.toString(), to: globals.language)
          .then((result) {
            print("result = $result");
        globals.generalContentArray[key] = result.toString();
        
      });
    });

    print(globals.generalContentArray);
  }
}
