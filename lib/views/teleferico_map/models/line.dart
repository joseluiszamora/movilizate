import 'package:flutter/material.dart';

import 'station.dart';

class Line {
  final int id;
  final String code;
  final String name;
  final String color;
  final List<Station> stations;

  Line(
      {required this.id,
      required this.code,
      required this.name,
      required this.color,
      required this.stations});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Station &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          code == other.code &&
          name == other.name &&
          color == other.color;

  @override
  int get hashCode =>
      id.hashCode ^ code.hashCode ^ name.hashCode ^ color.hashCode;

  static List<Line> allLines = [
    Line(
        id: 1,
        code: "LRO",
        name: "Línea Roja",
        color: "#c43b3b",
        stations: stationsRoja),
    Line(
        id: 2,
        code: "LAM",
        name: "Línea Amarilla",
        color: "#f6de0b",
        stations: stationsAmarilla),
    Line(
        id: 3,
        code: "LVE",
        name: "Línea Verde",
        color: "#4ba44d",
        stations: stationsVerde),
    Line(
        id: 4,
        code: "LAZ",
        name: "Línea Azul",
        color: "#16388a",
        stations: stationsAzul),
    Line(
        id: 5,
        code: "LNA",
        name: "Línea Naranja",
        color: "#fa7f0d",
        stations: stationsNaranja),
    Line(
        id: 8,
        code: "LBL",
        name: "Línea Blanca",
        color: "#ffff",
        stations: stationsBlanca),
    Line(
        id: 9,
        code: "LCE",
        name: "Línea Celeste",
        color: "#09acf2",
        stations: stationsCeleste),
    Line(
        id: 10,
        code: "LMO",
        name: "Línea Morada",
        color: "#9c54f0",
        stations: stationsMorada),
    Line(
        id: 11,
        code: "LCA",
        name: "Línea Cafe",
        color: "#7a451d",
        stations: stationsCafe),
    Line(
        id: 12,
        code: "LPL",
        name: "Línea Plateada",
        color: "#d4d4d4",
        stations: stationsPlateada),
  ];

  static Map<String, List<Station>> stationsByLine = {
    "LRO": stationsRoja,
    "LAM": stationsAmarilla,
    "LVE": stationsVerde,
    "LAZ": stationsAzul,
    "LNA": stationsNaranja,
    "LBL": stationsBlanca,
    "LCE": stationsCeleste,
    "LMO": stationsMorada,
    "LCA": stationsCafe,
    "LPL": stationsPlateada,
  };

  static Line getLineByCode(String code) {
    Line val = allLines.first;

    for (var element in allLines) {
      if (element.code == code) {
        val = element;
      }
    }
    return val;
  }

  static Line getLineByName(String name) {
    Line val = allLines.first;

    for (var element in allLines) {
      if (element.name == name) {
        val = element;
      }
    }
    return val;
  }

  static List<Station> getStationsByLine(String line) {
    List<Station> stats = [];
    stationsByLine.forEach((key, value) {
      if (key == line) {
        stats = value;
      }
    });
    return stats;
  }

/* 
  * Convierte un color Hexadeimal a un color Flutter
  */
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
