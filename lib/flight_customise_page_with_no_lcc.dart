import 'package:flutter/material.dart';
import 'global.dart';
import 'models/nonLccSSRwithSeat.dart';
import 'nonLccSsrMealWithOutSeat.dart';


List <Baggage>NonLccBaggage = [];
List<Meal> NonLccMeal = [];


class FlightCustomisePageWithNoLCC extends StatefulWidget {
  const FlightCustomisePageWithNoLCC({Key? key, this.ResultIndex, this.TraceId, this.Token, required this.IsPanRequiredAtBook, required this.IsPanRequiredAtTicket, required this.IsPassportRequiredAtBook, required this.IsPassportRequiredAtTicket}) : super(key: key);
  final ResultIndex;
  final TraceId;
  final Token;
  final bool IsPanRequiredAtBook;
  final bool IsPanRequiredAtTicket;
  final bool IsPassportRequiredAtBook;
  final bool IsPassportRequiredAtTicket;

  @override
  _FlightCustomisePageWithNoLCCState createState() =>
      _FlightCustomisePageWithNoLCCState();
}

class _FlightCustomisePageWithNoLCCState
    extends State<FlightCustomisePageWithNoLCC> {

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
                      color: Colors.blue,
                    ),

                    if (NonLccBaggage.isNotEmpty)
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


                    if (NonLccBaggage.isNotEmpty)
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
                                    items: NonLccBaggage.map<
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

                    if (NonLccMeal.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            // log(res);
                            print(NonLccBaggage[0]);
                          },
                          child: Text(
                            "Meal choice",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                    if (NonLccMeal.isNotEmpty)
                      Text(
                        "Request dietary preferences",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    if (NonLccMeal.isNotEmpty)
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
                                  value: selectedNonLccMeal,
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedNonLccMeal = newValue!;
                                    });
                                  },
                                  isExpanded: true,
                                  items: NonLccMeal
                                      .map<DropdownMenuItem<dynamic>>(
                                          (value) {
                                        return DropdownMenuItem<dynamic>(
                                          value: value,
                                          child: Text(
                                              "${value.description} (${value.code})"),
                                        );
                                      }).toList(),
                                ),
                              )
                            ],
                          );
                        },
                      ),



                    if(nonLccMealWithoutSeat.isNotEmpty)
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
                    if (nonLccMealWithoutSeat.isNotEmpty)
                      Text(
                        "Request dietary preferences",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    if (nonLccMealWithoutSeat.isNotEmpty)
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
                                  value: selectedNonLccMeal,
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedNonLccMeal = newValue!;
                                    });
                                  },
                                  isExpanded: true,
                                  items: nonLccMealWithoutSeat
                                      .map<DropdownMenuItem<dynamic>>(
                                          (value) {
                                        return DropdownMenuItem<dynamic>(
                                          value: value,
                                          child: Text(
                                              "${value.description} (${value.code})"),
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

                    if (seatPreference!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            // log(res);
                            print(LccBaggage);
                          },
                          child: Text(
                            "Seat Preference",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                    SizedBox(
                      height: 10,
                    ),
                    if (seatPreference.isNotEmpty)
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
                                  value: seatPreference,
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedSeatPreference = newValue!;
                                    });
                                  },
                                  isExpanded: true,
                                  items: seatPreference
                                      .map<DropdownMenuItem<dynamic>>(
                                          (value) {
                                        return DropdownMenuItem<dynamic>(
                                          value: value,
                                          child: Text(
                                              "${value.description} (${value.code})"),
                                        );
                                      }).toList(),
                                ),
                              )
                            ],
                          );
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

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
