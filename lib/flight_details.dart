import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:timelines/timelines.dart';
import 'flight_customise_page_with_lcc.dart';
import 'flight_customise_page_with_no_lcc.dart';
import 'global.dart';
import 'models/fareQuoteModel.dart';
import 'models/fareRuleModel.dart';
import 'models/lccWithSSR.dart';
import 'models/nonLccSSRWithoutSeat.dart';
import 'models/nonLccSSRwithSeat.dart';
import 'nonLccSsrMealWithOutSeat.dart';

class FlightDetails extends StatefulWidget {
  const FlightDetails({Key? key, this.ResultIndex, this.TraceId, this.Token}) : super(key: key);
  final ResultIndex;
  final TraceId;
  final Token;

  @override
  _FlightDetailsState createState() => _FlightDetailsState();
}

class _FlightDetailsState extends State<FlightDetails> {
  var xmlString = "";
  var DestinationCityName = "";
  var DestinationCountryName = "";

  bool isLoading = true;

  @override
  void initState() {
    ClickLoading = false;
    getFareRule(widget.ResultIndex, widget.TraceId, widget.Token);
    getFareQuote(widget.ResultIndex, widget.TraceId, widget.Token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: IconButton(
          tooltip: 'back',
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () async {
            Navigator.pop(context);
            await Future.delayed(const Duration(seconds: 2));
            flightDetails.clear();
          },
        ),
        title: const Text(
          "Your flight to Dublin",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Rs. ${double.parse((flightDetails[0].fare!.tax! + flightDetails[0].fare!.otherCharges! + flightDetails[0].fare!.baseFare! - flightDetails[0].fare!.discount!).toStringAsFixed(2))}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              margin: const EdgeInsets.all(10.0),
                              child: Wrap(
                                children: <Widget>[
                                  Center(
                                      child: Container(
                                        height: 4.0,
                                        width: 50.0,
                                        color: Colors.grey[800],
                                      )),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 20,
                                        left: 10,
                                        right: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 20, bottom: 20),
                                          child: Text(
                                            "Price breakdown",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Tickets (1 adult)",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                    FontWeight.w500),
                                              ),
                                              Text(
                                                "Rs. ${double.parse(flightDetails[0].fare!.publishedFare!.toStringAsFixed(2))}",
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                    FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Flight fare",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                "Rs. ${double.parse(flightDetails[0].fare!.baseFare!.toStringAsFixed(2))}",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Taxes and charges",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                "Rs. ${double.parse(flightDetails[0].fare!.tax!.toStringAsFixed(2)) + double.parse(flightDetails[0].fare!.otherCharges!.toStringAsFixed(2))}",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Discount",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                "Rs. -${flightDetails[0].fare!.discount}",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Total price",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              Text(
                                                "Rs. ${double.parse((flightDetails[0].fare!.tax! + flightDetails[0].fare!.otherCharges! + flightDetails[0].fare!.baseFare! - flightDetails[0].fare!.discount!).toStringAsFixed(2))}",
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Row(
                                          children: [
                                            Text(
                                              "includes taxes and charges",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: const Icon(
                        Icons.info_outline,
                        size: 18,
                      ),
                    )
                  ],
                ),
                Text("${noOfAdult + noOfChild + noOfInfant} traveller")
              ],
            ),
            ElevatedButton(
              onPressed: () {
                print(lcc);
                if(lcc){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FlightCustomisePageWithLCC(
                          ResultIndex: widget.ResultIndex,
                          TraceId: widget.TraceId,
                          Token: widget.Token,
                        )),
                  );
                }else{
                  print("lcc: $lcc");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FlightCustomisePageWithNoLCC(
                          ResultIndex: widget.ResultIndex,
                          TraceId: widget.TraceId,
                          Token: widget.Token,
                        )),
                  );
                }

              },
              style: ElevatedButton.styleFrom(
                // padding: const EdgeInsets.symmetric(
                // horizontal: 40.0, vertical: 20.0),
                backgroundColor: Colors.purple,
                // shadowColor: Colors.transparent,
                // shape: const StadiumBorder(),
              ),
              child: isLoading
                  ? Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    height: 20,
                    width: 20,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    )),
              )
                  : const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Select",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Metropolis',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: flightDetails[0].segments![0].length,
              itemBuilder: (BuildContext context, int index) {
                final items = flightDetails[0];

                var segment = items.segments![0][index];

                String formatDuration(int duration) {
                  int hours = duration ~/ 60;
                  int minutes = duration % 60;

                  String formattedHours = hours.toString().padLeft(2, '0');
                  String formattedMinutes =
                  minutes.toString().padLeft(2, '0');

                  return '$formattedHours h $formattedMinutes m';
                }

                DestinationCityName = segment.destination!.airport!.cityName!;
                DestinationCountryName =
                segment.destination!.airport!.countryName!;

                List<String> _cabinClassOptions = [
                  'All',
                  'Economy',
                  'Premium economy',
                  'Business',
                  'Premium Business',
                  'First class',
                ];

                var cabinName = _cabinClassOptions[segment.cabinClass!];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Flight to ${segment.destination!.airport!.cityName}",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              "${formatDuration(segment.duration!)}, ${cabinName}"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const OutlinedDotIndicator(
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                      "${DateFormat('E dd MMM, HH:mm').format(segment.origin!.depTime!)}") //Sat 03 Jun, 03:55
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 6, top: 8, bottom: 8),
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                        height: 180,
                                        child: DashedLineConnector(
                                          color: Colors.grey,
                                          dash: 5,
                                        )),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [

                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 25),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "${segment.origin!.airport!.airportCode}, ${segment.origin!.airport!.cityName}",
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                  "${segment.origin!.airport!.airportName}"),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(segment.origin!.airport!
                                                  .terminal ==
                                                  null
                                                  ? ""
                                                  : "Terminal: ${segment.origin!.airport!.terminal}"),
                                            ],
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, top: 30, bottom: 10),
                                          child: Row(
                                            children: [
                                              const Icon(Icons.flight),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${segment.airline!.airlineName}",
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey),
                                                  ),
                                                  Text(
                                                    "Flight: ${segment.airline!.airlineCode} ${segment.airline!.flightNumber}",
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey),
                                                  ),
                                                  Text(
                                                    "Flight time: ${formatDuration(segment.duration!)}",
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),

                              Row(
                                children: [
                                  const OutlinedDotIndicator(
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                      "${DateFormat('E dd MMM, HH:mm').format(DateTime.parse(segment.destination!.arrTime.toString()))}")
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${segment.destination!.airport!.airportCode}, ${segment.destination!.airport!.cityName}",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                        "${segment.destination!.airport!.airportName}"),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(segment.destination!.airport!
                                        .terminal ==
                                        null
                                        ? ""
                                        : "Terminal: ${segment.destination!.airport!.terminal}"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Divider(),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                );
              },
            ),

            const Divider(
              color: Colors.black12,
              thickness: 10,
            ),

            ListTile(
                onTap: () {
                  print(NonLccMeal);
                  print(NonLccBaggage);

                  // if (xmlString == null || xmlString == "") {
                  //   //show error toast
                  //   Fluttertoast.showToast(
                  //       msg: "Loading failed",
                  //       toastLength: Toast.LENGTH_SHORT,
                  //       gravity: ToastGravity.CENTER,
                  //       timeInSecForIosWeb: 1,
                  //       backgroundColor: Colors.grey,
                  //       textColor: Colors.black,
                  //       fontSize: 16.0);
                  //
                  //   getFareRule(widget.ResultIndex, widget.TraceId, widget.Token);
                  // } else {
                  //   // Get.to(XMLContentWidget(xmlString));
                  // }
                },
                tileColor: Colors.white,
                leading: const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.flight_takeoff,
                    color: Colors.black,
                  ),
                ),
                title: Text(
                  "Check the fare rules and the COVID-19 travel restrictions for $DestinationCountryName",
                  maxLines: 5,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                )),

            const Divider(
              color: Colors.black12,
              thickness: 10,
            ),

            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Included baggage",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("The total baggage included in the price"),
            ),

            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: flightDetails[0].segments![0].length,
              itemBuilder: (BuildContext context, int index) {
                final items = flightDetails[0];

                var segment = items.segments![0][index];

                return Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Trip to ${segment.destination!.airport!.cityName}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        // Row(
                        //   children: [
                        //     Icon(
                        //       Icons.shopping_bag,
                        //     ),
                        //     Padding(
                        //       padding: const EdgeInsets.only(left: 20),
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Text(
                        //             "Personal item",
                        //             style: TextStyle(fontSize: 16),
                        //           ),
                        //           Text(
                        //             "Must go under the seat in front of you",
                        //             style: TextStyle(fontSize: 16),
                        //           ),
                        //           Text(
                        //             "Included",
                        //             style: TextStyle(
                        //                 fontSize: 16, color: Colors.green),
                        //           ),
                        //         ],
                        //       ),
                        //     )
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        Row(
                          children: [
                            const Icon(
                              Icons.luggage_outlined,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "cabin bag",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    segment.cabinBaggage == null
                                        ? "Up to 0 KG"
                                        : "Up to ${segment.cabinBaggage} each",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    segment.cabinBaggage == null
                                        ? "Not-Included"
                                        : "Included",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: segment.cabinBaggage == null
                                            ? Colors.red
                                            : Colors.green),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.luggage_outlined,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "checked bag",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    segment.baggage == null
                                        ? "Up to 0 KG"
                                        : "Max weight ${segment.baggage}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    segment.baggage == null
                                        ? "Not-Included"
                                        : "Included",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: segment.baggage == null
                                            ? Colors.red
                                            : Colors.green),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            ),

            const Divider(
              color: Colors.black12,
              thickness: 10,
            ),

          ],
        ),
      ),
      ),
    );
  }

  void getFareRule(resultIndex, traceId, token) async {

    final response = await http.post(
      Uri.parse('${api}api/flight/fare-rule'),
      body: jsonEncode({
        "EndUserIp": "$ip",
        "TokenId": "$token",
        "TraceId": "$traceId",
        "ResultIndex": "$resultIndex"
      }),
      headers: {"content-type": "application/json"},
    );

    // print(response.body);
    print('fare rule: ${response.statusCode}');

    if (response.statusCode == 200) {
      final result = fareRuleFromJson(response.body);

      try {
        setState(() {
          xmlString = result.response!.fareRules![0].fareRuleDetail!;
        });
      } catch (e) {
        setState(() {
          xmlString = "Something wrong!";
        });
        print(e);
      }
    } else {}
  }

  void getFareQuote(resultIndex, traceId, token) async {

    try {
      final response = await http.post(
        Uri.parse('${api}api/flight/fare-quote'),
        body: jsonEncode({
          "EndUserIp": ip,
          "TokenId": "$token",
          "TraceId": "$traceId",
          "ResultIndex": "$resultIndex"
        }),
        headers: {"content-type": "application/json"},
      );

      print("fare quote");
      print(response.statusCode);
      log('fare quote: ${response.body}');

      if (response.statusCode == 200) {
        final result = fareQuoteModelFromJson(response.body);
        try {
          print(result.response!.results!.isLcc!);
          // fareQuoteResult.add(result.response!.results);
          setState(() {
            LccBaggage.isNotEmpty ? LccBaggage.clear() : null;
            mealItems.isNotEmpty ? mealItems.clear() : null;
            specialServices!.isNotEmpty ? specialServices!.clear() : null;
            seatDynamic!.isNotEmpty ? seatDynamic!.clear() : null;

            NonLccBaggage.isNotEmpty ? NonLccBaggage.clear() : null;
            NonLccMeal.isNotEmpty ? NonLccMeal.clear() : null;




          });

          
        } catch (e) {
          setState(() {
            isLoading = false;
          });
          print("error: $e");
        }

        setState(() {
          isLoading = false;
          lcc = result.response!.results!.isLcc!;
        });
      }

      if (lcc) {
        getSSR(token, traceId, resultIndex);
      } else {
        getSSRWithoutLcc(token, traceId, resultIndex);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  void getSSR(token, traceId, resultIndex) async {
    print("lcc trueeeee: $lcc");

    final response = await http.post(
      Uri.parse(api + 'api/flight/ssr'),
      body: jsonEncode({
        "EndUserIp": "$ip",
        "TokenId": "$token",
        "TraceId": "$traceId",
        "ResultIndex": "$resultIndex"
      }),
      headers: {"content-type": "application/json"},
    );

    // log(response.body);
    log('ssr: ${response.body}');
    print(response.statusCode);



    if (response.body.contains("No SSR details found")) {
      setState(() {
        ssr = false;
      });
    }

    if (response.statusCode == 200) {
      getSeats(response.body);

      final lccResult = ssrWithLccModelFromJson(response.body);


      setState(() {
        LccBaggage = lccResult.response!.baggage![0];
        mealItems = lccResult.response!.mealDynamic![0];
        specialServices = lccResult.response!.specialServices;
        seatDynamic = lccResult.response!.seatDynamic;

        selectedOption = LccBaggage[0];
        selectedMeal = mealItems[0];
      });
    }
  }


  void getSeats(var body) {
// Parse the JSON string
    setState(() {
      if (FlightSeats.isNotEmpty) FlightSeats.clear();
    });

    var data = jsonDecode(body);

    // Extract seat information from SeatDynamic
    var seats = data['Response']['SeatDynamic'][0]['SegmentSeat'][0]['RowSeats']
    [1]['Seats'];
    var Rowseats = data['Response']['SeatDynamic'][0]['SegmentSeat'];

    for (var rowSeats in Rowseats) {
      // log(rowSeats.toString());
      FlightSeats.add(rowSeats);
    }

    // print(FlightSeats.length);

    // for (var flight in FlightSeats) {
    //   var rowSeats = flight["RowSeats"];
    //   for (var rowSeat in rowSeats) {
    //     var seats = rowSeat["Seats"];
    //     for (var seat in seats) {
    //       // print("Airline Code: ${seat["AirlineCode"]}");
    //       // print("Flight Number: ${seat["FlightNumber"]}");
    //       // print("Craft Type: ${seat["CraftType"]}");
    //       // print("Origin: ${seat["Origin"]}");
    //       // print("Destination: ${seat["Destination"]}");
    //       // print("Availability Type: ${seat["AvailablityType"]}");
    //       // print("Description: ${seat["Description"]}");
    //       print("Code: ${seat["Code"]}");
    //       print("Row No: ${seat["RowNo"]}");
    //       print("Seat No: ${seat["SeatNo"]}");
    //       // print("Seat Type: ${seat["SeatType"]}");
    //       // print("Seat Way Type: ${seat["SeatWayType"]}");
    //       // print("Compartment: ${seat["Compartment"]}");
    //       // print("Deck: ${seat["Deck"]}");
    //       // print("Currency: ${seat["Currency"]}");
    //       // print("Price: ${seat["Price"]}");
    //       // print("\n");
    //     }
    //   }
    // }
  }

  void getSSRWithoutLcc(token, traceId, resultIndex) async {
    print("lcc falseeee: $lcc");


    final response = await http.post(
      Uri.parse(api + 'api/flight/ssr'),
      body: jsonEncode({
        "EndUserIp": "$ip",
        "TokenId": "$token",
        "TraceId": "$traceId",
        "ResultIndex": "$resultIndex"
      }),
      headers: {"content-type": "application/json"},
    );

    // log(response.body);
    log('getSSRWithoutLcc: ${response.body}');
    print(response.statusCode);


    if (response.body.contains("No SSR details found")) {
      setState(() {
        ssr = false;
      });
    }
    else{
      if(response.body.contains('SeatDynamic')){
        try{

          var res = nonLccSsRwithSeatFromJson(response.body);

          NonLccBaggage.add(res.response!.baggage![0][0]);
          NonLccMeal.add(res.response!.meal![0]);
          print('added');

        }catch(e){
          print(e);
        }
      }else{
        try{

          var res = nonLccSsRwithoutSeatFromJson(response.body);
          nonLccMealWithoutSeat.add(res.response!.meal![0]);
          seatPreference.add(res.response!.seatPreference![0]);

        }catch(e){
          print(e);
        }
      }

    }
  }


}
