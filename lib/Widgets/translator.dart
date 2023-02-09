import 'package:translator/translator.dart';
import '../globals.dart' as globals;

translateLanguage() {
  final translator = GoogleTranslator();
  globals.generalContentArray.forEach((key, value) {
    translator.translate(value.toString(), to: globals.language).then((result) {
      globals.generalContentArray[key] = result.toString();
      
    });
    
  });
  print(globals.generalContentArray);
}
