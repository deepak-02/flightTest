// To parse this JSON data, do
//
//     final lccBookModel = lccBookModelFromJson(jsonString);

import 'dart:convert';

LccBookModel lccBookModelFromJson(String str) => LccBookModel.fromJson(json.decode(str));

String lccBookModelToJson(LccBookModel data) => json.encode(data.toJson());

class LccBookModel {
  LccBookModelResponse? response;
  String? name;
  String? email;

  LccBookModel({
    this.response,
    this.name,
    this.email,
  });

  factory LccBookModel.fromJson(Map<String, dynamic> json) => LccBookModel(
    response: json["Response"] == null ? null : LccBookModelResponse.fromJson(json["Response"]),
    name: json["name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "Response": response?.toJson(),
    "name": name,
    "email": email,
  };
}

class LccBookModelResponse {
  dynamic b2B2BStatus;
  Error? error;
  dynamic responseStatus;
  String? traceId;
  ResponseResponse? response;

  LccBookModelResponse({
    this.b2B2BStatus,
    this.error,
    this.responseStatus,
    this.traceId,
    this.response,
  });

  factory LccBookModelResponse.fromJson(Map<String, dynamic> json) => LccBookModelResponse(
    b2B2BStatus: json["B2B2BStatus"],
    error: json["Error"] == null ? null : Error.fromJson(json["Error"]),
    responseStatus: json["ResponseStatus"],
    traceId: json["TraceId"],
    response: json["Response"] == null ? null : ResponseResponse.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "B2B2BStatus": b2B2BStatus,
    "Error": error?.toJson(),
    "ResponseStatus": responseStatus,
    "TraceId": traceId,
    "Response": response?.toJson(),
  };
}

class Error {
  dynamic errorCode;
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

class ResponseResponse {
  String? pnr;
  dynamic bookingId;
  dynamic ssrDenied;
  dynamic ssrMessage;
  dynamic status;
  dynamic isPriceChanged;
  dynamic isTimeChanged;
  FlightItinerary? flightItinerary;
  dynamic ticketStatus;

  ResponseResponse({
    this.pnr,
    this.bookingId,
    this.ssrDenied,
    this.ssrMessage,
    this.status,
    this.isPriceChanged,
    this.isTimeChanged,
    this.flightItinerary,
    this.ticketStatus,
  });

  factory ResponseResponse.fromJson(Map<String, dynamic> json) => ResponseResponse(
    pnr: json["PNR"],
    bookingId: json["BookingId"],
    ssrDenied: json["SSRDenied"],
    ssrMessage: json["SSRMessage"],
    status: json["Status"],
    isPriceChanged: json["IsPriceChanged"],
    isTimeChanged: json["IsTimeChanged"],
    flightItinerary: json["FlightItinerary"] == null ? null : FlightItinerary.fromJson(json["FlightItinerary"]),
    ticketStatus: json["TicketStatus"],
  );

  Map<String, dynamic> toJson() => {
    "PNR": pnr,
    "BookingId": bookingId,
    "SSRDenied": ssrDenied,
    "SSRMessage": ssrMessage,
    "Status": status,
    "IsPriceChanged": isPriceChanged,
    "IsTimeChanged": isTimeChanged,
    "FlightItinerary": flightItinerary?.toJson(),
    "TicketStatus": ticketStatus,
  };
}

class FlightItinerary {
  dynamic commentDetails;
  String? issuancePcc;
  dynamic journeyType;
  dynamic tripIndicator;
  dynamic bookingAllowedForRoamer;
  dynamic bookingId;
  dynamic isCouponAppilcable;
  dynamic isManual;
  String? pnr;
  dynamic isDomestic;
  String? resultFareType;
  dynamic source;
  String? origin;
  String? destination;
  String? airlineCode;
  DateTime? lastTicketDate;
  String? validatingAirlineCode;
  String? airlineRemark;
  String? airlineTollFreeNo;
  dynamic isLcc;
  dynamic nonRefundable;
  String? fareType;
  dynamic creditNoteNo;
  Fare? fare;
  dynamic creditNoteCreatedOn;
  List<Passenger>? passenger;
  dynamic cancellationCharges;
  List<Segment>? segments;
  List<FareRule>? fareRules;
  List<MiniFareRule>? miniFareRules;
  PenaltyCharges? penaltyCharges;
  dynamic status;
  List<Invoice>? invoice;
  dynamic invoiceAmount;
  String? invoiceNo;
  dynamic invoiceStatus;
  DateTime? invoiceCreatedOn;
  String? remarks;
  dynamic isWebCheckInAllowed;

