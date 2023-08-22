import 'dart:convert';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ticket_widget/ticket_widget.dart';

import 'models/lccBookModel.dart';

class LccBookedPage extends StatefulWidget {
  const LccBookedPage({Key? key, this.bookedData}) : super(key: key);
  final bookedData;

  @override
  _LccBookedPageState createState() => _LccBookedPageState();
}

class _LccBookedPageState extends State<LccBookedPage> {
  late LccBookModel data;
  List<String> imagePaths = [];

  @override
  void initState() {
    data = lccBookModelFromJson(widget.bookedData.toString());
    loadImages();
    super.initState();
  }

  Future<void> loadImages() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final manifestMap = Map<String, dynamic>.from(json.decode(manifestContent));

    final imagePaths = manifestMap.keys
        .where((String key) => key.startsWith('assets/images/AirlineLogo'))
        .toList();

    setState(() {
      this.imagePaths = imagePaths;
    });

  }


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          "Booking Details",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    // Image.network(
                    //   'https://logos-world.net/wp-content/uploads/2023/01/SpiceJet-Logo-500x281.png',
                    //   width: 100,
                    // ),
                    // SizedBox(
                    //   width: 10,
                    // ),
                    Expanded(
                      child: BarcodeWidget(
                        barcode: Barcode.pdf417(), // Barcode type and settings
                        data:
                            "${data.response!.response!.flightItinerary!.pnr}", // data.response!.response!.flightItinerary!.passenger![0].barcodeDetails!.barcode
                        height: 50,
                        errorBuilder: (context, error) =>
                            Center(child: Text("")),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.maxFinite,
                  decoration: ShapeDecoration(
                    color: Color(0xFFFFF5FE),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.50, color: Color(0xFFA6A6A6)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  padding: EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${data.response!.response!.flightItinerary!.passenger![0].title}. ${data.response!.response!.flightItinerary!.passenger![0].firstName} ${data.response!.response!.flightItinerary!.passenger![0].lastName}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Mob: ${data.response!.response!.flightItinerary!.passenger![0].contactNo}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Email: ${data.response!.response!.flightItinerary!.passenger![0].email}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.maxFinite,
                  decoration: ShapeDecoration(
                    color: Color(0xFFFFF5FE),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.50, color: Color(0xFFA6A6A6)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  padding: EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PNR: ${data.response!.response!.flightItinerary!.pnr}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Booking Id: ${data.response!.response!.flightItinerary!.bookingId}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Booked on: ${DateFormat("E, MMM. d, y hh:mm a").format(data.response!.response!.flightItinerary!.invoiceCreatedOn!)}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Status: ${data.response!.response!.flightItinerary!.segments![0].flightStatus}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data
                        .response!.response!.flightItinerary!.segments!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${data.response!.response!.flightItinerary!.segments![index].origin!.airport!.cityCode} (T${data.response!.response!.flightItinerary!.segments![index].origin!.airport!.terminal})',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  '${DateFormat("E, MMM. d, y hh:mm a").format(data.response!.response!.flightItinerary!.segments![index].origin!.depTime!)}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '${data.response!.response!.flightItinerary!.segments![index].airline!.airlineCode}${data.response!.response!.flightItinerary!.segments![index].airline!.flightNumber}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Container(
                            width: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${data.response!.response!.flightItinerary!.segments![index].destination!.airport!.cityCode} (T${data.response!.response!.flightItinerary!.segments![index].destination!.airport!.terminal})',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  '${DateFormat("E, MMM. d, y hh:mm a").format(data.response!.response!.flightItinerary!.segments![index].destination!.arrTime!)}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data
                        .response!.response!.flightItinerary!.segments!.length,
                    itemBuilder: (BuildContext context, int index) {

                      var airLogo =
                          "assets/images/AirlineLogo/nologo.gif";

                      for (int i = 0; i < imagePaths.length; i++) {
                        var imgPath = imagePaths[i];
                        var imgName = imgPath
                            .split('/')
                            .last; // Extract the image name from the path
                        var imgCode = imgName
                            .split('.')
                            .first; // Extract the code from the image name
                        var airCode = data.response!.response!.flightItinerary!.segments![index].airline!.airlineCode;

                        if (imgCode.toLowerCase() ==
                            airCode!.toLowerCase()) {
                          // print(airCode);
                          // print(imgCode);
                          airLogo = imgPath;
                        }
                      }

                      return Container(
                        decoration: ShapeDecoration(
                          color: Color(0xFFFFF5FE),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.50, color: Color(0xFFA6A6A6)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        padding: EdgeInsets.all(14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Flight Details:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'Airline Name : ${data.response!.response!.flightItinerary!.segments![index].airline!.airlineName}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  'Flight Number : ${data.response!.response!.flightItinerary!.segments![index].airline!.flightNumber}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  'Airline Code: ${data.response!.response!.flightItinerary!.segments![index].airline!.airlineCode}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 100,
                              child: //const Icon(Icons.airplane_ticket_sharp)
                              Image.asset(
                                airLogo,
                              ),
                            ),
                            // Image.network(
                            //   'https://logos-world.net/wp-content/uploads/2023/01/SpiceJet-Logo-500x281.png',
                            //   width: 100,
                            // ),
                          ],
                        ),
                      );
                    }),
                SizedBox(
                  height: 10,
                ),

                ListView.separated(
                  itemCount: 1,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, ind){
                  return  Table(
                    border: TableBorder.all(
                      color: Color(0xFFA7A7A7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: Color(0xFF484848),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        children: [
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'Passenger Name',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'Flight',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'Fare Type',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'Add-on',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: data.response!.response!.flightItinerary!.passenger!.length,
                                  itemBuilder: (context, index) {
                                    final item = data.response!.response!.flightItinerary!.passenger![index];
                                    return Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Text("${item.title}. ${item.firstName} ${item.lastName}"),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                      '${data.response!.response!.flightItinerary!.segments![0].airline!.flightNumber}'),
                                  Text(
                                      '(${data.response!.response!.flightItinerary!.segments![0].origin!.airport!.cityCode}-${data.response!.response!.flightItinerary!.segments![0].destination!.airport!.cityCode})'),
                                ],
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                  '${data.response!.response!.flightItinerary!.resultFareType}'),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                      'Seat ${data.response!.response!.flightItinerary!.passenger![0].segmentAdditionalInfo![0].seat}'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }, separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 20,);
                },),

                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 300,
                      decoration: ShapeDecoration(
                        color: Color(0xFFFFF5FE),
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(width: 0.50, color: Color(0xFFA6A6A6)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Invoice Details',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Icon(Icons.receipt_long),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Invoice Id: ${data.response!.response!.flightItinerary!.invoice![0].invoiceId}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Invoice No: ${data.response!.response!.flightItinerary!.invoice![0].invoiceNo}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Created on: ${DateFormat('dd-MM-yyyy, HH:mm a').format(data.response!.response!.flightItinerary!.invoice![0].invoiceCreatedOn!)}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Amount: ₹${data.response!.response!.flightItinerary!.invoice![0].invoiceAmount}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: 250,
                      decoration: ShapeDecoration(
                        color: Color(0xFFFFF5FE),
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(width: 0.50, color: Color(0xFFA6A6A6)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Baggage Details',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(Icons.luggage_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Baggage: ${data.response!.response!.flightItinerary!.segments![0].baggage}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'Cabin Baggage: ${data.response!.response!.flightItinerary!.segments![0].cabinBaggage}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                TicketWidget(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 500,
                  isCornerRounded: true,
                  padding: EdgeInsets.all(20),
                  color: Color(0xffefefef),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //flight class
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              border:
                                  Border.all(width: 1.0, color: Colors.green),
                            ),
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 3, bottom: 3),
                            child: Center(
                              child: Text(
                                data.response!.response!.flightItinerary!
                                            .segments![0].cabinClass ==
                                        2
                                    ? 'Economy'
                                    : data.response!.response!.flightItinerary!
                                                .segments![0].cabinClass ==
                                            3
                                        ? 'Premium Economy'
                                        : data
                                                    .response!
                                                    .response!
                                                    .flightItinerary!
                                                    .segments![0]
                                                    .cabinClass ==
                                                4
                                            ? 'Business'
                                            : data
                                                        .response!
                                                        .response!
                                                        .flightItinerary!
                                                        .segments![0]
                                                        .cabinClass ==
                                                    5
                                                ? 'Premium Business'
                                                : 'All',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '${data.response!.response!.flightItinerary!.segments![0].origin!.airport!.cityCode}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Icon(
                                  Icons.flight_takeoff,
                                  color: Colors.pink,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  '${data.response!.response!.flightItinerary!.segments![0].destination!.airport!.cityCode}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          'Flight Ticket',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Passengers',
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4.0),
                                        child: Container(
                                          width: 200,
                                          child: Text(
                                            '${data.response!.response!.flightItinerary!.passenger![0].title}. ${data.response!.response!.flightItinerary!.passenger![0].firstName} ${data.response!.response!.flightItinerary!.passenger![0].lastName}',
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Date',
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Text(
                                        '${DateFormat('dd-MM-yyyy').format(data.response!.response!.flightItinerary!.passenger![0].ticket!.issueDate!)}',
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 12.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Flight',
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4.0),
                                          child: Container(
                                            width: 200,
                                            child: Text(
                                              '${data.response!.response!.flightItinerary!.segments![0].airline!.airlineName}',
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Terminal',
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 4.0,
                                          ),
                                          child: Container(
                                            width: 50,
                                            child: Text(
                                              '${data.response!.response!.flightItinerary!.segments![0].origin!.airport!.terminal}',
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 12.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Class',
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4.0),
                                        child: Container(
                                          width: 150,
                                          child: Text(
                                            data
                                                        .response!
                                                        .response!
                                                        .flightItinerary!
                                                        .segments![0]
                                                        .cabinClass ==
                                                    2
                                                ? 'Economy'
                                                : data
                                                            .response!
                                                            .response!
                                                            .flightItinerary!
                                                            .segments![0]
                                                            .cabinClass ==
                                                        3
                                                    ? 'Premium Economy'
                                                    : data
                                                                .response!
                                                                .response!
                                                                .flightItinerary!
                                                                .segments![0]
                                                                .cabinClass ==
                                                            4
                                                        ? 'Business'
                                                        : data
                                                                    .response!
                                                                    .response!
                                                                    .flightItinerary!
                                                                    .segments![
                                                                        0]
                                                                    .cabinClass ==
                                                                5
                                                            ? 'Premium Business'
                                                            : 'All',
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Seat',
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4.0),
                                        child: Container(
                                          width: 50,
                                          child: Text(
                                            '${data.response!.response!.flightItinerary!.passenger![0].seatDynamic![0].code}',
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 80.0, left: 30.0, right: 30.0),
                        child: BarcodeWidget(
                          barcode:
                              Barcode.pdf417(), // Barcode type and settings
                          data:
                              "${data.response!.response!.flightItinerary!.passenger![0].barcodeDetails!.barcode}",
                          height: 50,
                          errorBuilder: (context, error) =>
                              Center(child: Text("")),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 10.0,
                        ),
                        child: Center(
                          child: Text(
                            '${data.response!.response!.flightItinerary!.airlineTollFreeNo}',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
