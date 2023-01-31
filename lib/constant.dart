const String SUCCESS_MESSAGE = "You will be contacted by us very soon.";
const List<String> arabicChars = [
  'أ',
  'ب',
  'ت',
  'ث',
  'ج',
  'ح',
  'خ',
  'د',
  'ذ',
  'ر',
  'ز',
  'س',
  'ش',
  'ص',
  'ض',
  'ط',
  'ظ',
  'ع',
  'غ',
  'ف',
  'ق',
  'ك',
  'ل',
  'م',
  'ن',
  'ھ',
  'و',
  'ي'
];

enum Harakat { fatha, kasra }

List<String> getArabCharWithHarakat(String harakat) {
  List<String> result = [];
  for (var i = 0; i < arabicChars.length; i++) {
    var fatha = String.fromCharCode(getHarakatUnicode(harakat));
    String normalizedString = "${arabicChars[i]}$fatha";
    result.add(normalizedString);
  }
  return result;
}

int getHarakatUnicode(String harakat) {
  if (harakat == Harakat.kasra.name) {
    return 0x0650;
  } else {
    return 0x064e;
  }
}