  FlightItinerary({
    this.commentDetails,
    this.issuancePcc,
    this.journeyType,
    this.tripIndicator,
    this.bookingAllowedForRoamer,
    this.bookingId,
    this.isCouponAppilcable,
    this.isManual,
    this.pnr,
    this.isDomestic,
    this.resultFareType,
    this.source,
    this.origin,
    this.destination,
    this.airlineCode,
    this.lastTicketDate,
    this.validatingAirlineCode,
    this.airlineRemark,
    this.airlineTollFreeNo,
    this.isLcc,
    this.nonRefundable,
    this.fareType,
    this.creditNoteNo,
    this.fare,
    this.creditNoteCreatedOn,
    this.passenger,
    this.cancellationCharges,
    this.segments,
    this.fareRules,
    this.miniFareRules,
    this.penaltyCharges,
    this.status,
    this.invoice,
    this.invoiceAmount,
    this.invoiceNo,
    this.invoiceStatus,
    this.invoiceCreatedOn,
    this.remarks,
    this.isWebCheckInAllowed,
  });

  factory FlightItinerary.fromJson(Map<String, dynamic> json) => FlightItinerary(
    commentDetails: json["CommentDetails"],
    issuancePcc: json["IssuancePcc"],
    journeyType: json["JourneyType"],
    tripIndicator: json["TripIndicator"],
    bookingAllowedForRoamer: json["BookingAllowedForRoamer"],
    bookingId: json["BookingId"],
    isCouponAppilcable: json["IsCouponAppilcable"],
    isManual: json["IsManual"],
    pnr: json["PNR"],
    isDomestic: json["IsDomestic"],
    resultFareType: json["ResultFareType"],
    source: json["Source"],
    origin: json["Origin"],
    destination: json["Destination"],
    airlineCode: json["AirlineCode"],
    lastTicketDate: json["LastTicketDate"] == null ? null : DateTime.parse(json["LastTicketDate"]),
    validatingAirlineCode: json["ValidatingAirlineCode"],
    airlineRemark: json["AirlineRemark"],
    airlineTollFreeNo: json["AirlineTollFreeNo"],
    isLcc: json["IsLCC"],
    nonRefundable: json["NonRefundable"],
    fareType: json["FareType"],
    creditNoteNo: json["CreditNoteNo"],
    fare: json["Fare"] == null ? null : Fare.fromJson(json["Fare"]),
    creditNoteCreatedOn: json["CreditNoteCreatedOn"],
    passenger: json["Passenger"] == null ? [] : List<Passenger>.from(json["Passenger"]!.map((x) => Passenger.fromJson(x))),
    cancellationCharges: json["CancellationCharges"],
    segments: json["Segments"] == null ? [] : List<Segment>.from(json["Segments"]!.map((x) => Segment.fromJson(x))),
    fareRules: json["FareRules"] == null ? [] : List<FareRule>.from(json["FareRules"]!.map((x) => FareRule.fromJson(x))),
    miniFareRules: json["MiniFareRules"] == null ? [] : List<MiniFareRule>.from(json["MiniFareRules"]!.map((x) => MiniFareRule.fromJson(x))),
    penaltyCharges: json["PenaltyCharges"] == null ? null : PenaltyCharges.fromJson(json["PenaltyCharges"]),
    status: json["Status"],
    invoice: json["Invoice"] == null ? [] : List<Invoice>.from(json["Invoice"]!.map((x) => Invoice.fromJson(x))),
    invoiceAmount: json["InvoiceAmount"],
    invoiceNo: json["InvoiceNo"],
    invoiceStatus: json["InvoiceStatus"],
    invoiceCreatedOn: json["InvoiceCreatedOn"] == null ? null : DateTime.parse(json["InvoiceCreatedOn"]),
    remarks: json["Remarks"],
    isWebCheckInAllowed: json["IsWebCheckInAllowed"],
  );

