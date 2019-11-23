import 'package:flutter/material.dart';
import 'package:my_app/journal_entry.dart';
import '../registration/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import "package:my_app/fire_base_helper.dart";
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
// import "package:font_awesome_flutter/font_awesome_flutter.dart";

class AnalysisPage extends StatelessWidget {
  AnalysisPage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  FireBaseHelper fbh = new FireBaseHelper();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: const Text('Analytical Results'),
        ),

       body:AnalysisWidget(auth: this.auth, userId: this.userId, logoutCallback: this.logoutCallback),
    );
  }



}

class AnalysisWidget extends StatefulWidget{
  AnalysisWidget({Key key,this.auth, this.userId, this.logoutCallback})
      : super(key: key);
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  @override
  State<StatefulWidget> createState() => _AnalysisWidgetState(); 


}

class _AnalysisWidgetState extends State<AnalysisWidget>{
  final FirebaseDatabase _database = FirebaseDatabase.instance; 
  final GlobalKey<FormState> formKey = GlobalKey<FormState>(); 
  Query _journaleQuery; 
  
  @override 
  void initState(){
    super.initState();
    _journaleQuery = _database.reference().child('journal_entry')
    .orderByChild('userId').equalTo(widget.userId);
  }
  // _journaelQuery
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
         body: Column(
           children: <Widget>[
              // datePickButton,
              // datePickButton,
              // titleSection,
              _buildButtons(),
              new Container(
              height: 190,
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  children: <Widget>[
                    simpleDatumLegendWithMeasuresSection
                  ],
                ),
              ),
             ),
             new Container(
              height: 190,
              child: Padding(
                padding: EdgeInsets.all(3.0),
                child: Column(
                  children: <Widget>[
                    simpleBarSection
                  ],
                ),
              ),
             ),
            new Container(
              height: 190,
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  children: <Widget>[
                    // CustomAxisTickFormattersSection
                    NonzeroBoundMeasureAxisSection
                 
                  ],
                ),
              ),
             ),
           ],
         ),
        // Text("Hello User: $_journaleQuery"),
    );
  }


  Widget _buildButtons() {
    // final dateTime = _events.keys.elementAt(_events.length - 2);

    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text('Month'),
              onPressed: () {
                setState(() {
                  print("Month");
                  // _calendarController.setCalendarFormat(CalendarFormat.month);
                });
              },
            ),
            RaisedButton(
              child: Text('Fortnight'),
              onPressed: () {
                setState(() {
                  print("Fortnight");
                  // _calendarController.setCalendarFormat(CalendarFormat.twoWeeks);
                });
              },
            ),
            RaisedButton(
              child: Text('Week'),
              onPressed: () {
                setState(() {
                  print("Week");
                  // _calendarController.setCalendarFormat(CalendarFormat.week);
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 8.0),
      
      ],
    );
  }
 
  
Widget datePickButton= new MaterialButton(
    color: Colors.deepOrangeAccent,
    onPressed: () async {
      final List<DateTime> picked = await DateRagePicker.showDatePicker(
          // context: context,
          initialFirstDate: new DateTime.now(),
          initialLastDate: (new DateTime.now()).add(new Duration(days: 7)),
          firstDate: new DateTime(2015),
          lastDate: new DateTime(2020)
      );
      if (picked != null && picked.length == 2) {
          print(picked);
      }
    },
    child: new Text("Pick date range")
);
}



Widget titleSection = Container(
  padding: const EdgeInsets.all(32),
  child: Row(
    children: [
      Expanded(
        /*1*/
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            /*2*/
           
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Hi Kevindsd',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
           
            // Text(
            //   'Your mood inputs in past 30 days',
            //   style: TextStyle(
            //     color: Colors.grey[500],
            //   ),
            // ),
          ],
        ),
      ),
      /*3*/
      Icon(
        Icons.star,
        color: Colors.red[500],
      ),
      Text('21: Records'),
    ],
  ),
);


// Color color = Theme.of(context).primaryColor;

Widget buttonSection = Container(
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _buildButtonColumn(Colors.blue, Icons.call, 'CALL'),
      _buildButtonColumn(Colors.blue, Icons.near_me, 'ROUTE'),
      _buildButtonColumn(Colors.blue, Icons.share, 'SHARE'),
    ],
  ),
);

Widget simpleBarSection = Container(
  child: new Padding(
    padding: new EdgeInsets.all(2.0),
    child: new SizedBox(
      height: 180.0,
      child: SimpleBarChart(_createSampleData()),
    )
  ),
);

Widget simpleDatumLegendWithMeasuresSection = Container(
  child: new Padding(
    padding: new EdgeInsets.all(0.0),
    child: new SizedBox(
      height: 180,
      child: DatumLegendWithMeasures(_createDatumLegendWithMeasuresData()),
    ),
  ),
);

