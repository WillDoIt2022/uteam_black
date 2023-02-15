import '../globals.dart' as globals;

languageDeterminer() {
  //Albanian
  if (globals.language == "al") {
    globals.language = "sq";
  } //Belarusian
  else if (globals.language == "by") {
    globals.language = "be";
  } //Bulgarian
  else if (globals.language == "bg") {
    globals.language = "bg";
  } //Croatian
  else if (globals.language == "hr") {
    globals.language = "hr";
  } //Czech
  else if (globals.language == "cz") {
    globals.language = "cs";
  } //Dutch
  else if (globals.language == "nl") {
    globals.language = "nl";
  } //Danish
  else if (globals.language == "dk") {
    globals.language = "da";
  } //Estonian
  else if (globals.language == "ee") {
    globals.language = "et";
  } //Finnish
  else if (globals.language == "fi") {
    globals.language = "fi";
  } //France
  else if (globals.language == "fr") {
    globals.language = "fr";
  } //Germany
  else if (globals.language == "de") {
    globals.language = "de";
  } //Hungarian
  else if (globals.language == "hu") {
    globals.language = "hu";
  } //Indonesian
  else if (globals.language == "id") {
    globals.language = "id";
  } //Irish
  else if (globals.language == "ie") {
    globals.language = "ga";
  } //Icelandic
  else if (globals.language == "is") {
    globals.language = "is";
  } //Italian
  else if (globals.language == "it") {
    globals.language = "it";
  } //Great Britain
  else if (globals.language == "gb") {
    globals.language = "en";
  } //Greek
  else if (globals.language == "gr") {
    globals.language = "el";
  } //Japanese
  else if (globals.language == "jp") {
    globals.language = "ja";
  } //Korean
  else if (globals.language == "kr") {
    globals.language = "ko";
  } //Latvian
  else if (globals.language == "lv") {
    globals.language = "lv";
  } //Lithuanian
  else if (globals.language == "lt") {
    globals.language = "lt";
  } //Malaysian
  else if (globals.language == "my") {
    globals.language = "ms";
  } //Macedonian
  else if (globals.language == "mk") {
    globals.language = "mk";
  } //Maltese
  else if (globals.language == "mt") {
    globals.language = "mt";
  } //Norwegian
  else if (globals.language == "no") {
    globals.language = "no";
  } //Polish
  else if (globals.language == "pl") {
    globals.language = "pl";
  } //Portuguese
  else if (globals.language == "pt") {
    globals.language = "pt";
  } //Serbian
  else if (globals.language == "rs") {
    globals.language = "sr";
  } //Romanian
  else if (globals.language == "ro") {
    globals.language = "ro";
  } //Russia
  else if (globals.language == "ru") {
    globals.language = "ru";
  } //Swedish
  else if (globals.language == "se") {
    globals.language = "sv";
  } //Slovenian
  else if (globals.language == "si") {
    globals.language = "sl";
  } //Slovak
  else if (globals.language == "sk") {
    globals.language = "sk";
  } //Spain
  else if (globals.language == "es") {
    globals.language = "es";
  } //Turkish
  else if (globals.language == "tr") {
    globals.language = "tr";
  } //Thai
  else if (globals.language == "th") {
    globals.language = "th";
  } //Ukrainian
  else if (globals.language == "ua") {
    globals.language = "uk";
  } //USA
  else if (globals.language == "us") {
    globals.language = "en";
  } //Vietnamese
  else if (globals.language == "vn") {
    globals.language = "vi";
  } //All other languages
  else {
    globals.language = "en";
  }
}
