import 'package:animations/animations.dart';
import 'package:fit/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fit/model/meal.dart';
import 'package:fit/ui/pages/meal_detail_screen.dart';
import 'package:fit/ui/pages/workout_screen.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final today = DateTime.now();

    return Scaffold(
      backgroundColor: const Color(0xff1D3768),
      //bottomNavigationBar: buttonNav(),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            height: height * 0.38,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: const Radius.circular(40),
              ),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                    top: 40, left: 32, right: 16, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        "${DateFormat("EEEE").format(today)}, ${DateFormat("d MMMM").format(today)}",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                      subtitle: Text(
                        "Hello, David",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      trailing: ClipOval(
                          child: Image.asset("assets/images/user.jpg")),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        _RadialProgress(
                          width: width * 0.2,
                          height: width * 0.2,
                          progress: 0.7,
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _IngredientProgress(
                              ingredient: "Protein",
                              progress: 0.3,
                              progressColor: Colors.green,
                              leftAmount: 72,
                              width: width * 0.1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            _IngredientProgress(
                              ingredient: "Carbs",
                              progress: 0.2,
                              progressColor: Colors.red,
                              leftAmount: 252,
                              width: width * 0.1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            _IngredientProgress(
                              ingredient: "Fat",
                              progress: 0.1,
                              progressColor: Colors.yellow,
                              leftAmount: 61,
                              width: width * 0.1,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.38,
            left: 0,
            right: 0,
            child: Container(
              height: height * 0.65,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8,
                      left: 32,
                      right: 16,
                    ),
                    child: Text(
                      "MEALS FOR TODAY",
                      style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 32,
                          ),
                          for (int i = 0; i < meals.length; i++)
                            _MealCard(
                              meal: meals[i],
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: OpenContainer(
                      closedElevation: 0,
                      transitionType: ContainerTransitionType.fade,
                      transitionDuration: const Duration(milliseconds: 1000),
                      closedColor: const Color(0xFFE9E9E9),
                      openBuilder: (context, _) {
                        return WorkoutScreen();
                      },
                      closedBuilder: (context, VoidCallback openContainer) {
                        return GestureDetector(
                          onTap: openContainer,
                          child: Container(
                            margin: const EdgeInsets.only(
                                bottom: 10, left: 32, right: 32),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color(0xff1D3768),
                                  Color.fromARGB(255, 28, 58, 113)
                                ],
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0, left: 16),
                                  child: Text(
                                    "YOUR NEXT WORKOUT",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4.0, left: 16),
                                  child: Text(
                                    "Upper Body",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                          color: const Color(0xFF5B4D9D),
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        child: Image.asset(
                                          "assets/images/chest.png",
                                          width: 50,
                                          height: 50,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                          color: const Color(0xFF5B4D9D),
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        child: Image.asset(
                                          "assets/images/back.png",
                                          width: 50,
                                          height: 50,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                          color: const Color(0xFF5B4D9D),
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        child: Image.asset(
                                          "assets/images/biceps.png",
                                          width: 50,
                                          height: 50,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IngredientProgress extends StatelessWidget {
  final String ingredient;
  final int leftAmount;
  final double progress, width;
  final Color progressColor;

  const _IngredientProgress(
      {super.key,
      required this.ingredient,
      required this.leftAmount,
      required this.progress,
      required this.width,
      required this.progressColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          ingredient.toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 10,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.black12,
                  ),
                ),
                Container(
                  height: 10,
                  width: width * progress,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: progressColor,
                  ),
                )
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Text("${leftAmount}g left"),
          ],
        ),
      ],
    );
  }
}

class _RadialProgress extends StatelessWidget {
  final double height, width, progress;

  const _RadialProgress(
      {super.key,
      required this.height,
      required this.width,
      required this.progress});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RadialPainter(
        progress: 0.7,
      ),
      child: Container(
        height: height,
        width: width,
        child: Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "1731",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF200087),
                  ),
                ),
                TextSpan(text: "\n"),
                TextSpan(
                  text: "kcal left",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF200087),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RadialPainter extends CustomPainter {
  final double progress;

  _RadialPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 10
      ..color = Color(0xFF200087)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double relativeProgress = 360 * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.width / 2),
      math.radians(-90),
      math.radians(-relativeProgress),
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _MealCard extends StatelessWidget {
  final Meal meal;

  const _MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 20,
        bottom: 10,
      ),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              child: OpenContainer(
                closedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                transitionDuration: const Duration(milliseconds: 1000),
                openBuilder: (context, _) {
                  return MealDetailScreen(
                    meal: meal,
                  );
                },
                closedBuilder: (context, openContainer) {
                  return GestureDetector(
                    onTap: openContainer,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Image.asset(
                        meal.imagePath,
                        width: 150,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      meal.mealTime,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Text(
                      meal.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "${meal.kiloCaloriesBurnt} kcal",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          size: 15,
                          color: Colors.black12,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "${meal.timeTaken} min",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
