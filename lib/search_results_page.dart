import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/global.dart';
import 'package:http/http.dart' as http;

import 'flight_details.dart';
import 'models/searchModel.dart';

class SearchResultsPage extends StatefulWidget {
  const SearchResultsPage({Key? key, required this.startDate, required this.endDate}) : super(key: key);
  final String startDate;
  final String endDate;

  @override
  SearchResultsPageState createState() => SearchResultsPageState();
}

class SearchResultsPageState extends State<SearchResultsPage> {

  var segments = [
    {
      "Origin": originCode,
      "Destination": destinationCode,
      "FlightCabinClass": "$planeClassType",
      "PreferredDepartureTime": startDate, //"2023-05-26T00: 00: 00",
      "PreferredArrivalTime": endDate //"2023-05-27T00: 00: 00"
    }
  ];
  bool loading = true;

  List<Result> flightResult = [];

  int resultLength = 0;

  var traceId = "";

  var token = "";

  List<String> imagePaths = [];

  @override
  void initState() {
    search();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 30),
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: flightResult.length,
                  itemBuilder: (BuildContext context, int index) {
                    var items = flightResult[index];

                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedItem = flightResult[index];
                          ClickLoading = true;
                          if (flightDetails.isNotEmpty) {
                            flightDetails.clear();
                          }
                          flightDetails.add(flightResult[index]);
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FlightDetails(
                                ResultIndex: items.resultIndex,
                                TraceId: traceId,
                                Token: token,
                              )),
                        );
                      },
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: items.segments![0].length,
                              itemBuilder: (BuildContext context, int index) {
                                var segment = items.segments![0][index];

                                String formatDuration(int duration) {
                                  int hours = duration ~/ 60;
                                  int minutes = duration % 60;

                                  String formattedHours =
                                  hours.toString().padLeft(2, '0');
                                  String formattedMinutes =
                                  minutes.toString().padLeft(2, '0');

                                  return '$formattedHours h $formattedMinutes m';
                                }

                                // var airLogo =
                                //     "assets/images/AirlineLogo/nologo.gif";
                                //
                                // for (int i = 0; i < imagePaths.length; i++) {
                                //   var imgPath = imagePaths[i];
                                //   var imgName = imgPath
                                //       .split('/')
                                //       .last; // Extract the image name from the path
                                //   var imgCode = imgName
                                //       .split('.')
                                //       .first; // Extract the code from the image name
                                //   var airCode = segment.airline!.airlineCode;
                                //
                                //   if (imgCode.toLowerCase() ==
                                //       airCode!.toLowerCase()) {
                                //     // print(airCode);
                                //     // print(imgCode);
                                //     airLogo = imgPath;
                                //   }
                                // }

                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                DateFormat.Hm().format(DateTime.parse(segment.origin!.depTime.toString())),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${segment.origin!.airport!.airportCode}",
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                        FontWeight.w500),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    DateFormat('dd MMM').format(DateTime.parse(segment.origin!.depTime.toString())),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FittedBox(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    formatDuration(segment.duration!),
                                                    style: const TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    height: 1,
                                                    width:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                        2.5,
                                                    color: Colors.grey,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    // "1 stop",
                                                    "${segment.flightStatus}",
                                                    style: const TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                DateFormat.Hm().format(DateTime.parse(segment.destination!.arrTime.toString())),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${segment.destination!.airport!.airportCode}",
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                        FontWeight.w500),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    DateFormat('dd MMM').format(DateTime.parse(segment.destination!.arrTime.toString())),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          // Icon(
                                          //     Icons.airplane_ticket_rounded
                                          // ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: 50,
                                            child: const Icon(Icons.airplane_ticket_sharp)
                                            // Image.asset(
                                            //   airLogo,
                                            // ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "${segment.airline!.airlineName}",
                                            style: const TextStyle(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons
                                                      .shopping_bag_outlined),
                                                  Icon(Icons.luggage_outlined),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Included: cabin bag,",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                "checked bag",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            ],
                                          ),
                                          Text(
                                            segment.noOfSeatAvailable == null
                                                ? ""
                                                : "${segment.noOfSeatAvailable} left at this price on Dtrips.com",
                                            style:
                                            const TextStyle(color: Colors.brown),
                                          )
                                        ],
                                      ),
                                    ),
                                    const Divider(),
                                  ],
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Rs.${double.parse((items.fare!.tax! + items.fare!.otherCharges! + items.fare!.baseFare! - items.fare!.discount!).toStringAsFixed(2))}",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              // showModalBottomSheet(
                                              //   context: context,
                                              //   builder:
                                              //       (BuildContext context) {
                                              //     return FlightPriceBreakdown(
                                              //       count: noOfAdult +
                                              //           noOfChild +
                                              //           noOfInfant,
                                              //       tickets: double.parse(items
                                              //           .fare!.publishedFare!
                                              //           .toStringAsFixed(2)),
                                              //       fare: double.parse(items
                                              //           .fare!.baseFare!
                                              //           .toStringAsFixed(2)),
                                              //       tax: double.parse(items
                                              //           .fare!.tax!
                                              //           .toStringAsFixed(
                                              //           2)) +
                                              //           double.parse(items
                                              //               .fare!.otherCharges!
                                              //               .toStringAsFixed(
                                              //               2)),
                                              //       discount:
                                              //       items.fare!.discount,
                                              //       totalPrice: double.parse((items
                                              //           .fare!.tax! +
                                              //           items.fare!
                                              //               .otherCharges! +
                                              //           items.fare!
                                              //               .baseFare! -
                                              //           items.fare!
                                              //               .discount!)
                                              //           .toStringAsFixed(2)),
                                              //     );
                                              //   },
                                              // );
                                            },
                                            child: const Icon(
                                              Icons.info_outline,
                                              size: 18,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Rs. ${double.parse(((items.fare!.tax! + items.fare!.otherCharges! + items.fare!.baseFare! - items.fare!.discount!) * (noOfAdult + noOfChild + noOfInfant)).toStringAsFixed(2))} for all travellers", //price * number of travellers
                                        style: const TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      thickness: 10,
                      color: Colors.grey[200],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  void search() async {

    if (kDebugMode) {
      print("search");
    }
try{
  final response = await http.post(
    Uri.parse('${api}api/flight/search'),
    body: jsonEncode({
      "EndUserIp": "$ip",
      // "TokenId": "02651000-5593-43cc-ac84-5147ecb90ca3",
      "AdultCount": "$noOfAdult",
      "ChildCount": "$noOfChild",
      "InfantCount": "$noOfInfant",
      "DirectFlight": "false",
      "OneStopFlight": "false",
      "JourneyType": "1",
      "PreferredAirlines": null,
      "Segments": segments,
      "Sources": null
    }),
    headers: {"content-type": "application/json"},
  );

  if (kDebugMode) {
    print(response.statusCode);
    log(response.body);
  }


  if (response.statusCode == 200) {
    final result = newSearchModelFromJson(response.body);

    setState(() {
      loading = false;
    });

    if (result.response!.error!.errorCode != 0) {
      _showAlertDialog('${result.response!.error!.errorCode}','${result.response!.error!.errorMessage}');
    }

    setState(() {
      traceId = result.response!.traceId!;
      token = result.token!;

      resultLength = result.response!.results![0].length;
      flightResult = result.response!.results![0];
      // flightResult.addAll(result.response!.results as Iterable<Result>);

    });
  }



}catch(e){
      if (kDebugMode) {
        print(e);
      }
}



  }


  void _showAlertDialog(String message, String content) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(message,
            style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }
}
