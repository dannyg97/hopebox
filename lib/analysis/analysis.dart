import 'package:flutter/material.dart';
import 'package:my_app/journal_entry.dart';
import '../registration/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import "package:my_app/fire_base_helper.dart";
// import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
// import "package:font_awesome_flutter/font_awesome_flutter.dart";

class AnalysisPage extends StatelessWidget {
  AnalysisPage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  FireBaseHelper fbh = new FireBaseHelper();

  List<String> allDates; 
  Widget analysisWidget() {
       
    return FutureBuilder(
      builder: (context, fireBaseSnap) {
        if (fireBaseSnap.connectionState == ConnectionState.none &&
            fireBaseSnap.hasData == null) {
            return Container(width: 0.0, height: 0.0);
        }
        allDates = fireBaseSnap.data;
        // print(fireBaseSnap.data.document);
        return AnalysisWidget(auth: this.auth, userId: this.userId, logoutCallback: this.logoutCallback, allDates: allDates.toList());
      },
      future: fbh.getAllDatesWithMoodOrJournalEntries(userId),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Analytical Results'),
        ),
       body: analysisWidget(),    
      );
  }

}

class AnalysisWidget extends StatefulWidget{
  AnalysisWidget({Key key,this.auth, this.userId, this.logoutCallback, this.allDates})
      : super(key: key);
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  final List<String> allDates;

  @override
  State<StatefulWidget> createState() => _AnalysisWidgetState(); 

}

class _AnalysisWidgetState extends State<AnalysisWidget>{
  final FirebaseDatabase _database = FirebaseDatabase.instance; 
  final GlobalKey<FormState> formKey = GlobalKey<FormState>(); 
  FireBaseHelper fbh = new FireBaseHelper();
  Query _journaleQuery; 
  int records = 0; 
  int days = 7; 
  
  @override 
  void initState(){
    super.initState();
    print("The widget is ");
    print(widget.userId);
    print("The auth is");
    print(widget.auth);
    print("The dates are");
    print(widget.allDates);
    print("The mood is");
    records = getRecordsNum(widget.allDates, days); 
    _journaleQuery = _database.reference().child('journal_entry')
    .orderByChild('userId').equalTo(widget.userId);
  }

  int getRecordsNum(List<String> dates, days){
    int records = 0; 
    DateTime now = new DateTime.now();
    var today = new DateFormat("yyyy-MM-dd").format(now);
    var pointDate =  now.subtract(new Duration(days: days));
    for(var item in dates){
      //  var time1 = DateTime.parse(today) ;
      var time1 = pointDate;
       var time2 = DateTime.parse(item);
       if(time2.isAfter(time1)){
         records = records + 1; 
       }
    }
    return records; 
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
                    simpleBarSection(widget.allDates),
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
                    NonzeroBoundMeasureAxisSection(widget.allDates),
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
                  days = 30; 
                  records = getRecordsNum(widget.allDates, days); 
                       print(days);
                  // _calendarController.setCalendarFormat(CalendarFormat.month);
                });
              },
            ),
            RaisedButton(
              child: Text('Fortnight'),
              onPressed: () {
                setState(() {
                  print("Fortnight");
                  days = 14;
                  records = getRecordsNum(widget.allDates, days); 
                  print(days);
                  // _calendarController.setCalendarFormat(CalendarFormat.twoWeeks);
                });
                
              },
            ),
            RaisedButton(
              child: Text('Week'),
           
             
                 color: Colors.blue,
      
              onPressed: () {
                setState(() {
                  print("Week");
                  days = 7; 
                  records = getRecordsNum(widget.allDates, days); 
                  
                  print(days);
                  // _calendarController.setCalendarFormat(CalendarFormat.week);
                });
              },             
            ),
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          Text('$records: Records'),
        ],
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }

}

//SimpleBarSection 
Widget simpleBarSection(List<String> allDate){
  return new Container(
  child: new Padding(
    padding: new EdgeInsets.all(2.0),
    child: new SizedBox(
      height: 180.0,
      child: SimpleBarChart(_createSampleData(allDate)),
    )
  ),
  );
}

Widget simpleDatumLegendWithMeasuresSection = Container(
  child: new Padding(
    padding: new EdgeInsets.all(0.0),
    child: new SizedBox(
      height: 180,
      child: DatumLegendWithMeasures(_createDatumLegendWithMeasuresData()),
    ),
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
  // factory SimpleBarChart.withSampleData() {
  //   return new SimpleBarChart(
  //     _createSampleData(this.allDate),
  //     // Disable animations for image tests.
  //     animate: false,
  //   );
  // }

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

List<charts.Series<OrdinalSales, String>> _createSampleData(List<String> allDates) {
    int very_diss = 0; 
    int diss = 0; 
    int neutral = 0; 
    int satisified = 0; 
    int very_sati = 0 ; 

    final data = [
      //TODO 
      //Replace the following data to the real data 
      new OrdinalSales('Very Dissatisfied', very_diss),
      new OrdinalSales('Dissatisfied', diss),
      new OrdinalSales('Neutral', neutral),
      new OrdinalSales('Satisfied', satisified),
      new OrdinalSales('Very Satisfied', very_sati),
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


/// Sample time series data type.
class MyRow {
  final DateTime timeStamp;
  final int headcount;
  MyRow(this.timeStamp, this.headcount);
}



//PASS ALL DATA with mood
List<charts.Series<MyRow, DateTime>> _CustomAxisTickFormattersData(List<String> allData) {
    // TODO 
    // Replace the data to the real data 
    var data = [
      
       new MyRow(new DateTime(2019, 10, 3), 1),
   
    ];

    for(int i =0; i< allData.length; i++ ){
      var daylist = allData[i].split("-");
      // print(daylist.toList()[0]);
      // print(daylist.toList()[1]);
      // print(daylist.toList()[2]);
      data.add(new MyRow(new DateTime(int.parse(daylist.toList()[0]), int.parse(daylist.toList()[1]), int.parse(daylist.toList()[2])), 4));
    
    }

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


List<charts.Series<LinearSales, int>> _createDatumLegendWithMeasuresData() {

    int very_diss = 0; 
    int diss = 0; 
    int neutral = 0; 
    int satisified = 0; 
    int very_sati = 1 ; 
    int sum = very_diss + diss + neutral + satisified + very_sati; 
    double p1 = very_diss/sum; 
    double p2 = diss / sum; 
    double p3 = neutral / sum; 
    double p4 = satisified / sum; 
    double p5 = very_sati / sum; 

    final data = [
      new LinearSales(1, p1.toInt()),
      new LinearSales(2, p2.toInt()),
      new LinearSales(3, p3.toInt()),
      new LinearSales(4, p4.toInt()),
      new LinearSales(5, p5.toInt()),
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

Widget NonzeroBoundMeasureAxisSection(List<String> allDates){ 
  return new Container(
        child: new Padding(
       padding: new EdgeInsets.all(0.0),
        child: new SizedBox(
            height: 180.0,
             child: NonzeroBoundMeasureAxis(_CustomAxisTickFormattersData(allDates)),
           )
        ),
        );
}


class NonzeroBoundMeasureAxis extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  NonzeroBoundMeasureAxis(this.seriesList, {this.animate});
  /// Creates a [TimeSeriesChart] with sample data and no transition.

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
  /// 
}

