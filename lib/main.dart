import 'package:flutter/material.dart';

void main() => runApp(MyCST2335LabApp());

class MyCST2335LabApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Text(
                    "BROWSE CATEGORIES",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Not sure about exactly which recipe you're looking for? Do a search, or dive into our most popular categories.",
                    style: TextStyle(fontSize: 20), textAlign: TextAlign.center,
                  ),
                ),

                // Row 3 - BY MEAT label
                Center(
                  child: Text("BY MEAT", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ),

                // Row 4 - Meat images (centered text)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('images/beef.jpg'),
                          radius: 80,
                        ),
                        Text("BEEF", style: whiteText),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('images/chicken.jpg'),
                          radius: 80,
                        ),
                        Text("CHICKEN", style: whiteText),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('images/pork.jpg'),
                          radius: 80,
                        ),
                        Text("PORK", style: whiteText),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('images/seafood.jpg'),
                          radius: 80,
                        ),
                        Text("SEAFOOD", style: whiteText),
                      ],
                    ),
                  ],
                ),

                // Row 5 - BY COURSE label
                Center(
                  child: Text("BY COURSE", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ),

                // Row 6 - Course images (bottom text)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('images/main-dishes.jpg'),
                          radius: 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text("Main Dishes", style: blackText),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('images/salad.jpg'),
                          radius: 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text("Salad Recipes", style: blackText),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('images/side-dishes.jpg'),
                          radius: 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text("Side Dishes", style: blackText),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('images/crockpot.jpg'),
                          radius: 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text("Crockpot", style: blackText),
                        ),
                      ],
                    ),
                  ],
                ),

                // Row 7 - BY DESSERT label
                Center(
                  child: Text("BY DESSERT", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ),

                // Row 8 - Dessert images (bottom text)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('images/Ice-cream.jpg'),
                          radius: 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text("Ice Cream", style: blackText),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('images/brownies.jpeg'),
                          radius: 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text("Brownies", style: blackText),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('images/pie.jpg'),
                          radius: 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text("Pies", style: blackText),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('images/cookies.jpg'),
                          radius: 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text("Cookies", style: blackText),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final whiteText = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 30,
    shadows: [Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 2)],
  );

  final blackText = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );
}