  Map<String, dynamic> toJson() => {
    "CommentDetails": commentDetails,
    "IssuancePcc": issuancePcc,
    "JourneyType": journeyType,
    "TripIndicator": tripIndicator,
    "BookingAllowedForRoamer": bookingAllowedForRoamer,
    "BookingId": bookingId,
    "IsCouponAppilcable": isCouponAppilcable,
    "IsManual": isManual,
    "PNR": pnr,
    "IsDomestic": isDomestic,
    "ResultFareType": resultFareType,
    "Source": source,
    "Origin": origin,
    "Destination": destination,
    "AirlineCode": airlineCode,
    "LastTicketDate": lastTicketDate?.toIso8601String(),
    "ValidatingAirlineCode": validatingAirlineCode,
    "AirlineRemark": airlineRemark,
    "AirlineTollFreeNo": airlineTollFreeNo,
    "IsLCC": isLcc,
    "NonRefundable": nonRefundable,
    "FareType": fareType,
    "CreditNoteNo": creditNoteNo,
    "Fare": fare?.toJson(),
    "CreditNoteCreatedOn": creditNoteCreatedOn,
    "Passenger": passenger == null ? [] : List<dynamic>.from(passenger!.map((x) => x.toJson())),
    "CancellationCharges": cancellationCharges,
    "Segments": segments == null ? [] : List<dynamic>.from(segments!.map((x) => x.toJson())),
    "FareRules": fareRules == null ? [] : List<dynamic>.from(fareRules!.map((x) => x.toJson())),
    "MiniFareRules": miniFareRules == null ? [] : List<dynamic>.from(miniFareRules!.map((x) => x.toJson())),
    "PenaltyCharges": penaltyCharges?.toJson(),
    "Status": status,
    "Invoice": invoice == null ? [] : List<dynamic>.from(invoice!.map((x) => x.toJson())),
    "InvoiceAmount": invoiceAmount,
    "InvoiceNo": invoiceNo,
    "InvoiceStatus": invoiceStatus,
    "InvoiceCreatedOn": invoiceCreatedOn?.toIso8601String(),
    "Remarks": remarks,
    "IsWebCheckInAllowed": isWebCheckInAllowed,
  };
}

class Fare {
  String? currency;
  dynamic baseFare;
  dynamic tax;
  List<ChargeBu>? taxBreakup;
  dynamic yqTax;
  dynamic additionalTxnFeeOfrd;
  dynamic additionalTxnFeePub;
  dynamic pgCharge;
  double? otherCharges;
  List<ChargeBu>? chargeBu;
  dynamic discount;
  double? publishedFare;
  dynamic commissionEarned;
  double? plbEarned;
  double? incentiveEarned;
  double? offeredFare;
  double? tdsOnCommission;
  double? tdsOnPlb;
  double? tdsOnIncentive;
  dynamic serviceFee;
  dynamic totalBaggageCharges;
  dynamic totalMealCharges;
  dynamic totalSeatCharges;
  dynamic totalSpecialServiceCharges;

  Fare({
    this.currency,
    this.baseFare,
    this.tax,
    this.taxBreakup,
    this.yqTax,
    this.additionalTxnFeeOfrd,
    this.additionalTxnFeePub,
    this.pgCharge,
    this.otherCharges,
    this.chargeBu,
    this.discount,
    this.publishedFare,
    this.commissionEarned,
    this.plbEarned,
    this.incentiveEarned,
    this.offeredFare,
    this.tdsOnCommission,
    this.tdsOnPlb,
    this.tdsOnIncentive,
    this.serviceFee,
    this.totalBaggageCharges,
    this.totalMealCharges,
    this.totalSeatCharges,
    this.totalSpecialServiceCharges,
  });

  factory Fare.fromJson(Map<String, dynamic> json) => Fare(
    currency: json["Currency"],
    baseFare: json["BaseFare"],
    tax: json["Tax"],
    taxBreakup: json["TaxBreakup"] == null ? [] : List<ChargeBu>.from(json["TaxBreakup"]!.map((x) => ChargeBu.fromJson(x))),
    yqTax: json["YQTax"],
    additionalTxnFeeOfrd: json["AdditionalTxnFeeOfrd"],
    additionalTxnFeePub: json["AdditionalTxnFeePub"],
    pgCharge: json["PGCharge"],
    otherCharges: json["OtherCharges"]?.toDouble(),
    chargeBu: json["ChargeBU"] == null ? [] : List<ChargeBu>.from(json["ChargeBU"]!.map((x) => ChargeBu.fromJson(x))),
    discount: json["Discount"],
    publishedFare: json["PublishedFare"]?.toDouble(),
    commissionEarned: json["CommissionEarned"],
    plbEarned: json["PLBEarned"]?.toDouble(),
    incentiveEarned: json["IncentiveEarned"]?.toDouble(),
    offeredFare: json["OfferedFare"]?.toDouble(),
    tdsOnCommission: json["TdsOnCommission"]?.toDouble(),
    tdsOnPlb: json["TdsOnPLB"]?.toDouble(),
    tdsOnIncentive: json["TdsOnIncentive"]?.toDouble(),
    serviceFee: json["ServiceFee"],
    totalBaggageCharges: json["TotalBaggageCharges"],
    totalMealCharges: json["TotalMealCharges"],
    totalSeatCharges: json["TotalSeatCharges"],
    totalSpecialServiceCharges: json["TotalSpecialServiceCharges"],
  );

