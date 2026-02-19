import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    ),
  );
}

enum CardType { red, blue,yellow, green }


class ColorTapsScreen extends StatelessWidget {


  const ColorTapsScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Color Taps')),
      body: Column(
        children: [
          ColorTap(
            type: CardType.red
            ),
          ColorTap(
            type: CardType.blue,
          ),
          ColorTap(
            type: CardType.yellow,
          ),
          ColorTap(
            type: CardType.green,
          ),
        ],
      ),
    );
  }
}

class ColorTap extends StatelessWidget {
  final CardType type;


  const ColorTap({
    super.key,
    required this.type,
  });

Color get backgroundColor {
  switch (type) {
    case CardType.red:
      return Colors.red;
    case CardType.blue:
      return Colors.blue;
    case CardType.yellow:
      return Colors.yellow;
    case CardType.green:
      return Colors.green;
  }
}


  @override
  Widget build(BuildContext context) {
    
  final count = switch (type) {
  CardType.red => colorService.redCount,
  CardType.blue => colorService.blueCount,
  CardType.yellow => colorService.yellowCount,
  CardType.green => colorService.greenCount,
};

    return GestureDetector(
      onTap: () {
        colorService.increment(type);
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 100,
        child: Center(
          child: Text(
            'Taps: $count',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class StatisticsScreen extends StatelessWidget {


  const StatisticsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Red Taps: ${colorService.redCount}', style: TextStyle(fontSize: 24)),
            Text('Blue Taps: ${colorService.blueCount}', style: TextStyle(fontSize: 24)),
            Text('Yellow Taps: ${colorService.yellowCount}', style: TextStyle(fontSize: 24)),
            Text('Green Taps: ${colorService.greenCount}', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}


class ColorService extends ChangeNotifier {
  int _redCount = 0;
  int _blueCount = 0;
  int _yellowCount = 0;
  int _greenCount = 0;
  int _currentIndex = 0;

  int get redCount => _redCount;
  int get blueCount => _blueCount;
  int get yellowCount => _yellowCount;
  int get greenCount => _greenCount;
  int get currentIndex => _currentIndex;

void increment(CardType type) {
  switch (type) {
    case CardType.red:
      _redCount++;
      break;
    case CardType.blue:
      _blueCount++;
      break;
    case CardType.yellow:
      _yellowCount++;
      break;
    case CardType.green:
      _greenCount++;
      break;
  }
  notifyListeners();
}


  void onTabChnage (int index){
    _currentIndex = index;
    notifyListeners();
  }
}

ColorService colorService = ColorService();

class Home extends StatelessWidget {
  const Home({super.key});


  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: colorService, 
      builder: (contex, child) {
        return Scaffold(
          body: colorService.currentIndex == 0
          ? ColorTapsScreen() : StatisticsScreen(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: colorService.currentIndex,
            onTap: (index) {
              colorService.onTabChnage(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.touch_app),
              label: 'Taps'
              ),
              BottomNavigationBarItem(icon: Icon(Icons.bar_chart),
              label: 'Statistic'
              ),
              
            ],
            ),
        );
      }
      );
  }
}

