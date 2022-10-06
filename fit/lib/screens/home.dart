import 'package:fit/ui/pages/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fit/screens/login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Excersion App'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: dashboard(),
    );
  }
}

class Cardd extends StatefulWidget {
  const Cardd({Key? key}) : super(key: key);

  @override
  State<Cardd> createState() => _CarddState();
}

class _CarddState extends State<Cardd> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Material(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const dashboard()),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      "assets/images/beg.jpg",
                      height: 150,
                      width: 250,
                      //fist: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
            //),
          ),
        ),
      ],
    );
  }
}

class Title extends StatelessWidget {
  const Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Excersion App",
        style: TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontStyle: FontStyle.normal,
            letterSpacing: 0.5,
            wordSpacing: 5,
            shadows: [
              Shadow(
                  color: Colors.blueAccent,
                  offset: Offset(2, 1),
                  blurRadius: 10)
            ]),
      ),
    );
  }
}

class Imagee extends StatelessWidget {
  const Imagee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/fitt.jpg",
      height: 375,
      width: 650,
      fit: BoxFit.cover,
    );
  }
}

class FilledCardExample extends StatelessWidget {
  const FilledCardExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.orangeAccent[300],
        child: const SizedBox(
          width: 500,
          height: 50,
          child: Center(
            child: Text(
              "                                   About Us\n Helping people to be physically and mentally fit",
              style: TextStyle(
                fontSize: 15,
                color: Colors.purple,
                fontStyle: FontStyle.italic,
                letterSpacing: 0.5,
                wordSpacing: 5,
                shadows: [
                  Shadow(
                      color: Colors.blueAccent,
                      offset: Offset(2, 1),
                      blurRadius: 10)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Begcard extends StatelessWidget {
  const Begcard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Material(
          child: InkWell(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                "assets/images/beg.jpg",
                height: 150,
                width: 150,
                //fist: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  double x = 0.0;
  double y = 0.0;
  double z = 0.0;
  double miles = 0.0;
  double duration = 0.0;
  double calories = 0.0;
  double addValue = 0.025;
  double previousDistance = 0.0;
  double distance = 0.0;
  int steps = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<AccelerometerEvent>(
        stream: SensorsPlatform.instance.accelerometerEvents,
        builder: (context, snapShort) {
          if (snapShort.hasData) {
            x = snapShort.data!.x;
            y = snapShort.data!.y;
            z = snapShort.data!.z;
            distance = getValue(x, y, z);
            if (distance > 3) {
              steps++;
            }
            calories = calculateCalories(steps);
            duration = calculateDuration(steps);
            miles = calculateMiles(steps);
          }
          return Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff0C1E4E),
                      Color(0xff224A88),
                    ],
                  ),
                ),
              ),
              // ignore: sized_box_for_whitespace
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: kToolbarHeight),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          children: [
                            topText("Steps", true, () {
                              print("This was tapped");
                            }),
                            topText("Plan", false, () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileScreen()),
                              );
                            }),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            ContainerButton(
                              const Icon(
                                Icons.arrow_drop_down,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      dashboardCard(steps, miles, calories, duration),
                      const dailyAverage(),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      // bottomNavigationBar: const buttonNav(),
    );
  }

  double getValue(double x, double y, double z) {
    double magnitude = sqrt(x * x + y * y + z * z);
    getPreviousValue();
    double modDistance = magnitude - previousDistance;
    setPreviousValue(magnitude);
    return modDistance;
  }

  void setPreviousValue(double distance) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setDouble("preValue", distance);
  }

  void getPreviousValue() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      previousDistance = _pref.getDouble("preValue") ?? 0.0;
    });
  }

  //void calculate data
  double calculateMiles(int steps) {
    double milesValue = (2.2 * steps) / 5280;
    return milesValue;
  }

  double calculateDuration(int steps) {
    double durationValue = (steps * 1 / 1000);
    return durationValue;
  }

  double calculateCalories(int steps) {
    double caloriesValues = (steps * 0.0566);
    return caloriesValues;
  }
}

