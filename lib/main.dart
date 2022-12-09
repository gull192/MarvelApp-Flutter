import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_marvel_application/model/HeroCard.dart';

void main() => runApp(const App());

final themeMode = ValueNotifier(2);

class App extends StatelessWidget {
  const App({super.key});
  
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (context, value, g) {
        return MaterialApp(
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.values.toList()[value as int],
          debugShowCheckedModeBanner: false,
          home: const Mainscreen(),          
        );
      },
      valueListenable: themeMode,
    );
  }

}

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<Mainscreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  List<HeroCard> heroes = [
    HeroCard('http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg', '3-D Man', Colors.green),
    HeroCard('http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16.jpg', 'A-Bomb (HAS)', Colors.blue),
    HeroCard('http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec.jpg', 'A.I.M.', Colors.yellow),
    HeroCard('http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg', 'Aaron Stack', Colors.white10)
  ];

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF3B3836),
      body: Stack(children: [
        CustomPaint(
          size: Size(width, height),
          painter: DrawTriangleShape(heroes[_current].backgroungColor)
        ),
        Column(children: <Widget>[
        Padding(padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
         child: Image.asset("assets/image/marvel.png", fit: BoxFit.cover),
        ),
        const Text(
            'Choose your hero',
            style:TextStyle(
              color: Colors.white,
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        Expanded(
          child: CarouselSlider(
            carouselController: _controller,
            items: heroes
              .map((item) => Container(
              child: Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item.photo, fit: BoxFit.cover, width: 1000.0, height: height - 300),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            item.heroName,
                            style:const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList(),
            options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                height: height - 300,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
                enableInfiniteScroll: false,
              ),
          ),
        ),
      ]
      )]
      ) ,
    );
  }
}

class DrawTriangleShape extends CustomPainter {

  late Paint _painter;

  DrawTriangleShape(Color color) {
    _painter = Paint()
    ..color = color
    ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {

    var path = Path();
    
    path.moveTo(size.width, size.height/2); //a
    path.lineTo(0, size.height);  //b
    path.lineTo(size.width, size.height); //c
    path.close();

    canvas.drawPath(path, _painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}