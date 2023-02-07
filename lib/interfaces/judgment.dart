import 'package:e_rejestr/models/patient.dart';
import 'package:flutter/material.dart';

abstract class Judgment {
  Judgment({required this.patient, required this.article, required this.widget, this.termOfValidyty, this.indefinitely = false});

  final Patient patient;
  final String article;
  DateTime? termOfValidyty;
  final bool indefinitely;
  final Widget widget;
}
