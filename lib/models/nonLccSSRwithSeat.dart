import 'dart:convert';

NonLccSsRwithSeat nonLccSsRwithSeatFromJson(String str) =>
    NonLccSsRwithSeat.fromJson(json.decode(str));

String nonLccSsRwithSeatToJson(NonLccSsRwithSeat data) =>
    json.encode(data.toJson());

class NonLccSsRwithSeat {
  Response? response;

  NonLccSsRwithSeat({
    this.response,
  });

  factory NonLccSsRwithSeat.fromJson(Map<String, dynamic> json) =>
      NonLccSsRwithSeat(
        response: json["Response"] == null
            ? null
            : Response.fromJson(json["Response"]),
      );

  Map<String, dynamic> toJson() => {
    "Response": response?.toJson(),
  };
}

class Response {
  List<Meal>? meal;
  int? responseStatus;
  Error? error;
  String? traceId;
  List<List<Baggage>>? baggage;
  List<SeatDynamic>? seatDynamic;

  Response({
    this.meal,
    this.responseStatus,
    this.error,
    this.traceId,
    this.baggage,
    this.seatDynamic,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    meal: json["Meal"] == null
        ? []
        : List<Meal>.from(json["Meal"]!.map((x) => Meal.fromJson(x))),
    responseStatus: json["ResponseStatus"],
    error: json["Error"] == null ? null : Error.fromJson(json["Error"]),
    traceId: json["TraceId"],
    baggage: json["Baggage"] == null
        ? []
        : List<List<Baggage>>.from(json["Baggage"]!.map((x) =>
    List<Baggage>.from(x.map((x) => Baggage.fromJson(x))))),
    seatDynamic: json["SeatDynamic"] == null
        ? []
        : List<SeatDynamic>.from(json["SeatDynamic"]!.map((x) =>
        SeatDynamic.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Meal": meal == null
        ? []
        : List<dynamic>.from(meal!.map((x) => x.toJson())),
    "ResponseStatus": responseStatus,
    "Error": error?.toJson(),
    "TraceId": traceId,
    "Baggage": baggage == null
        ? []
        : List<dynamic>.from(baggage!
        .map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
    "SeatDynamic": seatDynamic == null
        ? []
        : List<dynamic>.from(seatDynamic!.map((x) => x.toJson())),
  };
}

class Baggage {
  String? airlineCode;
  String? flightNumber;
  int? wayType;
  String? code;
  int? description;
  int? weight;
  String? currency;
  int? price;
  String? origin;
  String? destination;
  String? text;

  Baggage({
    this.airlineCode,
    this.flightNumber,
    this.wayType,
    this.code,
    this.description,
    this.weight,
    this.currency,
    this.price,
    this.origin,
    this.destination,
    this.text,
  });

  factory Baggage.fromJson(Map<String, dynamic> json) => Baggage(
    airlineCode: json["AirlineCode"],
    flightNumber: json["FlightNumber"],
    wayType: json["WayType"],
    code: json["Code"],
    description: json["Description"],
    weight: json["Weight"],
    currency: json["Currency"],
    price: json["Price"],
    origin: json["Origin"],
    destination: json["Destination"],
    text: json["Text"],
  );

  Map<String, dynamic> toJson() => {
    "AirlineCode": airlineCode,
    "FlightNumber": flightNumber,
    "WayType": wayType,
    "Code": code,
    "Description": description,
    "Weight": weight,
    "Currency": currency,
    "Price": price,
    "Origin": origin,
    "Destination": destination,
    "Text": text,
  };
}

class Error {
  int? errorCode;
  String? errorMessage;

  Error({
    this.errorCode,
    this.errorMessage,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    errorCode: json["ErrorCode"],
    errorMessage: json["ErrorMessage"],
  );

  Map<String, dynamic> toJson() => {
    "ErrorCode": errorCode,
    "ErrorMessage": errorMessage,
  };
}

class Meal {
  String? code;
  String? description;

  Meal({
    this.code,
    this.description,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
    code: json["Code"],
    description: json["Description"],
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Description": description,
  };
}

class SeatDynamic {
  List<SegmentSeat>? segmentSeat;

  SeatDynamic({
    this.segmentSeat,
  });

  factory SeatDynamic.fromJson(Map<String, dynamic> json) => SeatDynamic(
    segmentSeat: json["SegmentSeat"] == null
        ? []
        : List<SegmentSeat>.from(
        json["SegmentSeat"]!.map((x) => SegmentSeat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "SegmentSeat": segmentSeat == null
        ? []
        : List<dynamic>.from(segmentSeat!.map((x) => x.toJson())),
  };
}

class SegmentSeat {
  List<RowSeat>? rowSeats;

  SegmentSeat({
    this.rowSeats,
  });

  factory SegmentSeat.fromJson(Map<String, dynamic> json) => SegmentSeat(
    rowSeats: json["RowSeats"] == null
        ? []
        : List<RowSeat>.from(
        json["RowSeats"]!.map((x) => RowSeat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "RowSeats": rowSeats == null
        ? []
        : List<dynamic>.from(rowSeats!.map((x) => x.toJson())),
  };
}

class RowSeat {
  List<Seat>? seats;

  RowSeat({
    this.seats,
  });

  factory RowSeat.fromJson(Map<String, dynamic> json) => RowSeat(
    seats: json["Seats"] == null
        ? []
        : List<Seat>.from(json["Seats"]!.map((x) => Seat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Seats": seats == null
        ? []
        : List<dynamic>.from(seats!.map((x) => x.toJson())),
  };
}

class Seat {
  String? airlineCode;
  String? flightNumber;
  String? craftType;
  String? origin;
  String? destination;
  int? availablityType;
  int? description;
  String? code;
  String? rowNo;
  String? seatNo;
  int? seatType;
  int? seatWayType;
  int? compartment;
  int? deck;
  String? currency;
  int? price;
  String? text;

  Seat({
    this.airlineCode,
    this.flightNumber,
    this.craftType,
    this.origin,
    this.destination,
    this.availablityType,
    this.description,
    this.code,
    this.rowNo,
    this.seatNo,
    this.seatType,
    this.seatWayType,
    this.compartment,
    this.deck,
    this.currency,
    this.price,
    this.text,
  });

  factory Seat.fromJson(Map<String, dynamic> json) => Seat(
    airlineCode: json["AirlineCode"],
    flightNumber: json["FlightNumber"],
    craftType: json["CraftType"],
    origin: json["Origin"],
    destination: json["Destination"],
    availablityType: json["AvailablityType"],
    description: json["Description"],
    code: json["Code"],
    rowNo: json["RowNo"],
    seatNo: json["SeatNo"],
    seatType: json["SeatType"],
    seatWayType: json["SeatWayType"],
    compartment: json["Compartment"],
    deck: json["Deck"],
    currency: json["Currency"],
    price: json["Price"],
    text: json["Text"],
  );

  Map<String, dynamic> toJson() => {
    "AirlineCode": airlineCode,
    "FlightNumber": flightNumber,
    "CraftType": craftType,
    "Origin": origin,
    "Destination": destination,
    "AvailablityType": availablityType,
    "Description": description,
    "Code": code,
    "RowNo": rowNo,
    "SeatNo": seatNo,
    "SeatType": seatType,
    "SeatWayType": seatWayType,
    "Compartment": compartment,
    "Deck": deck,
    "Currency": currency,
    "Price": price,
    "Text": text,
  };
}
