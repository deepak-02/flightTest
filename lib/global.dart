import 'package:intl/intl.dart';

import 'models/lccWithSSR.dart';
import 'models/searchModel.dart';

var api = 'https://api.theawayholidays.com/';

String startDate = DateFormat('yyyy-MM-ddT00:00:00').format(DateTime.now()).toString(); // Initial date in the desired format
String endDate = DateFormat('yyyy-MM-ddT00:00:00').format(DateTime.now().add(const Duration(days: 1))).toString(); // Initial date in the desired format

int planeClassType = 1;

List<Result> flightDetails = [];

var originCode = "DEL";
var destinationCode = "BOM";

dynamic selectedOption;

var selectedItem;
var selectedDuration = "";
var selectedFlight = "";
var ip = "192.168.10.10";

List<Baggage> LccBaggage = [];

late bool lcc;
bool ssr = true;
List<Baggage> mealItems = [];


List<SeatDynamic>? seatDynamic = [];
List<SpecialService>? specialServices = [];

// Set selectedSeats = {};
// List<Map<String, dynamic>> selectedSeats = [];
//
List FlightSeats = [];

// var selectedMeal = "Spaghetti";
dynamic selectedMeal;
dynamic selectedNonLccMeal;
dynamic selectedSeatPreference;


bool ClickLoading = false;
int noOfAdult = 1;
int noOfChild = 0;
int noOfInfant = 0;


List passengerDetails = [];


