import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/search_results_page.dart';

import 'global.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      initialDateRange: DateTimeRange(
        start: DateTime.parse(startDate),
        end: DateTime.parse(endDate),
      ),
    );
    if (picked != null) {
      setState(() {
        startDate = DateFormat('yyyy-MM-ddT00:00:00').format(picked.start);
        endDate = DateFormat('yyyy-MM-ddT00:00:00').format(picked.end);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: _selectDateRange, // Call the function to show the date picker
                child: Text("Date 1: $startDate\nDate 1: $endDate")
            ),
            const SizedBox(height: 50,),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchResultsPage(
                        startDate: startDate,
                        endDate: endDate,
                      ),
                    ),
                  );
                },
                child: const Text("Search")
            ),
          ],
        ),
      ),
    );
  }
}
