import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/lcc_booked_page.dart';
import 'package:http/http.dart' as http;
import 'SeatSelection.dart';
import 'global.dart';
import 'models/lccBookModel.dart';

class FlightCustomisePageWithLCC extends StatefulWidget {
  const FlightCustomisePageWithLCC({
    Key? key,
    this.ResultIndex,
    this.TraceId,
    this.Token,
    required this.IsPanRequiredAtBook,
    required this.IsPanRequiredAtTicket,
    required this.IsPassportRequiredAtBook,
    required this.IsPassportRequiredAtTicket,
    required this.fare,
  }) : super(key: key);
  final ResultIndex;
  final TraceId;
  final Token;
  final bool IsPanRequiredAtBook;
  final bool IsPanRequiredAtTicket;
  final bool IsPassportRequiredAtBook;
  final bool IsPassportRequiredAtTicket;
  final fare ;

  @override
  _FlightCustomisePageWithLCCState createState() =>
      _FlightCustomisePageWithLCCState();
}

class _FlightCustomisePageWithLCCState extends State<FlightCustomisePageWithLCC>
    with WidgetsBindingObserver {

  final PageController pageController = PageController(initialPage: 0);

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool bookLoading = false;
  int page = 0;

  @override
  void initState() {
    super.initState();
    handleData();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Trigger a rebuild when the page gains focus
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if(bookLoading){
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }else{
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: const Text(
            "Customize Flight",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          leading: IconButton(
            tooltip: 'back',
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              if (pageController.page == 0) {
                setState(() {
                  page = 0;
                });
                Navigator.pop(context);
                print("go back");
              } else {
                setState(() {
                  setState(() {
                    page = page--;
                  });
                  pageController.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.linear);
                });
              }
            },
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
                          print(pageController.page);
                          print(passengerDetails[0]['Title']);
                          print(passengerDetails);
                          // showModalBottomSheet(
                          //   context: context,
                          //   builder: (BuildContext context) {
                          //     return Container(
                          //       margin: const EdgeInsets.all(10.0),
                          //       child: Wrap(
                          //         children: <Widget>[
                          //           Center(
                          //               child: Container(
                          //             height: 4.0,
                          //             width: 50.0,
                          //             color: Colors.grey[800],
                          //           )),
                          //           const SizedBox(
                          //             height: 10.0,
                          //           ),
                          //           Padding(
                          //             padding: const EdgeInsets.only(
                          //                 top: 10,
                          //                 bottom: 20,
                          //                 left: 10,
                          //                 right: 10),
                          //             child: Column(
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.start,
                          //               children: [
                          //                 const Padding(
                          //                   padding: EdgeInsets.only(
                          //                       top: 20, bottom: 20),
                          //                   child: Text(
                          //                     "Price breakdown",
                          //                     style: TextStyle(
                          //                         fontSize: 18,
                          //                         fontWeight: FontWeight.bold),
                          //                   ),
                          //                 ),
                          //                 Padding(
                          //                   padding: const EdgeInsets.only(
                          //                       top: 5, bottom: 5),
                          //                   child: Row(
                          //                     mainAxisAlignment:
                          //                         MainAxisAlignment.spaceBetween,
                          //                     children: [
                          //                       const Text(
                          //                         "Tickets (1 adult)",
                          //                         style: TextStyle(
                          //                             fontSize: 14,
                          //                             fontWeight:
                          //                                 FontWeight.w500),
                          //                       ),
                          //                       Text(
                          //                         "Rs. ${double.parse(flightDetails[0].fare!.publishedFare!.toStringAsFixed(2))}",
                          //                         style: const TextStyle(
                          //                             fontSize: 14,
                          //                             fontWeight:
                          //                                 FontWeight.w500),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 ),
                          //                 Padding(
                          //                   padding: const EdgeInsets.only(
                          //                       top: 5, bottom: 5),
                          //                   child: Row(
                          //                     mainAxisAlignment:
                          //                         MainAxisAlignment.spaceBetween,
                          //                     children: [
                          //                       const Text(
                          //                         "Flight fare",
                          //                         style: TextStyle(
                          //                             fontSize: 12,
                          //                             color: Colors.grey),
                          //                       ),
                          //                       Text(
                          //                         "Rs. ${double.parse(flightDetails[0].fare!.baseFare!.toStringAsFixed(2))}",
                          //                         style: const TextStyle(
                          //                             fontSize: 12,
                          //                             color: Colors.grey),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 ),
                          //                 Padding(
                          //                   padding: const EdgeInsets.only(
                          //                       top: 5, bottom: 5),
                          //                   child: Row(
                          //                     mainAxisAlignment:
                          //                         MainAxisAlignment.spaceBetween,
                          //                     children: [
                          //                       const Text(
                          //                         "Taxes and charges",
                          //                         style: TextStyle(
                          //                             fontSize: 12,
                          //                             color: Colors.grey),
                          //                       ),
                          //                       Text(
                          //                         "Rs. ${double.parse(flightDetails[0].fare!.tax!.toStringAsFixed(2)) + double.parse(flightDetails[0].fare!.otherCharges!.toStringAsFixed(2))}",
                          //                         style: const TextStyle(
                          //                             fontSize: 12,
                          //                             color: Colors.grey),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 ),
                          //                 Padding(
                          //                   padding: const EdgeInsets.only(
                          //                       top: 5, bottom: 5),
                          //                   child: Row(
                          //                     mainAxisAlignment:
                          //                         MainAxisAlignment.spaceBetween,
                          //                     children: [
                          //                       const Text(
                          //                         "Discount",
                          //                         style: TextStyle(
                          //                             fontSize: 12,
                          //                             color: Colors.grey),
                          //                       ),
                          //                       Text(
                          //                         "Rs. -${flightDetails[0].fare!.discount}",
                          //                         style: const TextStyle(
                          //                             fontSize: 12,
                          //                             color: Colors.grey),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 ),
                          //                 Padding(
                          //                   padding: const EdgeInsets.only(
                          //                       top: 20, bottom: 5),
                          //                   child: Row(
                          //                     mainAxisAlignment:
                          //                         MainAxisAlignment.spaceBetween,
                          //                     children: [
                          //                       const Text(
                          //                         "Total price",
                          //                         style: TextStyle(
                          //                             fontSize: 18,
                          //                             fontWeight:
                          //                                 FontWeight.bold),
                          //                       ),
                          //                       Text(
                          //                         "Rs. ${double.parse((flightDetails[0].fare!.tax! + flightDetails[0].fare!.otherCharges! + flightDetails[0].fare!.baseFare! - flightDetails[0].fare!.discount!).toStringAsFixed(2))}",
                          //                         style: const TextStyle(
                          //                             fontSize: 18,
                          //                             fontWeight:
                          //                                 FontWeight.bold),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 ),
                          //                 const Row(
                          //                   children: [
                          //                     Text(
                          //                       "includes taxes and charges",
                          //                       style: TextStyle(
                          //                           fontSize: 12,
                          //                           color: Colors.grey),
                          //                     )
                          //                   ],
                          //                 )
                          //               ],
                          //             ),
                          //           )
                          //         ],
                          //       ),
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
                  Text(
                      "${noOfAdult + noOfChild + noOfInfant} traveller"),
                ],
              ),

              ElevatedButton(
                onPressed: () {
                  if (ssr) {
                    if (pageController.page == 1) {
                      ticket();
                    } else {
                      setState(() {
                        pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.linear,
                        );
                        page = page + 1;
                      });
                    }
                  } else {
                    setState(() {
                      pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.linear,
                      );
                      page = page + 1;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    page == 1 ? "Book" : "Next",
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
        body: WillPopScope(
          onWillPop: () async {
            print(pageController.page);
            if (pageController.page == 0) {
              Navigator.pop(context);
              return true;
            } else {
              setState(() {
                pageController.previousPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.linear,
                );
                page = page - 1;
              });
              return false;
            }
          },
          child: SafeArea(
            child: PageView(
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                //tab 1 baggage and meals

                if (ssr)
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (LccBaggage.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  print(lcc);
                                  print(LccBaggage.length);
                                  print(LccBaggage);
                                },
                                child: Text(
                                  "Baggage",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          if (LccBaggage.isNotEmpty)
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: LccBaggage.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    Text(
                                      "Flight To: ${LccBaggage[index].origin}",
                                      style: TextStyle(
                                          fontSize: 16,fontWeight: FontWeight.bold),
                                    ),
                                    ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: passengerDetails.length,
                                        itemBuilder: (BuildContext context, int ind) {
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, top: 10),
                                                child: Text(
                                                  "Traveller ${index + 1} (Adult)",
                                                  style: TextStyle(color: Colors.purple),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width, // Set the width to device width
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 10.0),
                                                child: InputDecorator(
                                                  decoration: InputDecoration(
                                                    enabledBorder: UnderlineInputBorder(
                                                      borderSide:
                                                      BorderSide(color: Colors.purple),
                                                    ),
                                                  ),
                                                  child: DropdownButton<dynamic>(
                                                    value: selectedOption,
                                                    onChanged: (newValue) {
                                                      List Baggage = [];

                                                      setState(() {
                                                        selectedOption = newValue;
                                                        Baggage = [
                                                          selectedOption?.toJson()
                                                        ];
                                                        // passengerDetails[index]['Baggage'] = Baggage;
                                                        passengerDetails[index]['Baggage']
                                                            .insert(index,
                                                            selectedOption?.toJson());
                                                        // print(selectedOption?.toJson());
                                                        print(passengerDetails[index]
                                                        ['Baggage']);
                                                      });
                                                    },
                                                    isExpanded: true,
                                                    underline:
                                                    Container(), // Remove the default underline
                                                    items: LccBaggage.map<
                                                        DropdownMenuItem<dynamic>>(
                                                          (option) {
                                                        return DropdownMenuItem<dynamic>(
                                                          value: option,
                                                          child: Text(
                                                              'Weight: ${option.weight} KG, Price: ₹${option.price}'),
                                                        );
                                                      },
                                                    ).toList(),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                    ),
                                  ],
                                );
                              },
                            ),
                          SizedBox(
                            height: 15,
                          ),
                          if (mealItems.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  // log(res);
                                  print(LccBaggage);
                                },
                                child: Text(
                                  "Meal choice",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          if (mealItems.isNotEmpty)
                            Text(
                              "Request dietary preferences",
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          SizedBox(
                            height: 10,
                          ),
                          if (mealItems.isNotEmpty)
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: mealItems.length,
                              itemBuilder: (BuildContext context, int ind) {
                                return Column(
                                  children: [
                                    Text(
                                      "Flight To: ${mealItems[ind].origin}",
                                      style: TextStyle(
                                          fontSize: 16,fontWeight: FontWeight.bold),
                                    ),
                                    ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: passengerDetails.length,
                                        itemBuilder:(BuildContext context, int index) {
                                          return Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, top: 10),
                                                child: Text(
                                                  "Traveller ${index + 1} (Adult)",
                                                  style:
                                                  TextStyle(color: Colors.purple),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width, // Set the width to device width
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 16.0),
                                                child: DropdownButton<dynamic>(
                                                  value: selectedMeal,
                                                  onChanged: (newValue) {
                                                    List Meal = [];
                                                    setState(() {
                                                      selectedMeal = newValue!;
                                                      Meal = [selectedMeal?.toJson()];
                                                      // passengerDetails[index]['MealDynamic'] = Meal;
                                                      passengerDetails[index]
                                                      ['MealDynamic']
                                                          .insert(index,
                                                          selectedMeal?.toJson());

                                                      // print(selectedMeal?.toJson());
                                                      print(passengerDetails[index]
                                                      ['MealDynamic']);
                                                    });
                                                  },
                                                  isExpanded: true,
                                                  items: mealItems
                                                      .map<DropdownMenuItem<dynamic>>(
                                                          (value) {
                                                        return DropdownMenuItem<dynamic>(
                                                          value: value,
                                                          child: Text(
                                                              "${value.airlineDescription} (${value.code})"),
                                                        );
                                                      }).toList(),
                                                ),
                                              )
                                            ],
                                          );
                                        }),
                                  ],
                                );
                              },
                            ),
                          SizedBox(
                            height: 30,
                          ),
                          if (specialServices!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  // log(res);
                                  print(LccBaggage);
                                },
                                child: Text(
                                  "Special services",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          SizedBox(
                            height: 10,
                          ),
                          if (specialServices!.isNotEmpty)
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: specialServices!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: specialServices![index]
                                        .segmentSpecialService!
                                        .length,
                                    itemBuilder: (BuildContext context, int ind) {
                                      return ListView.builder(
                                          physics: NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: specialServices![index]
                                              .segmentSpecialService![ind]
                                              .ssrService!
                                              .length,
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            return Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Flight To: ${specialServices![index].segmentSpecialService![ind].ssrService![i].origin}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .sentiment_satisfied_rounded,
                                                      size: 16,
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          left: 20),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            "${specialServices![index].segmentSpecialService![ind].ssrService![i].text}",
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          ),
                                                          Text(
                                                            "${specialServices![index].segmentSpecialService![ind].ssrService![i].currency}. ${specialServices![index].segmentSpecialService![ind].ssrService![i].price}",
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            );
                                          });
                                    });
                              },
                            ),
                        ],
                      ),
                    ),
                  ),

                //tab 2  seat selection and details
                SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: passengerDetails.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder:
                              (BuildContext context, int passengerIndex) {
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: FlightSeats.length,
                              itemBuilder: (BuildContext context, int index) {
                                var segment = selectedItem.segments![0][index];

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          print(FlightSeats[index]['RowSeats'][0]
                                          ['Seats'][0]['Origin']);
                                          print(FlightSeats[index]['RowSeats'][0]
                                          ['Seats'][0]['Destination']);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SeatSelectionPage(
                                                      origin: FlightSeats[index]
                                                      ['RowSeats'][0]
                                                      ['Seats'][0]['Origin'],
                                                      destination:
                                                      FlightSeats[index]
                                                      ['RowSeats']
                                                      [0]['Seats'][0]
                                                      ['Destination'],
                                                      index: index,
                                                      passengerIndex:
                                                      passengerIndex,
                                                    )),
                                          ).then((updatedSeatData) {
                                            print(updatedSeatData);

                                            if (updatedSeatData != null) {
                                              // passengerDetails[index]['SeatDynamic'].insert(index, updatedSeatData);
                                            }
                                            setState(() {});
                                          });
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          color: Colors.white,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets.fromLTRB(
                                                    8, 20, 8, 20),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                            Icons.flight_takeoff),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          "${FlightSeats[index]['RowSeats'][0]['Seats'][0]['Origin']}",
                                                          style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Icon(Icons
                                                            .arrow_right_alt),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Icon(Icons.flight_land),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          "${FlightSeats[index]['RowSeats'][0]['Seats'][0]['Destination']}",
                                                          style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "${formatDuration(segment.duration!)} - ${segment.airline!.airlineName}",
                                                          style: TextStyle(),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          passengerDetails[
                                                          passengerIndex]
                                                          [
                                                          'SeatDynamic'][index]['Code'] == ''

                                                              ? "No seats selected"
                                                              : "Seat: ${passengerDetails[passengerIndex]['SeatDynamic'][index]['Code']}, Price: ${passengerDetails[passengerIndex]['SeatDynamic'][index]['Price']}",
                                                          style: TextStyle(),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }),

                      // SizedBox(height: 50,),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: passengerDetails.length,
                          itemBuilder: (BuildContext context, int index) {
                            //var segment = selectedItem.segments![0][index];
                            var _selectedDate;

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: double.infinity,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFA6A6A6)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Adult ${index + 1}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "*",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red),
                                          ),
                                          Text(
                                            "Required",
                                            style:
                                            TextStyle(color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                      FittedBox(
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Radio(
                                                  value: "Mr",
                                                  groupValue:
                                                  passengerDetails[index]
                                                  ['Title'],
                                                  onChanged: (value) {
                                                    // print(value);
                                                    setState(() {
                                                      // selectedValue = value.toString();
                                                      passengerDetails[index]
                                                      ['Title'] =
                                                          value.toString();
                                                    });
                                                  },
                                                ),
                                                const Text("Mr.")
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: "Mrs",
                                                  groupValue:
                                                  passengerDetails[index]
                                                  ['Title'],
                                                  onChanged: (value) {
                                                    // print(value);
                                                    setState(() {
                                                      passengerDetails[index]
                                                      ['Title'] =
                                                          value.toString();
                                                    });
                                                  },
                                                ),
                                                const Text("Mrs.")
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 50,
                                        color: const Color(0x1292278f),
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              // labelText: 'First Name',
                                              label: FittedBox(
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "* ",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 18),
                                                    ),
                                                    Text(
                                                      "First Name",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              labelStyle:
                                              TextStyle(color: Colors.black)),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {}
                                            return null;
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              passengerDetails[index]
                                              ['FirstName'] =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 50,
                                        color: const Color(0x1292278f),
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              // labelText: 'First Name',
                                              label: FittedBox(
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "* ",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 18),
                                                    ),
                                                    Text(
                                                      "Last Name",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              labelStyle:
                                              TextStyle(color: Colors.black)),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {}
                                            return null;
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              passengerDetails[index]
                                              ['LastName'] = value.toString();
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 150,
                                            color: const Color(0x1292278f),
                                            child:
                                            DropdownButtonFormField<String>(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                label: FittedBox(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "* ",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 18),
                                                      ),
                                                      Text(
                                                        "Gender",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                labelStyle: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              items: [
                                                DropdownMenuItem(
                                                  value: '1',
                                                  child: Text('Male'),
                                                ),
                                                DropdownMenuItem(
                                                  value: '2',
                                                  child: Text('Female'),
                                                ),
                                              ],
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please select a gender';
                                                }
                                                return null;
                                              },
                                              onChanged: (value) {
                                                setState(() {
                                                  // Handle the selected value
                                                  passengerDetails[index]
                                                  ['Gender'] =
                                                      int.parse(value.toString());
                                                });
                                              },
                                            ),
                                          ),
                                          Container(
                                            width: 150,
                                            color: const Color(0x1292278f),
                                            child: InkWell(
                                              onTap: () async {
                                                //_selectDate(context); // Function to open the date picker

                                                final DateTime? picked =
                                                await showDatePicker(
                                                  context: context,
                                                  initialDate: _selectedDate ??
                                                      DateTime.now(),
                                                  firstDate: DateTime(1900),
                                                  lastDate: DateTime.now(),
                                                );

                                                if (picked != null &&
                                                    picked != _selectedDate) {
                                                  setState(() {
                                                    _selectedDate = picked;
                                                    passengerDetails[index]
                                                    ['DateOfBirth'] =
                                                        DateFormat('yyyy-MM-dd')
                                                            .format(picked)
                                                            .toString();
                                                  });
                                                }
                                              },
                                              child: InputDecorator(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  label: FittedBox(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                          "* ",
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 18),
                                                        ),
                                                        Text(
                                                          "Date of Birth",
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                child: Text(
                                                  passengerDetails[index]
                                                  ['DateOfBirth'] ??
                                                      'Select Date of Birth',
                                                  style: TextStyle(
                                                      color: passengerDetails[
                                                      index][
                                                      'DateOfBirth'] !=
                                                          null
                                                          ? Colors.black
                                                          : Colors.grey),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 50,
                                        color: const Color(0x1292278f),
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              // labelText: 'First Name',
                                              label: FittedBox(
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "* ",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 18),
                                                    ),
                                                    Text(
                                                      "City",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              labelStyle:
                                              TextStyle(color: Colors.black)),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {}
                                            return null;
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              passengerDetails[index]['City'] =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 50,
                                        color: const Color(0x1292278f),
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              // labelText: 'First Name',
                                              label: FittedBox(
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "* ",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 18),
                                                    ),
                                                    Text(
                                                      "Email",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              labelStyle:
                                              TextStyle(color: Colors.black)),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {}
                                            return null;
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              passengerDetails[index]['Email'] =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 50,
                                        color: const Color(0x1292278f),
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              // labelText: 'First Name',
                                              label: FittedBox(
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "* ",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 18),
                                                    ),
                                                    Text(
                                                      "Address",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              labelStyle:
                                              TextStyle(color: Colors.black)),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {}
                                            return null;
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              passengerDetails[index]
                                              ['AddressLine1'] =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 50,
                                        color: const Color(0x1292278f),
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              // labelText: 'First Name',
                                              label: FittedBox(
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "* ",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 18),
                                                    ),
                                                    Text(
                                                      "Phone",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              labelStyle:
                                              TextStyle(color: Colors.black)),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {}
                                            return null;
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              passengerDetails[index]
                                              ['ContactNo'] =
                                                  value.toString();
                                            });
                                          },
                                        ),
                                      ),
                                      // SizedBox(
                                      //   height: 10,
                                      // ),
                                      // if(widget.IsPanRequiredAtTicket || widget.IsPanRequiredAtBook)
                                      // Container(
                                      //   height: 50,
                                      //   color: const Color(0x1292278f),
                                      //   child: TextFormField(
                                      //     decoration: const InputDecoration(
                                      //         border: OutlineInputBorder(),
                                      //         // labelText: 'First Name',
                                      //         label: FittedBox(
                                      //           child: Row(
                                      //             mainAxisAlignment:
                                      //             MainAxisAlignment.start,
                                      //             crossAxisAlignment:
                                      //             CrossAxisAlignment.start,
                                      //             children: [
                                      //               Text(
                                      //                 "* ",
                                      //                 style: TextStyle(
                                      //                     color: Colors.red,
                                      //                     fontSize: 18),
                                      //               ),
                                      //               Text(
                                      //                 "Pan",
                                      //                 style: TextStyle(
                                      //                     color: Colors.black,
                                      //                     fontSize: 14),
                                      //               ),
                                      //             ],
                                      //           ),
                                      //         ),
                                      //         labelStyle:
                                      //         TextStyle(color: Colors.black)),
                                      //     validator: (value) {
                                      //       if (value == null || value.isEmpty) {}
                                      //       return null;
                                      //     },
                                      //     onChanged: (value) {
                                      //       setState(() {
                                      //         passengerDetails[index]['Pan'] = value.toString();
                                      //       });
                                      //     },
                                      //   ),
                                      // ),
                                      SizedBox(
                                        height: 10,
                                      ),

                                      if (widget.IsPassportRequiredAtTicket ||
                                          widget.IsPassportRequiredAtBook)
                                        Container(
                                          height: 50,
                                          color: const Color(0x1292278f),
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                // labelText: 'First Name',
                                                label: FittedBox(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "* ",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 18),
                                                      ),
                                                      Text(
                                                        "Passport",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                labelStyle: TextStyle(
                                                    color: Colors.black)),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {}
                                              return null;
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                passengerDetails[index]
                                                ['PassportNo'] =
                                                    value.toString();
                                              });
                                            },
                                          ),
                                        ),
                                      if (widget.IsPassportRequiredAtTicket ||
                                          widget.IsPassportRequiredAtBook)
                                        SizedBox(
                                          height: 10,
                                        ),
                                      if (widget.IsPassportRequiredAtTicket ||
                                          widget.IsPassportRequiredAtBook)
                                        Container(
                                          // width: 150,
                                          color: const Color(0x1292278f),
                                          child: InkWell(
                                            onTap: () async {
                                              //_selectDate(context); // Function to open the date picker

                                              final DateTime? picked =
                                              await showDatePicker(
                                                context: context,
                                                initialDate: _selectedDate ??
                                                    DateTime.now(),
                                                firstDate: DateTime(1900),
                                                lastDate: DateTime.now(),
                                              );

                                              if (picked != null &&
                                                  picked != _selectedDate) {
                                                setState(() {
                                                  _selectedDate = picked;
                                                  passengerDetails[index]
                                                  ['PassportExpiry'] =
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(picked)
                                                          .toString();
                                                });
                                              }
                                            },
                                            child: InputDecorator(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                label: FittedBox(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "* ",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 18),
                                                      ),
                                                      Text(
                                                        "Passport Expiry",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                labelStyle: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              child: Text(
                                                passengerDetails[index]
                                                ['PassportExpiry'] ??
                                                    'Select Passport Expiry Date',
                                                style: TextStyle(
                                                    color: passengerDetails[index]
                                                    [
                                                    'PassportExpiry'] !=
                                                        null
                                                        ? Colors.black
                                                        : Colors.grey),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),

                //tab 3 overview and book
                // SingleChildScrollView(
                //   child: Column(
                //     children: [
                //
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      );
    }
  }

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: _selectedDate ?? DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //   );
  //
  //   if (picked != null && picked != _selectedDate) {
  //     setState(() {
  //       _selectedDate = picked;
  //
  //     });
  //   }
  // }

  String formatDuration(int duration) {
    int hours = duration ~/ 60;
    int minutes = duration % 60;

    String formattedHours = hours.toString().padLeft(2, '0');
    String formattedMinutes = minutes.toString().padLeft(2, '0');

    return '$formattedHours h $formattedMinutes m';
  }

  ticket() async {
//  api/flight/book
try{
  setState(() {
    bookLoading = true;
  });
  var bookingData = {
    "ResultIndex": widget.ResultIndex,
    "EndUserIp": "103.182.166.134",
    "TokenId": widget.Token,
    "TraceId": widget.TraceId,
    "Passengers": passengerDetails,
    "login": false,
    "IsLcc": true,
  };

  final response = await http.post(
    Uri.parse('${api}api/flight/book'),
    body: jsonEncode(bookingData),
    headers: {"content-type": "application/json"},
  );

  print("Ticket");
  print(response.statusCode);
  print(response.body);

  if (response.statusCode == 200) {
    try{
      
      final bookedData = lccBookModelFromJson(response.body);
      if (bookedData.response!.error!.errorCode == 0) {

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LccBookedPage(bookedData: response.body,)),
        );

      }  
      
      setState(() {
        bookLoading = false;
        page = 0;
      });
      
    }catch(e){
      print("error on 200: $e");
      setState(() {
        bookLoading = false;
        page = 0;
      });
      showDialog<void>(
            context: context,
            barrierDismissible: false,
            // false = user must tap button, true = tap outside dialog
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: Text('Booking Failed!'),
                content: Text('${response.body}'),
                actions: <Widget>[
                  TextButton(
                    child: Text('ok'),
                    onPressed: () {
                      Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                    },
                  ),
                ],
              );
            },
          );
        }
   
  }else{
    setState(() {
      bookLoading = false;
    });
  }

}catch(e){
  print("Ticket error: $e");
  setState(() {
    bookLoading = false;
  });
}


  }

  void handleData() {
    setState(() {
      passengerDetails.clear();
    });
    List seats = [];
    for (int j = 0; j < FlightSeats.length; j++) {
      List seat = [
        {
          "AirlineCode": "",
          "FlightNumber": "",
          "CraftType": "",
          "Origin": "",
          "Destination": "",
          "AvailablityType": "",
          "Description": "",
          "Code": "",
          "RowNo": "",
          "SeatNo": "",
          "SeatType": "",
          "SeatWayType": "",
          "Compartment": "",
          "Deck": "",
          "Currency": "",
          "Price": ""
        }
      ];
      seats.add(seat.first);
    }

    for (int i = 0; i < noOfAdult + noOfChild + noOfInfant; i++) {
      var data = {
        "Title": 'Mr',
        "FirstName": '',
        "LastName": '',
        "PaxType": 1,
        "DateOfBirth": '',
        "Gender": 1,
        "PassportNo": '',
        "PassportExpiry": '',
        "AddressLine1": '',
        "AddressLine2": '',
        "City": '',
        "CountryCode": '',
        "CountryName": '',
        "Nationality": '',
        "ContactNo": '',
        "Email": '',
        "IsLeadPax": true,
        "Fare": widget.fare,
        "Baggage": [],
        "MealDynamic": [],
        "SeatDynamic": seats,
      };
      passengerDetails.add(data);
    }
  }
}
