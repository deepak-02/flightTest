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
List<Map<String, dynamic>> selectedSeats = [];

List FlightSeats = [];

// var selectedMeal = "Spaghetti";
dynamic selectedMeal;
dynamic selectedNonLccMeal;
dynamic selectedSeatPreference;


bool ClickLoading = false;
int noOfAdult = 1;
int noOfChild = 0;
int noOfInfant = 0;

var searchPayload = {
"EndUserIp": "192.168.10.10",
"TokenId": "ac2751e9-4cc3-406f-b678-c947e4f57a00",
"AdultCount": "1",
"ChildCount": "0",
"InfantCount": "0",
"DirectFlight": "false",
"OneStopFlight": "false",
"JourneyType": "1",
"PreferredAirlines": null,
"Segments": [
{
"Origin": "DEL",
"Destination": "BOM",
"FlightCabinClass": "1",
"PreferredDepartureTime": "2015-11-06T00: 00: 00",
"PreferredArrivalTime": "2015-11-06T00: 00: 00"
}
],
"Sources": null
};