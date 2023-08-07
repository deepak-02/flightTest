import 'package:flutter/material.dart';

import 'global.dart';

class FlightCustomisePageWithLCC extends StatefulWidget {
  const FlightCustomisePageWithLCC({Key? key, this.ResultIndex, this.TraceId, this.Token}) : super(key: key);
  final ResultIndex;
  final TraceId;
  final Token;

  @override
  _FlightCustomisePageWithLCCState createState() =>
      _FlightCustomisePageWithLCCState();
}

class _FlightCustomisePageWithLCCState
    extends State<FlightCustomisePageWithLCC> {

  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: PageView(
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            //tab 1
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      width: 122,
                      color: Colors.red,
                    ),

                    if (LccBaggage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            print(lcc);
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
                        itemCount: noOfAdult,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 10, top: 10),
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
                                      setState(() {
                                        selectedOption = newValue;
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
                        itemCount: noOfAdult,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 10, top: 10),
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
                                    horizontal: 16.0),
                                child: DropdownButton<dynamic>(
                                  value: selectedMeal,
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedMeal = newValue!;
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

            //tab 2
            SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
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
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           SeatSelectionPage(
                                //             origin: FlightSeats[index]
                                //             ['RowSeats'][0]['Seats']
                                //             [0]['Origin'],
                                //             destination: FlightSeats[index]
                                //             ['RowSeats'][0]['Seats']
                                //             [0]['Destination'],
                                //             index: index,
                                //           )),
                                // );
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
                                      padding: const EdgeInsets.fromLTRB(
                                          8, 20, 8, 20),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.flight_takeoff),
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
                                              Icon(Icons.arrow_right_alt),
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
                                                "No seats selected",
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
                  ),

                  // Center(
                  //   child: InkWell(
                  //     onTap: (){
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(builder: (context) => SeatSelectionPage()),
                  //       );
                  //     },
                  //       child: Text("Page 2 , Seat selection")
                  //   ),
                  // ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  String formatDuration(int duration) {
    int hours = duration ~/ 60;
    int minutes = duration % 60;

    String formattedHours = hours.toString().padLeft(2, '0');
    String formattedMinutes = minutes.toString().padLeft(2, '0');

    return '$formattedHours h $formattedMinutes m';
  }

}
