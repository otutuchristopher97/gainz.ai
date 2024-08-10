import 'package:flutter/material.dart';
import 'package:gainz_ai_app/src/home/domain/entities/dailyworkout.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HomeContainer extends StatefulWidget {
  HomeContainer({super.key, this.title, this.image, this.subtitle, this.color});

  final String? title;
  final String? image;
  final String? subtitle;
  Color? color;

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: widget.color,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              widget.image!,
              height: 70,
              width: 70,
            ),
            Text(widget.title!),
            if (widget.title == 'Goal')
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LinearPercentIndicator(
                    padding: EdgeInsets.zero,
                    width: 100.0,
                    lineHeight: 8.0,
                    percent: 0.5,
                    progressColor: const Color(0xff319964),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(widget.subtitle!)
                ],
              ),
            if (widget.title != 'Goal') Text(widget.subtitle!)
          ],
        ),
      ),
    );
  }
}