Widget CustomAxisTickFormattersSection = Container(
  child: new Padding(
    padding: new EdgeInsets.all(0.0),
    child: new SizedBox(
      height: 180.0,
      child: CustomAxisTickFormatters(_CustomAxisTickFormattersData()),
    )
  ),
);

Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
}

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, {this.animate});
  /// Creates a [BarChart] with sample data and no transition.
  factory SimpleBarChart.withSampleData() {
    return new SimpleBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
    );
  }

  /// Create one series with sample hard coded data.
  
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      //TODO 
      //Replace the following data to the real data 
      new OrdinalSales('Very Said', 8),
      new OrdinalSales('Sad', 6),
      new OrdinalSales('Ok', 10),
      new OrdinalSales('Happy', 6),
      new OrdinalSales('Very Happy', 7),
    ];
    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Mood Entry',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
}

class CustomAxisTickFormatters extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  CustomAxisTickFormatters(this.seriesList, {this.animate});
  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory CustomAxisTickFormatters.withSampleData() {
    return new CustomAxisTickFormatters(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Formatter for numeric ticks using [NumberFormat] to format into currency
    ///
    /// This is what is used in the [NumericAxisSpec] below.
    final simpleCurrencyFormatter =
        new charts.BasicNumericTickFormatterSpec.fromNumberFormat(
            new NumberFormat.compactSimpleCurrency());

    /// Formatter for numeric ticks that uses the callback provided.
    ///
    /// Use this formatter if you need to format values that [NumberFormat]
    /// cannot provide.
    ///
    /// To see this formatter, change [NumericAxisSpec] to use this formatter.
    // final customTickFormatter =
    //   charts.BasicNumericTickFormatterSpec((num value) => 'MyValue: $value');

    return new charts.TimeSeriesChart(seriesList,
        animate: animate,
        // Sets up a currency formatter for the measure axis.
        primaryMeasureAxis: new charts.NumericAxisSpec(
            tickFormatterSpec: simpleCurrencyFormatter),

        /// Customizes the date tick formatter. It will print the day of month
        /// as the default format, but include the month and year if it
        /// transitions to a new month.
        ///
        /// minute, hour, day, month, and year are all provided by default and
        /// you can override them following this pattern.
        domainAxis: new charts.DateTimeAxisSpec(
            tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
                day: new charts.TimeFormatterSpec(
                    format: 'd', transitionFormat: 'MM/dd/yyyy'))));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<MyRow, DateTime>> _createSampleData() {

    final data = [
      new MyRow(new DateTime(2017, 9, 25), 6),
      new MyRow(new DateTime(2017, 9, 26), 8),
      new MyRow(new DateTime(2017, 9, 27), 6),
      new MyRow(new DateTime(2017, 9, 28), 9),
      new MyRow(new DateTime(2017, 9, 29), 11),
      new MyRow(new DateTime(2017, 9, 30), 15),
      new MyRow(new DateTime(2017, 10, 01), 25),
      new MyRow(new DateTime(2017, 10, 02), 33),
      new MyRow(new DateTime(2017, 10, 03), 27),
      new MyRow(new DateTime(2017, 10, 04), 31),
      new MyRow(new DateTime(2017, 10, 05), 23),
    ];

    return [
      new charts.Series<MyRow, DateTime>(
        id: 'Cost',
        domainFn: (MyRow row, _) => row.timeStamp,
        measureFn: (MyRow row, _) => row.headcount,
        data: data
      )
    ]; 

  }
}

/// Sample time series data type.
class MyRow {
  final DateTime timeStamp;
  final int headcount;
  MyRow(this.timeStamp, this.headcount);
}




