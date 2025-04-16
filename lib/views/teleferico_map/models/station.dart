import 'package:flutter/material.dart';
import 'package:movilizate/views/teleferico_map/models/line.dart';

class Station {
  final int id;
  final int idLine;
  final String code;
  final String name;
  final String adress;
  final String color;
  final double latitude;
  final double longitude;

  Station({
    required this.id,
    required this.idLine,
    required this.code,
    required this.name,
    required this.adress,
    required this.color,
    required this.latitude,
    required this.longitude,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Station &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          idLine == other.idLine &&
          code == other.code &&
          name == other.name &&
          color == other.color &&
          latitude == other.latitude &&
          longitude == other.longitude;

  @override
  int get hashCode =>
      id.hashCode ^
      idLine.hashCode ^
      code.hashCode ^
      name.hashCode ^
      color.hashCode ^
      latitude.hashCode ^
      longitude.hashCode;

  static Station? getStationByCode(String lineCode, String code) {
    List<Station> allStations = Line.getStationsByLine(lineCode);

    for (var element in allStations) {
      if (element.code == code) {
        return element;
      }
    }

    return null;
  }

  /* 
  * Convierte un color Hexadeimal a un color Flutter
  */
  static Color colorFromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static bool stationExists(String name, List<Station> stations) {
    return stations.any((station) => station.name == name);
  }
}

final List<Station> stationsRoja = [
  Station(
    id: 1,
    idLine: 1,
    code: "ROJ001",
    color: "#c43b3b",
    name: "Estación Central",
    adress: "Avenida Manco Cápac, Ex-estación de ferrocarriles.",
    latitude: -16.491357802611716,
    longitude: -68.14456951972984,
  ),
  Station(
    id: 2,
    idLine: 1,
    code: "ROJ002",
    color: "#c43b3b",
    name: "Estación Cementerio",
    adress: "Avenida Entre Ríos, detrás del Cementerio",
    latitude: -16.49819766498115,
    longitude: -68.15280689431688,
  ),
  Station(
    id: 3,
    idLine: 1,
    code: "ROJ003",
    color: "#c43b3b",
    name: "Estación 16 de Julio",
    adress: "El Alto, zona 16 de julio, Avenida Panorámica Norte.",
    latitude: -16.49737844240338,
    longitude: -68.16465387662723,
  ),
];
final List<Station> stationsAmarilla = [
  Station(
    id: 4,
    idLine: 2,
    code: "AMA001",
    color: "#f6de0b",
    name: "Estación Mirador",
    adress: "El Alto, Av. Panorámica. En la región de las antenas satelitales",
    latitude: -16.518211228832822,
    longitude: -68.15020153021737,
  ),
  Station(
    id: 5,
    idLine: 2,
    code: "AMA002",
    color: "#f6de0b",
    name: "Estación Buenos Aires",
    adress: "Av. Buenos Aires y Calle Moxos",
    latitude: -16.515461723118452,
    longitude: -68.1441031164073,
  ),
  Station(
    id: 6,
    idLine: 2,
    code: "AMA003",
    color: "#f6de0b",
    name: "Estación Sopocachi",
    adress: "Calle Miguel de Cervantes y Saavedra esquina Calle Méndez Arcos.",
    latitude: -16.514698551909536,
    longitude: -68.1302514410831,
  ),
  Station(
    id: 7,
    idLine: 2,
    code: "AMA004",
    color: "#f6de0b",
    name: "Estación Libertador",
    adress: "Av. Libertador, a la altura de la Curva de Holguín",
    latitude: -16.519114763920673,
    longitude: -68.11615854214936,
  ),
];
final List<Station> stationsVerde = [
  Station(
    id: 11,
    idLine: 3,
    code: "VER001",
    color: "#4ba44d",
    name: "Estación Libertador",
    adress: "Av. Libertador, a la altura de la Curva de Holguín",
    latitude: -16.519147314725277,
    longitude: -68.11601236223738,
  ),
  Station(
    id: 9,
    idLine: 3,
    code: "VER002",
    color: "#4ba44d",
    name: "Estación Alto Obrajes",
    adress: "Final Av. Costanera y Av. Del Maestro",
    latitude: -16.521560387863975,
    longitude: -68.11045207702811,
  ),
  Station(
    id: 8,
    idLine: 3,
    code: "VER003",
    color: "#4ba44d",
    name: "Estación Obrajes",
    adress: "Altura de la calle 17 (cerca al puente Esperanza)",
    latitude: -16.526828889323653,
    longitude: -68.10069836259466,
  ),
  Station(
    id: 10,
    idLine: 3,
    code: "VER004",
    color: "#4ba44d",
    name: "Estación Irpavi",
    adress:
        "Colegio Militar del Ejército, a la altura de calle 12 de Calacoto.",
    latitude: -16.538079062163078,
    longitude: -68.08733895987814,
  ),
];
final List<Station> stationsAzul = [
  Station(
    id: 12,
    idLine: 4,
    code: "AZU001",
    color: "#16388a",
    name: "Estación 16 de Julio",
    adress: "El Alto, zona 16 de julio, Avenida Panorámica Norte.",
    latitude: -16.498412831679843,
    longitude: -68.16457080785355,
  ),
  Station(
    id: 13,
    idLine: 4,
    code: "AZU002",
    color: "#16388a",
    name: "Estación Plaza La Libertad",
    adress: "El Alto, Av. Alfonso Ugarte y la Av. 16 de Julio",
    latitude: -16.494824161369802,
    longitude: -68.17358163225798,
  ),
  Station(
    id: 14,
    idLine: 4,
    code: "AZU003",
    color: "#16388a",
    name: "Estación Plaza La Paz",
    adress: "El Alto, Av. 16 de Julio esquina Av. La Paz.",
    latitude: -16.49227405622104,
    longitude: -68.1830882017019,
  ),
  Station(
    id: 15,
    idLine: 4,
    code: "AZU004",
    color: "#16388a",
    name: "Estación UPEA",
    adress: "El Alto, Av. 16 de Julio entre las Av. Sucre A y Sucre B.",
    latitude: -16.489518191052834,
    longitude: -68.19320136533388,
  ),
  Station(
    id: 16,
    idLine: 4,
    code: "AZU005",
    color: "#16388a",
    name: "Estación Rio Seco",
    adress:
        "El Alto, Av. Juan Pablo II y el desvió hacia la localidad de Copacabana.",
    latitude: -16.48993727193367,
    longitude: -68.20973078112227,
  ),
];
final List<Station> stationsNaranja = [
  Station(
    id: 20,
    idLine: 5,
    code: "NAR001",
    color: "#fa7f0d",
    name: "Estación Plaza Villaroel",
    adress: "Plaza Villarroel",
    latitude: -16.484740270166398,
    longitude: -68.12204530358854,
  ),
  Station(
    id: 19,
    idLine: 5,
    code: "NAR002",
    color: "#fa7f0d",
    name: "Estación Periférica",
    adress: "Av. Periferica",
    latitude: -16.486520298147177,
    longitude: -68.13126799965983,
  ),
  Station(
    id: 18,
    idLine: 5,
    code: "NAR003",
    color: "#fa7f0d",
    name: "Estación Armentia",
    adress: "Avenida Armentia",
    latitude: -16.490375721003705,
    longitude: -68.13678302448974,
  ),
  Station(
    id: 17,
    idLine: 5,
    code: "NAR004",
    color: "#fa7f0d",
    name: "Estación Central",
    adress: "Avenida Manco Cápac, Ex-estación de ferrocarriles.",
    latitude: -16.492087860026352,
    longitude: -68.1447714101455,
  ),
];
final List<Station> stationsBlanca = [
  Station(
    id: 27,
    idLine: 8,
    code: "BLA001",
    color: "#000000",
    name: "Estación Av Poeta",
    adress: "Av. del Poeta",
    latitude: -16.51080476142688,
    longitude: -68.12116531260541,
  ),
  Station(
    id: 28,
    idLine: 8,
    code: "BLA002",
    color: "#000000",
    name: "Estación Plaza Triangular",
    adress: "Miraflores plaza triangular",
    latitude: -16.50410189766292,
    longitude: -68.12084656225821,
  ),
  Station(
    id: 29,
    idLine: 8,
    code: "BLA003",
    color: "#000000",
    name: "Estación Monumento Busch",
    adress: "Av. Busch",
    latitude: -16.493684021085265,
    longitude: -68.12136819325501,
  ),
  Station(
    id: 30,
    idLine: 8,
    code: "BLA004",
    color: "#000000",
    name: "Estación Plaza Villaroel",
    adress: "Plaza Villarroel",
    latitude: -16.484723926321173,
    longitude: -68.12181208611605,
  ),
];
final List<Station> stationsCeleste = [
  Station(
    id: 31,
    idLine: 9,
    code: "CEL001",
    color: "#09acf2",
    name: "Estación Libertador",
    adress: "Curva de Holguin",
    latitude: -16.518511779420656,
    longitude: -68.11622864272587,
  ),
  Station(
    id: 32,
    idLine: 9,
    code: "CEL002",
    color: "#09acf2",
    name: "Estación Av Poeta",
    adress: "Av. del Poeta",
    latitude: -16.511240325150276,
    longitude: -68.12025493098088,
  ),
  Station(
    id: 33,
    idLine: 9,
    code: "CEL003",
    color: "#09acf2",
    name: "Estación Teatro al Aire Libre",
    adress: "Av. del Poeta, Teatro al aire libre",
    latitude: -16.50415573222709,
    longitude: -68.1260515622319,
  ),
  Station(
    id: 34,
    idLine: 9,
    code: "CEL004",
    color: "#09acf2",
    name: "Estación Prado",
    adress: "Prado",
    latitude: -16.50042723226171,
    longitude: -68.13276070296003,
  ),
];
final List<Station> stationsMorada = [
  Station(
    id: 39,
    idLine: 10,
    code: "MOR001",
    color: "#9c54f0",
    name: "Estación 6 de Marzo",
    adress: "El Alto, Av. 6 de marzo S/N",
    latitude: -16.522547866401833,
    longitude: -68.16939430723444,
  ),
  Station(
    id: 38,
    idLine: 10,
    code: "MOR002",
    color: "#9c54f0",
    name: "Estación Faro Murillo",
    adress: "El Alto, Faro Murillo",
    latitude: -16.512299659751285,
    longitude: -68.15369195409525,
  ),
  Station(
    id: 37,
    idLine: 10,
    code: "MOR003",
    color: "#9c54f0",
    name: "Estación San José",
    adress: "Calle Almirante Grau",
    latitude: -16.50003434234198,
    longitude: -68.1351505327194,
  ),
];
final List<Station> stationsCafe = [
  Station(
    id: 41,
    idLine: 11,
    code: "CAF001",
    color: "#5c4e3e",
    name: "Estación Monumento Busch",
    adress: "Av. Busch",
    latitude: -16.493814429756814,
    longitude: -68.1208349273292,
  ),
  Station(
    id: 40,
    idLine: 11,
    code: "CAF002",
    color: "#5c4e3e",
    name: "Estación de las Villas",
    adress: "Villa Copacabana",
    latitude: -16.497732687482994,
    longitude: -68.1150517498218,
  ),
];
final List<Station> stationsPlateada = [
  Station(
    id: 44,
    idLine: 12,
    code: "PLA001",
    color: "#9c9aa0",
    name: "Estación 16 de Julio",
    adress: "El Alto, zona 16 de julio, Avenida Panorámica Norte.",
    latitude: -16.498814554413133,
    longitude: -68.16444474927454,
  ),
  Station(
    id: 45,
    idLine: 12,
    code: "PLA002",
    color: "#9c9aa0",
    name: "Estación Faro Murillo",
    adress: "El Alto, Faro Murillo",
    latitude: -16.51230348161609,
    longitude: -68.1537082493533,
  ),
  Station(
    id: 47,
    idLine: 12,
    code: "PLA003",
    color: "#9c9aa0",
    name: "Estación Mirador",
    adress:
        "El Alto, Av. Panorámica. En la región de las antenas satelitales de televisión",
    latitude: -16.519283914067096,
    longitude: -68.14985832590709,
  ),
];