  Map<String, dynamic> toJson() => {
    "Currency": currency,
    "BaseFare": baseFare,
    "Tax": tax,
    "TaxBreakup": taxBreakup == null ? [] : List<dynamic>.from(taxBreakup!.map((x) => x.toJson())),
    "YQTax": yqTax,
    "AdditionalTxnFeeOfrd": additionalTxnFeeOfrd,
    "AdditionalTxnFeePub": additionalTxnFeePub,
    "PGCharge": pgCharge,
    "OtherCharges": otherCharges,
    "ChargeBU": chargeBu == null ? [] : List<dynamic>.from(chargeBu!.map((x) => x.toJson())),
    "Discount": discount,
    "PublishedFare": publishedFare,
    "CommissionEarned": commissionEarned,
    "PLBEarned": plbEarned,
    "IncentiveEarned": incentiveEarned,
    "OfferedFare": offeredFare,
    "TdsOnCommission": tdsOnCommission,
    "TdsOnPLB": tdsOnPlb,
    "TdsOnIncentive": tdsOnIncentive,
    "ServiceFee": serviceFee,
    "TotalBaggageCharges": totalBaggageCharges,
    "TotalMealCharges": totalMealCharges,
    "TotalSeatCharges": totalSeatCharges,
    "TotalSpecialServiceCharges": totalSpecialServiceCharges,
  };
}

class ChargeBu {
  String? key;
  double? value;

  ChargeBu({
    this.key,
    this.value,
  });

  factory ChargeBu.fromJson(Map<String, dynamic> json) => ChargeBu(
    key: json["key"],
    value: json["value"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };
}

class FareRule {
  String? origin;
  String? destination;
  String? airline;
  String? fareBasisCode;
  String? fareRuleDetail;
  dynamic fareRestriction;
  List<String>? fareInclusions;

  FareRule({
    this.origin,
    this.destination,
    this.airline,
    this.fareBasisCode,
    this.fareRuleDetail,
    this.fareRestriction,
    this.fareInclusions,
  });

