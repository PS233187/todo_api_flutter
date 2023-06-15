// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Exercises extends StatelessWidget {
  final icon;
  final String exerciseName;
  final int numberOfExercises;
  const Exercises({
    Key? key,
    required this.icon,
    required this.exerciseName,
    required this.numberOfExercises,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 12.0),
        child: Container(
          padding: EdgeInsets.all(9),
          height: 75,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.blue[100],
                  child: Icon(
                    icon,
                    color: Colors.pink,
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exerciseName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    numberOfExercises.toString() + ' Exercises',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
