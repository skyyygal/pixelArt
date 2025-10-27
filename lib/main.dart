import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RiveFile.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FireRive(),
    );
  }
}

class FireRive extends StatefulWidget {
  const FireRive({super.key});

  @override
  State<FireRive> createState() => _FireRiveState();
}

class _FireRiveState extends State<FireRive> {
  StateMachineController? _stateMachineController;
  Artboard? mainArtBoard;
  SMIBool? check;

  @override
  void initState() {
    super.initState();
    _loadRiveFile();
  }

  Future<void> _loadRiveFile() async {
    final data = await rootBundle.load('assets/images/fire.riv');
    final file = RiveFile.import(data);
    final artboard = file.mainArtboard;
    _stateMachineController = StateMachineController.fromArtboard(
      artboard,
      'State Machine 1',
    );

    // if (artboard.animations.isNotEmpty) {
    //   final firstAnim = artboard.animations.first.name;
    //   artboard.addController(SimpleAnimation(firstAnim));
    //   debugPrint('▶️ Playing animation: $firstAnim');
    // }
    if (_stateMachineController != null) {
      artboard.addController(_stateMachineController!);
    }
    mainArtBoard = artboard;

    check = _stateMachineController!.findSMI('ON');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rive Fire Animation')),
      body: mainArtBoard != null
          ? InkWell(
              onTap: () {
                check!.value = !check!.value;
                // if (check!.value) {
                //   check!.value = false;
                // } else {
                //   check!.value = true;
                // }
              },
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Rive(artboard: mainArtBoard!, fit: BoxFit.cover),
              ),
            )
          : Container(),
    );
  }
}
/* 
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RiveFile.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FireRive(),
    );
  }
}

class FireRive extends StatefulWidget {
  const FireRive({super.key});

  @override
  State<FireRive> createState() => _FireRiveState();
}

class _FireRiveState extends State<FireRive> {
  StateMachineController? _stateMachineController;
  Artboard? mainArtBoard;
  SMIBool? check;
  @override
  void initState() {
    super.initState();

    rootBundle.load("assets/images/fire.riv").then((riveByteData) {
      var riveFile = RiveFile.import(riveByteData);

      var artboard = riveFile.mainArtboard;
      _stateMachineController = StateMachineController.fromArtboard(
        artboard,
        'State Machine 1',
      );
      if (_stateMachineController != null) {
        artboard.addController(_stateMachineController!);

        check = _stateMachineController!.findSMI('ON');
        setState(() {
          mainArtBoard = artboard;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rive Fire Animation')),
      body: mainArtBoard != null ? Rive(artboard: mainArtBoard!) : Container(),
    );
  }
}
 */