List<charts.Series<MyRow, DateTime>> _CustomAxisTickFormattersData() {

    // TODO 
    // Replace the data to the real data 
    final data = [
      new MyRow(new DateTime(2019, 9, 25), 3),
      new MyRow(new DateTime(2019, 9, 26), 4),
      new MyRow(new DateTime(2019, 9, 27), 2),
      new MyRow(new DateTime(2019, 9, 28), 2),
      new MyRow(new DateTime(2019, 9, 29), 3),
      new MyRow(new DateTime(2019, 9, 30), 5),
      new MyRow(new DateTime(2019, 10, 1), 2),
      new MyRow(new DateTime(2019, 10, 2), 3),
      new MyRow(new DateTime(2019, 10, 3), 4),
      new MyRow(new DateTime(2019, 10, 4), 2),
      new MyRow(new DateTime(2019, 10, 5), 3),
      new MyRow(new DateTime(2019, 10, 6), 2),
      new MyRow(new DateTime(2019, 10, 7), 3),
      new MyRow(new DateTime(2019, 10, 8), 4),
      new MyRow(new DateTime(2019, 10, 9), 2),
      new MyRow(new DateTime(2019, 10, 10), 3),
      new MyRow(new DateTime(2019, 10, 11), 2),
      new MyRow(new DateTime(2019, 10, 12), 1),
      new MyRow(new DateTime(2019, 10, 13), 2),
      new MyRow(new DateTime(2019, 10, 14), 3),
      new MyRow(new DateTime(2019, 10, 15), 4),
      new MyRow(new DateTime(2019, 10, 16), 2),
      new MyRow(new DateTime(2019, 10, 17), 5),
      new MyRow(new DateTime(2019, 10, 18), 2),
      new MyRow(new DateTime(2019, 10, 19), 3),
      new MyRow(new DateTime(2019, 10, 20), 4),
      new MyRow(new DateTime(2019, 10, 21), 2),
      new MyRow(new DateTime(2019, 10, 22), 5),
      new MyRow(new DateTime(2019, 10, 23), 2),
      new MyRow(new DateTime(2019, 10, 24), 3),
      new MyRow(new DateTime(2019, 10, 25), 2),
    ];
    return [
      new charts.Series<MyRow, DateTime>(
        id: 'headcount',
        domainFn: (MyRow row, _) => row.timeStamp,
        measureFn: (MyRow row, _) => row.headcount,
        data: data,
      )
    ];
  }


  class DatumLegendWithMeasures extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DatumLegendWithMeasures(this.seriesList, {this.animate});

  factory DatumLegendWithMeasures.withSampleData() {
    return new DatumLegendWithMeasures(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(
      seriesList,
      animate: animate,
      // Add the legend behavior to the chart to turn on legends.
      // This example shows how to optionally show measure and provide a custom
      // formatter.
      behaviors: [
        new charts.DatumLegend(
          // Positions for "start" and "end" will be left and right respectively
          // for widgets with a build context that has directionality ltr.
          // For rtl, "start" and "end" will be right and left respectively.
          // Since this example has directionality of ltr, the legend is
          // positioned on the right side of the chart.
          position: charts.BehaviorPosition.end,
          // By default, if the position of the chart is on the left or right of
          // the chart, [horizontalFirst] is set to false. This means that the
          // legend entries will grow as new rows first instead of a new column.
          horizontalFirst: false,
          // This defines the padding around each legend entry.
          cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
          // Set [showMeasures] to true to display measures in series legend.
          showMeasures: true,
          // Configure the measure value to be shown by default in the legend.
          legendDefaultMeasure: charts.LegendDefaultMeasure.firstValue,
          // Optionally provide a measure formatter to format the measure value.
          // If none is specified the value is formatted as a decimal.
          measureFormatter: (num value) {
            return value == null ? '-' : '${value}%';
          },
        ),
      ],
    );
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;
  LinearSales(this.year, this.sales);
}

List<charts.Series<LinearSales, int>> _createDatumLegendWithSampleData() {
    final data = [
      new LinearSales(1, 100),
      new LinearSales(2, 75),
      new LinearSales(3, 25),
      new LinearSales(4, 5),
      new LinearSales(5, 5),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Mood',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  List<charts.Series<LinearSales, int>> _createDatumLegendWithMeasuresData() {
    final data = [
      new LinearSales(1, 30),
      new LinearSales(2, 35),
      new LinearSales(3, 10),
      new LinearSales(4, 10),
      new LinearSales(5, 15),
    ];
    return [
      new charts.Series<LinearSales, int>(
        id: 'Mood',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }



Widget NonzeroBoundMeasureAxisSection = Container(
  child: new Padding(
    padding: new EdgeInsets.all(0.0),
    child: new SizedBox(
      height: 180.0,
      child: NonzeroBoundMeasureAxis(_CustomAxisTickFormattersData()),
    )
  ),
);


class NonzeroBoundMeasureAxis extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  NonzeroBoundMeasureAxis(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory NonzeroBoundMeasureAxis.withSampleData() {
    return new NonzeroBoundMeasureAxis(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(seriesList,
        animate: animate,
        // Provide a tickProviderSpec which does NOT require that zero is
        // included.
        primaryMeasureAxis: new charts.NumericAxisSpec(
            tickProviderSpec:
                new charts.BasicNumericTickProviderSpec(zeroBound: false)));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<MyRow, DateTime>> _createSampleData() {

    final data = [
      new MyRow(new DateTime(2017, 9, 25), 106),
      new MyRow(new DateTime(2017, 9, 26), 108),
      new MyRow(new DateTime(2017, 9, 27), 106),
      new MyRow(new DateTime(2017, 9, 28), 109),
      new MyRow(new DateTime(2017, 9, 29), 111),
      new MyRow(new DateTime(2017, 9, 30), 115),
      new MyRow(new DateTime(2017, 10, 01), 125),
      new MyRow(new DateTime(2017, 10, 02), 133),
      new MyRow(new DateTime(2017, 10, 03), 127),
      new MyRow(new DateTime(2017, 10, 04), 131),
      new MyRow(new DateTime(2017, 10, 05), 123),
    ];

    return [
      new charts.Series<MyRow, DateTime>(
        id: 'Headcount',
        domainFn: (MyRow row, _) => row.timeStamp,
        measureFn: (MyRow row, _) => row.headcount,
        data: data,
      )
    ];
  }
}