var bookedResponse = {
  "Response": {
    "B2B2BStatus": false,
    "Error": {
      "ErrorCode": 0,
      "ErrorMessage": ""
    },
    "ResponseStatus": 1,
    "TraceId": "992274fd-1b0a-4be0-988f-62a68b0a05f3",
    "Response": {
      "PNR": "LB12UW",
      "BookingId": 1836100,
      "SSRDenied": false,
      "SSRMessage": null,
      "Status": 1,
      "IsPriceChanged": false,
      "IsTimeChanged": false,
      "FlightItinerary": {
        "CommentDetails": null,
        "IssuancePcc": "APITESTID",
        "JourneyType": 1,
        "TripIndicator": 1,
        "BookingAllowedForRoamer": true,
        "BookingId": 1836100,
        "IsCouponAppilcable": true,
        "IsManual": false,
        "PNR": "LB12UW",
        "IsDomestic": true,
        "ResultFareType": "RegularFare",
        "Source": 3,
        "Origin": "DEL",
        "Destination": "BOM",
        "AirlineCode": "SG",
        "LastTicketDate": "9999-12-31T00:00:00",
        "ValidatingAirlineCode": "SG",
        "AirlineRemark": "SpiceJet Main",
        "AirlineTollFreeNo": "9876543210",
        "IsLCC": true,
        "NonRefundable": false,
        "FareType": "PUB",
        "CreditNoteNo": null,
        "Fare": {
          "Currency": "INR",
          "BaseFare": 3059,
          "Tax": 373,
          "TaxBreakup": [
            {
              "key": "K3",
              "value": 155.0
            },
            {
              "key": "PSF",
              "value": 91.0
            },
            {
              "key": "UDF",
              "value": 12.0
            },
            {
              "key": "YR",
              "value": 65.0
            },
            {
              "key": "TotalTax",
              "value": 373.0
            },
            {
              "key": "OtherTaxes",
              "value": 50.0
            }
          ],
          "YQTax": 0,
          "AdditionalTxnFeeOfrd": 0,
          "AdditionalTxnFeePub": 0,
          "PGCharge": 0,
          "OtherCharges": 1.77,
          "ChargeBU": [
            {
              "key": "TBOMARKUP",
              "value": 0
            },
            {
              "key": "GLOBALPROCUREMENTCHARGE",
              "value": 0
            },
            {
              "key": "OTHERCHARGE",
              "value": 1.77
            },
            {
              "key": "CONVENIENCECHARGE",
              "value": 0
            }
          ],
          "Discount": 0.0,
          "PublishedFare": 4432.77,
          "CommissionEarned": 52.0,
          "PLBEarned": 93.78,
          "IncentiveEarned": 147.94,
          "OfferedFare": 4139.05,
          "TdsOnCommission": 20.8,
          "TdsOnPLB": 37.51,
          "TdsOnIncentive": 59.18,
          "ServiceFee": 0,
          "TotalBaggageCharges": 0,
          "TotalMealCharges": 0,
          "TotalSeatCharges": 999,
          "TotalSpecialServiceCharges": 0
        },
        "CreditNoteCreatedOn": null,
        "Passenger": [
          {
            "BarcodeDetails": {
              "Id": 3032833,
              "Barcode": [
                {
                  "Index": 1,
                  "Format": "PDF417",
                  "Content": "M1TES/TEST             LB12UW DELBOMSG 8169 234Y001A0000 000",
                  "BarCodeInBase64": null,
                  "JourneyWayType": 3
                }
              ]
            },
            "DocumentDetails": null,
            "GuardianDetails": null,
            "PaxId": 3032833,
            "Title": "Mr",
            "FirstName": "Test",
            "LastName": "tes",
            "PaxType": 1,
            "DateOfBirth": "1955-08-18T00:00:00",
            "Gender": 1,
            "IsPANRequired": false,
            "IsPassportRequired": false,
            "PAN": "",
            "PassportNo": "",
            "AddressLine1": "address",
            "Fare": {
              "Currency": "INR",
              "BaseFare": 3059,
              "Tax": 373,
              "TaxBreakup": [
                {
                  "key": "K3",
                  "value": 155.0
                },
                {
                  "key": "PSF",
                  "value": 91.0
                },
                {
                  "key": "UDF",
                  "value": 12.0
                },
                {
                  "key": "YR",
                  "value": 65.0
                },
                {
                  "key": "TotalTax",
                  "value": 373.0
                },
                {
                  "key": "OtherTaxes",
                  "value": 50.0
                }
              ],
              "YQTax": 0,
              "AdditionalTxnFeeOfrd": 0,
              "AdditionalTxnFeePub": 0,
              "PGCharge": 0,
              "OtherCharges": 1.77,
              "ChargeBU": [
                {
                  "key": "TBOMARKUP",
                  "value": 0
                },
                {
                  "key": "GLOBALPROCUREMENTCHARGE",
                  "value": 0
                },
                {
                  "key": "OTHERCHARGE",
                  "value": 1.77
                },
                {
                  "key": "CONVENIENCECHARGE",
                  "value": 0
                }
              ],
              "Discount": 0.0,
              "PublishedFare": 4432.77,
              "CommissionEarned": 52.0,
              "PLBEarned": 93.78,
              "IncentiveEarned": 147.94,
              "OfferedFare": 4139.05,
              "TdsOnCommission": 20.8,
              "TdsOnPLB": 37.51,
              "TdsOnIncentive": 59.18,
              "ServiceFee": 0,
              "TotalBaggageCharges": 0,
              "TotalMealCharges": 0,
              "TotalSeatCharges": 999,
              "TotalSpecialServiceCharges": 0
            },
            "City": "city",
            "CountryCode": "",
            "Nationality": "",
            "ContactNo": "9087667878",
            "Email": "deepakck.ptf@gmail.com",
            "IsLeadPax": true,
            "FFAirlineCode": null,
            "FFNumber": null,
            "Baggage": [
              {
                "AirlineCode": "SG",
                "FlightNumber": "8169",
                "WayType": 2,
                "Code": "NoBaggage",
                "Description": 2,
                "Weight": 0,
                "Currency": "INR",
                "Price": 0,
                "Origin": "DEL",
                "Destination": "BOM"
              }
            ],
            "MealDynamic": [
              {
                "AirlineCode": "SG",
                "FlightNumber": "8169",
                "WayType": 2,
                "Code": "NoMeal",
                "Description": 2,
                "AirlineDescription": "",
                "Quantity": 0,
                "Currency": "INR",
                "Price": 0,
                "Origin": "DEL",
                "Destination": "BOM"
              }
            ],
            "SeatDynamic": [
              {
                "AirlineCode": "SG",
                "FlightNumber": "8169",
                "CraftType": "B-737-800 (Y189)SGH",
                "Origin": "DEL",
                "Destination": "BOM",
                "AvailablityType": 1,
                "Description": 2,
                "Code": "1A",
                "RowNo": "1",
                "SeatNo": "A",
                "SeatType": 1,
                "SeatWayType": 2,
                "Compartment": 1,
                "Deck": 1,
                "Currency": "INR",
                "Price": 999
              }
            ],
            "Ssr": [],
            "Ticket": {
              "TicketId": 2127516,
              "TicketNumber": "LB12UW",
              "IssueDate": "2023-08-22T11:20:34",
              "ValidatingAirline": "001",
              "Remarks": "",
              "ServiceFeeDisplayType": "ShowInTax",
              "Status": "OK",
              "ConjunctionNumber": "",
              "TicketType": "N"
            },
            "SegmentAdditionalInfo": [
              {
                "FareBasis": "VSAV",
                "NVA": "",
                "NVB": "",
                "Baggage": "15 KG",
                "Meal": "0 Platter",
                "Seat": "1A",
                "SpecialService": ""
              }
            ]
          }
        ],
        "CancellationCharges": null,
        "Segments": [
          {
            "Baggage": "15 KG",
            "CabinBaggage": "7 KG",
            "CabinClass": 2,
            "SupplierFareClass": null,
            "TripIndicator": 1,
            "SegmentIndicator": 1,
            "Airline": {
              "AirlineCode": "SG",
              "AirlineName": "SpiceJet",
              "FlightNumber": "8169",
              "FareClass": "V",
              "OperatingCarrier": ""
            },
            "AirlinePNR": "",
            "Origin": {
              "Airport": {
                "AirportCode": "DEL",
                "AirportName": "Indira Gandhi Airport",
                "Terminal": "3",
                "CityCode": "DEL",
                "CityName": "Delhi",
                "CountryCode": "IN",
                "CountryName": "India"
              },
              "DepTime": "2023-08-22T20:00:00"
            },
            "Destination": {
              "Airport": {
                "AirportCode": "BOM",
                "AirportName": "Mumbai",
                "Terminal": "2",
                "CityCode": "BOM",
                "CityName": "Mumbai",
                "CountryCode": "IN",
                "CountryName": "India"
              },
              "ArrTime": "2023-08-22T22:15:00"
            },
            "Duration": 135,
            "GroundTime": 0,
            "Mile": 0,
            "StopOver": false,
            "FlightInfoIndex": "",
            "StopPoint": "",
            "StopPointArrivalTime": "0001-01-01T00:00:00",
            "StopPointDepartureTime": "0001-01-01T00:00:00",
            "Craft": "737",
            "Remark": null,
            "IsETicketEligible": true,
            "FlightStatus": "Confirmed",
            "Status": "HK",
            "FareClassification": null
          }
        ],
        "FareRules": [
          {
            "Origin": "DEL",
            "Destination": "BOM",
            "Airline": "SG",
            "FareBasisCode": "VSAV",
            "FareRuleDetail": "The FareBasisCode is: VSAV<br /><b><ul><li>Facilitation Fee of Rs.200 per passenger per flight - for Tele Check-in done at Reservations.</li><li>An Additional Sum of Rs.350 per passenger per flight for flight change / booking cancellation processed via Reservations and Airport Ticketing Counters. This fee will not apply to CELT bookings.</li></ul><br /></b><b>COVID - 19 Important Travel guidelines</b><br /><ul><li>After booking its mandatory for all passengers to do “Web check-in” their PNR with pre-selected seats to avoid the long queue at the airport.</li><li>Passengers travelling with Checked-in luggage, need to add their luggage during web check-in. Per Passenger 1 piece of Checked in Baggage upto 15 kgs will be allowed. Addition to this one small hand luggage less than of 7 Kgs per passenger will be allowed. </li><li>Carriage of printout of Boarding card and Baggage label which will be sent to the guest on their contact details or can download during web check-in</li><li>Also can carry Mobile boarding pass and carry printed or written baggage label, format will be available on SpiceJet website.</li><li>Before reaching to the airport, Passenger need to paste the attached Baggage label on the baggage OR guest can write the mandatory fields i.e. PNR, Name of the passenger, Sector and Flight Number on plain paper & paste the same on baggage which should be prominently visible, as airport may not be having any pasting material to place the labels on the baggage.</li><li><b>Each passenger Contact number and Email id is mandatory to be provided during booking.</b></li><li>Partners are requested to provide the Boarding pass and Baggage labels to the guests for their seamless travel.</li><li>Passenger Health declaration status and their mobile should have <b><u>“Arogya Setu”</u></b> app which shows Green status.</li><li>Passenger must be wearing mask properly at the airport & throughout the journey.</li><li>Passenger must sanitize at airports at various points.</li><li>Maintain Social distancing at the airport as per the markings/guidance.</li></ul>For Safety of all customers, SpiceJet reserves the rights to refuse the carriage of any passenger whose contact details are missing. Also, its mandatory to do the Web Check-in.<br /><table border=\"1\"><tbody><tr><td rowspan=\"2\"><b>Change/Cancel/Meal/Seat/Baggage</b></td><td></td><td colspan=\"2\" style=\"text-align:center\"><b>Fare Type</b></td></tr><tr><td></td><td width=\"150px;\">Hand Bag Fare</td><td width=\"150px;\">Regular Fare</td></tr><tr><td>Meal/Seat</td><td>Domestic/International</td><td colspan=\"2\" style=\"text-align:center\">Chargeable</td></tr><tr><td rowspan=\"3\">Baggage</td><td>Domestic(Check-in baggage)</td><td>0 Kg</td><td style=\"text-align:center\">15 Kg (1 Pc)</td></tr><tr><td>Domestic(Hand baggage)</td><td colspan=\"2\" style=\"text-align:center\">7 Kg</td></tr><tr><td>International</td><td colspan=\"3\" style=\"text-align:center\"><a href=\"https://www.spicejet.com/AirTravelBaggageFaq.aspx\" target=\"_blank\"> Click Here</a></td></tr><tr><td rowspan=\"6\" width=\"200px;\">Flight Change fee <br><b>(Fare Difference is also applicable)</b></td><td><b>No. of Days Left For Departure</b></td><td colspan=\"3\" style=\"text-align:center\"><b>Domestic</b></td></tr><tr><td>Within 4Days</td><td colspan=\"2\" style=\"text-align:center\">INR 3350</td></tr><tr><td>Beyond 4 Days</td><td colspan=\"2\" style=\"text-align:center\">INR 2850</td></tr><tr><td colspan=\"4\" style=\"text-align:center\"><b>International</b></td></tr><tr><td>Within 4Days</td><td colspan=\"2\" style=\"text-align:center\">UPTO INR 4250 </td></tr><tr><td>Beyond 4 Days</td><td colspan=\"2\" style=\"text-align:center\">UPTO INR 3750</td></tr><tr><td rowspan=\"6\" width=\"200px;\">Sector Change fee <br><b>(Fare Difference is also applicable)</b></td><td colspan=\"3\" style=\"text-align:center\"><b>Domestic</b></td></tr><tr><td>Within 4Days</td><td colspan=\"2\" style=\"text-align:center\">INR 3500</td></tr><tr><td>Beyond 4 Days</td><td colspan=\"2\" style=\"text-align:center\">INR 3000</td></tr><tr><td colspan=\"4\" style=\"text-align:center\"><b>International</b></td></tr><tr><td>Within 4Days</td><td colspan=\"2\" style=\"text-align:center\">UPTO INR 5000 </td></tr><tr><td>Beyond 4 Days</td><td colspan=\"2\" style=\"text-align:center\">UPTO INR 4500</td></tr><tr><td rowspan=\"6\" width=\"200px;\">Cancellation Fee<br><b>or Airfare charges (Whichever is lower)</b></td><td colspan=\"3\" style=\"text-align:center\"><b>Domestic</b></td></tr><tr><td>Within 4Days</td><td colspan=\"3\" style=\"text-align:center\">INR 3600</td></tr><tr><td>Beyond 4 Days</td><td colspan=\"3\" style=\"text-align:center\">INR 3100</td></tr><tr><td colspan=\"4\" style=\"text-align:center\"><b>International</b></td></tr><tr><td>Within 4Days</td><td colspan=\"3\" style=\"text-align:center\">UPTO INR 5000</td></tr><tr><td>Beyond 4 Days</td><td colspan=\"3\" style=\"text-align:center\">UPTO INR 4500</td></tr></tbody></table><br />Subject to change without prior notice. <b>Note</b> : We should receive the request at least four hours prior to Airline Fare Rules Policy.<br/> <br/><ul><li>APART FROM AIRLINE CHARGES,GST+RAF+ APPLICABLE CHARGES IF ANY, WILL BE CHARGED.</li><li>MENTIONED FEE ARE PER PAX AND PER SECTOR.</li><li>FOR DOMESTIC BOOKINGS, PASSENGERS ARE REQUIRED TO SUBMIT THE CANCELLATION OR REISSUE REQUEST TO TBO AT LEAST 2 HOURS BEFORE THE AIRLINES CANCELLATION AND REISSUE POLICY.</li><li>FOR INTERNATIONAL BOOKINGS, PASSENGERS ARE REQUIRED TO SUBMIT THE CANCELLATION OR REISSUE REQUEST TO TBO AT LEAST 4 HOURS BEFORE THE AIRLINES CANCELLATION AND REISSUE POLICY.</li></ul>",
            "FareRestriction": null,
            "FareInclusions": [
              "Cabin Baggage included",
              "TESTING 1290"
            ]
          }
        ],
        "MiniFareRules": [
          {
            "JourneyPoints": "DEL-BOM",
            "Type": "Reissue",
            "From": "0",
            "To": "3",
            "Unit": "Days",
            "Details": "INR 3350"
          },
          {
            "JourneyPoints": "DEL-BOM",
            "Type": "Reissue",
            "From": "4",
            "To": "",
            "Unit": "Days",
            "Details": "INR 2850"
          },
          {
            "JourneyPoints": "DEL-BOM",
            "Type": "Cancellation",
            "From": "0",
            "To": "3",
            "Unit": "Days",
            "Details": "INR 3600"
          },
          {
            "JourneyPoints": "DEL-BOM",
            "Type": "Cancellation",
            "From": "4",
            "To": "",
            "Unit": "Days",
            "Details": "INR 3100"
          }
        ],
        "PenaltyCharges": {},
        "Status": 5,
        "Invoice": [
          {
            "CreditNoteGSTIN": null,
            "GSTIN": null,
            "InvoiceCreatedOn": "2023-08-22T11:20:35",
            "InvoiceId": 8797,
            "InvoiceNo": "ID/2324/8797",
            "InvoiceAmount": 4257.0,
            "Remarks": "",
            "InvoiceStatus": 3
          }
        ],
        "InvoiceAmount": 4257.0,
        "InvoiceNo": "ID/2324/8797",
        "InvoiceStatus": 3,
        "InvoiceCreatedOn": "2023-08-22T11:20:35",
        "Remarks": "",
        "IsWebCheckInAllowed": false
      },
      "TicketStatus": 1
    }
  },
  "name": "Test ",
  "email": "deepakck.ptf@gmail.com"
};