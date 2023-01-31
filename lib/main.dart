import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const String pageTitle = "Hijaiyah letters with short vowel a";
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: pageTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AudioPlayer audioPlayer;
  int selectedIndex = -1;
  static const List<String> arabicChars = [
    'أَ',
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

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  void initAudioPlayer() {
    audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    audioPlayer.stop();
    super.dispose();
  }

  static List<String> getArabCharWithHarakat(String harakat) {
    List<String> result = [];

    for (var i = 0; i < arabicChars.length; i++) {
      var fatha = String.fromCharCode(0x064e);
      String normalizedString = "${arabicChars[i]}$fatha";
      result.add(normalizedString);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
            Widget>[
          Flexible(child: hijaiyahCardWidget(context)),
          const Text('Recitation by al-Muqri Abdul Qadir al-Uthman'),
          const SizedBox(
            height: 24,
          )
        ]) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  void onCardClicked(int index, String harakat) {
    AudioPlayer audioPlugin = AudioPlayer();
    String idx = (index + 1) < 10 ? '0${index + 1}' : '${index + 1}';
    audioPlugin.play(AssetSource('audio/fatha/$idx-fatha.mp3'));
    setState(() {
      selectedIndex = index;
    });
  }

  Widget hijaiyahCardWidget(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: getArabCharWithHarakat('fatha').length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    onCardClicked(index, 'fatha');
                  },
                  child: Card(
                    color: Colors.white70,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: 200,
                      width: 200,
                      color: selectedIndex == index
                          ? Colors.amber
                          : Colors.white38,
                      child: Center(
                        child: Text(
                          getArabCharWithHarakat('fatha')[index],
                          style: const TextStyle(
                            fontSize: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
