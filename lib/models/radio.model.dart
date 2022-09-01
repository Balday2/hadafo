import 'package:flutter/material.dart';

class RadioModel {

  final int id;
  final String title;
  final String image;
  final String link;
  final String description;
  final Color color;
  final String album;

  RadioModel({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.link,
    required this.color,
    required this.album
});
}