  factory FareRule.fromJson(Map<String, dynamic> json) => FareRule(
    origin: json["Origin"],
    destination: json["Destination"],
    airline: json["Airline"],
    fareBasisCode: json["FareBasisCode"],
    fareRuleDetail: json["FareRuleDetail"],
    fareRestriction: json["FareRestriction"],
    fareInclusions: json["FareInclusions"] == null ? [] : List<String>.from(json["FareInclusions"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "Origin": origin,
    "Destination": destination,
    "Airline": airline,
    "FareBasisCode": fareBasisCode,
    "FareRuleDetail": fareRuleDetail,
    "FareRestriction": fareRestriction,
    "FareInclusions": fareInclusions == null ? [] : List<dynamic>.from(fareInclusions!.map((x) => x)),
  };
}

class Invoice {
  dynamic creditNoteGstin;
  dynamic gstin;
  DateTime? invoiceCreatedOn;
  dynamic invoiceId;
  String? invoiceNo;
  dynamic invoiceAmount;
  String? remarks;
  dynamic invoiceStatus;

  Invoice({
    this.creditNoteGstin,
    this.gstin,
    this.invoiceCreatedOn,
    this.invoiceId,
    this.invoiceNo,
    this.invoiceAmount,
    this.remarks,
    this.invoiceStatus,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
    creditNoteGstin: json["CreditNoteGSTIN"],
    gstin: json["GSTIN"],
    invoiceCreatedOn: json["InvoiceCreatedOn"] == null ? null : DateTime.parse(json["InvoiceCreatedOn"]),
    invoiceId: json["InvoiceId"],
    invoiceNo: json["InvoiceNo"],
    invoiceAmount: json["InvoiceAmount"],
    remarks: json["Remarks"],
    invoiceStatus: json["InvoiceStatus"],
  );

  Map<String, dynamic> toJson() => {
    "CreditNoteGSTIN": creditNoteGstin,
    "GSTIN": gstin,
    "InvoiceCreatedOn": invoiceCreatedOn?.toIso8601String(),
    "InvoiceId": invoiceId,
    "InvoiceNo": invoiceNo,
    "InvoiceAmount": invoiceAmount,
    "Remarks": remarks,
    "InvoiceStatus": invoiceStatus,
  };
}

class MiniFareRule {
  String? journeyPoints;
  String? type;
  String? from;
  String? to;
  String? unit;
  String? details;

  MiniFareRule({
    this.journeyPoints,
    this.type,
    this.from,
    this.to,
    this.unit,
    this.details,
  });

  factory MiniFareRule.fromJson(Map<String, dynamic> json) => MiniFareRule(
    journeyPoints: json["JourneyPoints"],
    type: json["Type"],
    from: json["From"],
    to: json["To"],
    unit: json["Unit"],
    details: json["Details"],
  );

  Map<String, dynamic> toJson() => {
    "JourneyPoints": journeyPoints,
    "Type": type,
    "From": from,
    "To": to,
    "Unit": unit,
    "Details": details,
  };
}

class Passenger {
  BarcodeDetails? barcodeDetails;
  dynamic documentDetails;
  dynamic guardianDetails;
  dynamic paxId;
  String? title;
  String? firstName;
  String? lastName;
  dynamic paxType;
  DateTime? dateOfBirth;
  dynamic gender;
  dynamic isPanRequired;
  dynamic isPassportRequired;
  String? pan;
  String? passportNo;
  String? addressLine1;
  Fare? fare;
  String? city;
  String? countryCode;
  String? nationality;
  String? contactNo;
  String? email;
  dynamic isLeadPax;
  dynamic ffAirlineCode;
  dynamic ffNumber;
  List<Baggage>? baggage;
  List<Baggage>? mealDynamic;
  List<SeatDynamic>? seatDynamic;
  List<dynamic>? ssr;
  Ticket? ticket;
  List<SegmentAdditionalInfo>? segmentAdditionalInfo;

  Passenger({
    this.barcodeDetails,
    this.documentDetails,
    this.guardianDetails,
    this.paxId,
    this.title,
    this.firstName,
    this.lastName,
    this.paxType,
    this.dateOfBirth,
    this.gender,
    this.isPanRequired,
    this.isPassportRequired,
    this.pan,
    this.passportNo,
    this.addressLine1,
    this.fare,
    this.city,
    this.countryCode,
    this.nationality,
    this.contactNo,
    this.email,
    this.isLeadPax,
    this.ffAirlineCode,
    this.ffNumber,
    this.baggage,
    this.mealDynamic,
    this.seatDynamic,
    this.ssr,
    this.ticket,
    this.segmentAdditionalInfo,
  });

  factory Passenger.fromJson(Map<String, dynamic> json) => Passenger(
    barcodeDetails: json["BarcodeDetails"] == null ? null : BarcodeDetails.fromJson(json["BarcodeDetails"]),
    documentDetails: json["DocumentDetails"],
    guardianDetails: json["GuardianDetails"],
    paxId: json["PaxId"],
    title: json["Title"],
    firstName: json["FirstName"],
    lastName: json["LastName"],
    paxType: json["PaxType"],
    dateOfBirth: json["DateOfBirth"] == null ? null : DateTime.parse(json["DateOfBirth"]),
    gender: json["Gender"],
    isPanRequired: json["IsPANRequired"],
    isPassportRequired: json["IsPassportRequired"],
    pan: json["PAN"],
    passportNo: json["PassportNo"],
    addressLine1: json["AddressLine1"],
    fare: json["Fare"] == null ? null : Fare.fromJson(json["Fare"]),
    city: json["City"],
    countryCode: json["CountryCode"],
    nationality: json["Nationality"],
    contactNo: json["ContactNo"],
    email: json["Email"],
    isLeadPax: json["IsLeadPax"],
    ffAirlineCode: json["FFAirlineCode"],
    ffNumber: json["FFNumber"],
    baggage: json["Baggage"] == null ? [] : List<Baggage>.from(json["Baggage"]!.map((x) => Baggage.fromJson(x))),
    mealDynamic: json["MealDynamic"] == null ? [] : List<Baggage>.from(json["MealDynamic"]!.map((x) => Baggage.fromJson(x))),
    seatDynamic: json["SeatDynamic"] == null ? [] : List<SeatDynamic>.from(json["SeatDynamic"]!.map((x) => SeatDynamic.fromJson(x))),
    ssr: json["Ssr"] == null ? [] : List<dynamic>.from(json["Ssr"]!.map((x) => x)),
    ticket: json["Ticket"] == null ? null : Ticket.fromJson(json["Ticket"]),
    segmentAdditionalInfo: json["SegmentAdditionalInfo"] == null ? [] : List<SegmentAdditionalInfo>.from(json["SegmentAdditionalInfo"]!.map((x) => SegmentAdditionalInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "BarcodeDetails": barcodeDetails?.toJson(),
    "DocumentDetails": documentDetails,
    "GuardianDetails": guardianDetails,
    "PaxId": paxId,
    "Title": title,
    "FirstName": firstName,
    "LastName": lastName,
    "PaxType": paxType,
    "DateOfBirth": dateOfBirth?.toIso8601String(),
    "Gender": gender,
    "IsPANRequired": isPanRequired,
    "IsPassportRequired": isPassportRequired,
    "PAN": pan,
    "PassportNo": passportNo,
    "AddressLine1": addressLine1,
    "Fare": fare?.toJson(),
    "City": city,
    "CountryCode": countryCode,
    "Nationality": nationality,
    "ContactNo": contactNo,
    "Email": email,
    "IsLeadPax": isLeadPax,
    "FFAirlineCode": ffAirlineCode,
    "FFNumber": ffNumber,
    "Baggage": baggage == null ? [] : List<dynamic>.from(baggage!.map((x) => x.toJson())),
    "MealDynamic": mealDynamic == null ? [] : List<dynamic>.from(mealDynamic!.map((x) => x.toJson())),
    "SeatDynamic": seatDynamic == null ? [] : List<dynamic>.from(seatDynamic!.map((x) => x.toJson())),
    "Ssr": ssr == null ? [] : List<dynamic>.from(ssr!.map((x) => x)),
    "Ticket": ticket?.toJson(),
    "SegmentAdditionalInfo": segmentAdditionalInfo == null ? [] : List<dynamic>.from(segmentAdditionalInfo!.map((x) => x.toJson())),
  };
}

class Baggage {
  String? airlineCode;
  String? flightNumber;
  dynamic wayType;
  String? code;
  dynamic description;
  dynamic weight;
  String? currency;
  dynamic price;
  String? origin;
  String? destination;
  String? airlineDescription;
  dynamic quantity;

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
    this.airlineDescription,
    this.quantity,
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
    airlineDescription: json["AirlineDescription"],
    quantity: json["Quantity"],
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
    "AirlineDescription": airlineDescription,
    "Quantity": quantity,
  };
}

class BarcodeDetails {
  dynamic id;
  List<Barcodes>? barcode;

  BarcodeDetails({
    this.id,
    this.barcode,
  });

  factory BarcodeDetails.fromJson(Map<String, dynamic> json) => BarcodeDetails(
    id: json["Id"],
    barcode: json["Barcode"] == null ? [] : List<Barcodes>.from(json["Barcode"]!.map((x) => Barcodes.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Barcode": barcode == null ? [] : List<dynamic>.from(barcode!.map((x) => x.toJson())),
  };
}

class Barcodes {
  dynamic index;
  String? format;
  String? content;
  dynamic barCodeInBase64;
  dynamic journeyWayType;

  Barcodes({
    this.index,
    this.format,
    this.content,
    this.barCodeInBase64,
    this.journeyWayType,
  });

  factory Barcodes.fromJson(Map<String, dynamic> json) => Barcodes(
    index: json["Index"],
    format: json["Format"],
    content: json["Content"],
    barCodeInBase64: json["BarCodeInBase64"],
    journeyWayType: json["JourneyWayType"],
  );

  Map<String, dynamic> toJson() => {
    "Index": index,
    "Format": format,
    "Content": content,
    "BarCodeInBase64": barCodeInBase64,
    "JourneyWayType": journeyWayType,
  };
}

class SeatDynamic {
  String? airlineCode;
  String? flightNumber;
  String? craftType;
  String? origin;
  String? destination;
  dynamic availablityType;
  dynamic description;
  String? code;
  String? rowNo;
  String? seatNo;
  dynamic seatType;
  dynamic seatWayType;
  dynamic compartment;
  dynamic deck;
  String? currency;
  dynamic price;

  SeatDynamic({
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
  });

  factory SeatDynamic.fromJson(Map<String, dynamic> json) => SeatDynamic(
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
  };
}

class SegmentAdditionalInfo {
  String? fareBasis;
  String? nva;
  String? nvb;
  String? baggage;
  String? meal;
  String? seat;
  String? specialService;

  SegmentAdditionalInfo({
    this.fareBasis,
    this.nva,
    this.nvb,
    this.baggage,
    this.meal,
    this.seat,
    this.specialService,
  });

  factory SegmentAdditionalInfo.fromJson(Map<String, dynamic> json) => SegmentAdditionalInfo(
    fareBasis: json["FareBasis"],
    nva: json["NVA"],
    nvb: json["NVB"],
    baggage: json["Baggage"],
    meal: json["Meal"],
    seat: json["Seat"],
    specialService: json["SpecialService"],
  );

  Map<String, dynamic> toJson() => {
    "FareBasis": fareBasis,
    "NVA": nva,
    "NVB": nvb,
    "Baggage": baggage,
    "Meal": meal,
    "Seat": seat,
    "SpecialService": specialService,
  };
}

class Ticket {
  dynamic ticketId;
  String? ticketNumber;
  DateTime? issueDate;
  String? validatingAirline;
  String? remarks;
  String? serviceFeeDisplayType;
  String? status;
  String? conjunctionNumber;
  String? ticketType;

  Ticket({
    this.ticketId,
    this.ticketNumber,
    this.issueDate,
    this.validatingAirline,
    this.remarks,
    this.serviceFeeDisplayType,
    this.status,
    this.conjunctionNumber,
    this.ticketType,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    ticketId: json["TicketId"],
    ticketNumber: json["TicketNumber"],
    issueDate: json["IssueDate"] == null ? null : DateTime.parse(json["IssueDate"]),
    validatingAirline: json["ValidatingAirline"],
    remarks: json["Remarks"],
    serviceFeeDisplayType: json["ServiceFeeDisplayType"],
    status: json["Status"],
    conjunctionNumber: json["ConjunctionNumber"],
    ticketType: json["TicketType"],
  );

  Map<String, dynamic> toJson() => {
    "TicketId": ticketId,
    "TicketNumber": ticketNumber,
    "IssueDate": issueDate?.toIso8601String(),
    "ValidatingAirline": validatingAirline,
    "Remarks": remarks,
    "ServiceFeeDisplayType": serviceFeeDisplayType,
    "Status": status,
    "ConjunctionNumber": conjunctionNumber,
    "TicketType": ticketType,
  };
}

class PenaltyCharges {
  PenaltyCharges();

  factory PenaltyCharges.fromJson(Map<String, dynamic> json) => PenaltyCharges(
  );

  Map<String, dynamic> toJson() => {
  };
}

class Segment {
  String? baggage;
  String? cabinBaggage;
  dynamic cabinClass;
  dynamic supplierFareClass;
  dynamic tripIndicator;
  dynamic segmentIndicator;
  Airline? airline;
  String? airlinePnr;
  Origin? origin;
  Destination? destination;
  dynamic duration;
  dynamic groundTime;
  dynamic mile;
  dynamic stopOver;
  String? flightInfoIndex;
  String? stopPoint;
  DateTime? stopPointArrivalTime;
  DateTime? stopPointDepartureTime;
  String? craft;
  dynamic remark;
  dynamic isETicketEligible;
  String? flightStatus;
  String? status;
  dynamic fareClassification;

  Segment({
    this.baggage,
    this.cabinBaggage,
    this.cabinClass,
    this.supplierFareClass,
    this.tripIndicator,
    this.segmentIndicator,
    this.airline,
    this.airlinePnr,
    this.origin,
    this.destination,
    this.duration,
    this.groundTime,
    this.mile,
    this.stopOver,
    this.flightInfoIndex,
    this.stopPoint,
    this.stopPointArrivalTime,
    this.stopPointDepartureTime,
    this.craft,
    this.remark,
    this.isETicketEligible,
    this.flightStatus,
    this.status,
    this.fareClassification,
  });

  factory Segment.fromJson(Map<String, dynamic> json) => Segment(
    baggage: json["Baggage"],
    cabinBaggage: json["CabinBaggage"],
    cabinClass: json["CabinClass"],
    supplierFareClass: json["SupplierFareClass"],
    tripIndicator: json["TripIndicator"],
    segmentIndicator: json["SegmentIndicator"],
    airline: json["Airline"] == null ? null : Airline.fromJson(json["Airline"]),
    airlinePnr: json["AirlinePNR"],
    origin: json["Origin"] == null ? null : Origin.fromJson(json["Origin"]),
    destination: json["Destination"] == null ? null : Destination.fromJson(json["Destination"]),
    duration: json["Duration"],
    groundTime: json["GroundTime"],
    mile: json["Mile"],
    stopOver: json["StopOver"],
    flightInfoIndex: json["FlightInfoIndex"],
    stopPoint: json["StopPoint"],
    stopPointArrivalTime: json["StopPointArrivalTime"] == null ? null : DateTime.parse(json["StopPointArrivalTime"]),
    stopPointDepartureTime: json["StopPointDepartureTime"] == null ? null : DateTime.parse(json["StopPointDepartureTime"]),
    craft: json["Craft"],
    remark: json["Remark"],
    isETicketEligible: json["IsETicketEligible"],
    flightStatus: json["FlightStatus"],
    status: json["Status"],
    fareClassification: json["FareClassification"],
  );

  Map<String, dynamic> toJson() => {
    "Baggage": baggage,
    "CabinBaggage": cabinBaggage,
    "CabinClass": cabinClass,
    "SupplierFareClass": supplierFareClass,
    "TripIndicator": tripIndicator,
    "SegmentIndicator": segmentIndicator,
    "Airline": airline?.toJson(),
    "AirlinePNR": airlinePnr,
    "Origin": origin?.toJson(),
    "Destination": destination?.toJson(),
    "Duration": duration,
    "GroundTime": groundTime,
    "Mile": mile,
    "StopOver": stopOver,
    "FlightInfoIndex": flightInfoIndex,
    "StopPoint": stopPoint,
    "StopPointArrivalTime": stopPointArrivalTime?.toIso8601String(),
    "StopPointDepartureTime": stopPointDepartureTime?.toIso8601String(),
    "Craft": craft,
    "Remark": remark,
    "IsETicketEligible": isETicketEligible,
    "FlightStatus": flightStatus,
    "Status": status,
    "FareClassification": fareClassification,
  };
}

class Airline {
  String? airlineCode;
  String? airlineName;
  String? flightNumber;
  String? fareClass;
  String? operatingCarrier;

  Airline({
    this.airlineCode,
    this.airlineName,
    this.flightNumber,
    this.fareClass,
    this.operatingCarrier,
  });

  factory Airline.fromJson(Map<String, dynamic> json) => Airline(
    airlineCode: json["AirlineCode"],
    airlineName: json["AirlineName"],
    flightNumber: json["FlightNumber"],
    fareClass: json["FareClass"],
    operatingCarrier: json["OperatingCarrier"],
  );

  Map<String, dynamic> toJson() => {
    "AirlineCode": airlineCode,
    "AirlineName": airlineName,
    "FlightNumber": flightNumber,
    "FareClass": fareClass,
    "OperatingCarrier": operatingCarrier,
  };
}

class Destination {
  Airport? airport;
  DateTime? arrTime;

  Destination({
    this.airport,
    this.arrTime,
  });

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
    airport: json["Airport"] == null ? null : Airport.fromJson(json["Airport"]),
    arrTime: json["ArrTime"] == null ? null : DateTime.parse(json["ArrTime"]),
  );

  Map<String, dynamic> toJson() => {
    "Airport": airport?.toJson(),
    "ArrTime": arrTime?.toIso8601String(),
  };
}

class Airport {
  String? airportCode;
  String? airportName;
  String? terminal;
  String? cityCode;
  String? cityName;
  String? countryCode;
  String? countryName;

  Airport({
    this.airportCode,
    this.airportName,
    this.terminal,
    this.cityCode,
    this.cityName,
    this.countryCode,
    this.countryName,
  });

  factory Airport.fromJson(Map<String, dynamic> json) => Airport(
    airportCode: json["AirportCode"],
    airportName: json["AirportName"],
    terminal: json["Terminal"],
    cityCode: json["CityCode"],
    cityName: json["CityName"],
    countryCode: json["CountryCode"],
    countryName: json["CountryName"],
  );

  Map<String, dynamic> toJson() => {
    "AirportCode": airportCode,
    "AirportName": airportName,
    "Terminal": terminal,
    "CityCode": cityCode,
    "CityName": cityName,
    "CountryCode": countryCode,
    "CountryName": countryName,
  };
}

class Origin {
  Airport? airport;
  DateTime? depTime;

  Origin({
    this.airport,
    this.depTime,
  });

  factory Origin.fromJson(Map<String, dynamic> json) => Origin(
    airport: json["Airport"] == null ? null : Airport.fromJson(json["Airport"]),
    depTime: json["DepTime"] == null ? null : DateTime.parse(json["DepTime"]),
  );

  Map<String, dynamic> toJson() => {
    "Airport": airport?.toJson(),
    "DepTime": depTime?.toIso8601String(),
  };
}