class topText extends StatelessWidget {
  String text;
  bool isActive;
  Function onTap;
  topText(this.text, this.isActive, this.onTap, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          child: Column(
            children: [
              Text(
                text,
                style: GoogleFonts.aBeeZee(
                    color: isActive ? Colors.green : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    letterSpacing: 2),
              ),
              const SizedBox(
                height: 5,
              ),
              Visibility(
                visible: isActive,
                child: Container(
                  height: 3,
                  width: 70,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContainerButton extends StatelessWidget {
  Icon someIcon;
  ContainerButton(this.someIcon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width * 0.13,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(250),
        color: Colors.lightGreen,
      ),
      child: Center(
        child: someIcon,
      ),
    );
  }
}

class dashboardCard extends StatelessWidget {
  int steps;
  double miles, calories, duration;
  dashboardCard(this.steps, this.miles, this.calories, this.duration,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: const Color(0xff1D3768),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            //height: 100,
                            width: 150,
                            child: Row(
                              children: [
                                text(50, steps.toString()),
                                SizedBox(
                                  width: 10,
                                ),
                                const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ],
                            ),
                          ),
                          //this is for pause
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 30,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(70),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  "Pause",
                                  style: GoogleFonts.aBeeZee(
                                    color: Colors.green,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 130,
                  ),
                  Expanded(
                    flex: 1,
                    child: ContainerButton(
                      const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            LinearPercentIndicator(
              progressColor: Colors.green,
              animation: true,
              percent: 0.8,
              lineHeight: 20,
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                ImageContainer("assets/images/locations.png",
                    miles.toStringAsFixed(3), "Miles"),
                ImageContainer("assets/images/calories.png",
                    calories.toStringAsFixed(3), "Calories"),
                ImageContainer("assets/images/stopwatch.png",
                    duration.toStringAsFixed(3), "Duration"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class text extends StatelessWidget {
  double fontSize;
  String titleText;
  text(this.fontSize, this.titleText, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: GoogleFonts.aBeeZee(
        color: Colors.white,
        fontSize: fontSize,
        letterSpacing: 2,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  String imagePath, number, textTitle;
  ImageContainer(this.imagePath, this.number, this.textTitle, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width * 0.29,
      child: Column(
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: text(16, number),
          ),
          text(12, textTitle),
        ],
      ),
    );
  }
}

class dailyAverage extends StatelessWidget {
  const dailyAverage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.20,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: const Color(0xff1D3768),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.center,
                  child: text(20, "Daily average :")),
            ),
            SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  circularDay("Sun", 0.7, Colors.purple),
                  circularDay("Mon", 0.1, Colors.red),
                  circularDay("Tue", 0.2, Colors.cyan),
                  circularDay("Wed", 0.3, Colors.teal),
                  circularDay("Thu", 0.4, Colors.amber),
                  circularDay("Fri", 0.5, Colors.green),
                  circularDay("Sat", 0.6, Colors.indigo),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class circularDay extends StatelessWidget {
  String day;
  double percentage;
  Color colors;
  circularDay(this.day, this.percentage, this.colors, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        //width: MediaQuery.of(context).size.width * 0.5,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            CircularPercentIndicator(
              radius: 20,
              lineWidth: 2.0,
              percent: percentage,
              animation: true,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: colors,
            ),
            SizedBox(
              height: 5,
            ),
            text(10, day),
          ],
        ),
      ),
    );
  }
}

class buttonNav extends StatelessWidget {
  const buttonNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Color(0xff224A88),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          iconColumn(
              const Icon(
                Icons.home,
                color: Colors.green,
                size: 30,
              ),
              "Home"),
          iconColumn(
              const Icon(
                Icons.auto_graph_outlined,
                color: Colors.green,
                size: 30,
              ),
              "Report"),
          iconColumn(
              const Icon(
                Icons.health_and_safety,
                color: Colors.green,
                size: 30,
              ),
              "Health"),
          iconColumn(
              const Icon(
                Icons.settings,
                color: Colors.green,
                size: 30,
              ),
              "More")
        ],
      ),
    );
  }
}

class iconColumn extends StatelessWidget {
  Icon icons;
  String title;
  iconColumn(this.icons, this.title, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 30),
      child: Column(
        children: [
          Container(
            color: Colors.transparent,
            child: icons,
          ),
          text(15, title)
        ],
      ),
    );
  }
}
