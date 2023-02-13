import '../globals.dart' as globals;

languageDeterminer() {
  if (globals.language == "al") {
    //Albanian
    globals.language = "sq";
  } else if (globals.language == "by") {
    //Belarusian
    globals.language = "be";
  } else if (globals.language == "cz") {
    //Czech
    globals.language = "cs";
  } else if (globals.language == "dk") {
    //Danish
    globals.language = "da";
  } else if (globals.language == "ee") {
    //Estonian
    globals.language = "et";
  } else if (globals.language == "gb") {
    //Great Britain
    globals.language = "en";
  } else if (globals.language == "gr") {
    //Greek
    globals.language = "el";
  } else if (globals.language == "jp") {
    //Japanese
    globals.language = "ja";
  } else if (globals.language == "kr") {
    //Korean
    globals.language = "ko";
  } else if (globals.language == "my") {
    //Malaysian
    globals.language = "ms";
  } else if (globals.language == "rs") {
    //Serbian
    globals.language = "sr";
  } else if (globals.language == "se") {
    //Swedish
    globals.language = "sv";
  } else if (globals.language == "si") {
    //Slovenian
    globals.language = "sl";
  } else if (globals.language == "ua") {
    //Ukrainian
    globals.language = "uk";
  } else if (globals.language == "us") {
    //USA
    globals.language = "en";
  }
}
