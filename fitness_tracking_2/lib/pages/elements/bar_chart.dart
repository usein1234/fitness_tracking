/// Example of a time series chart using a bar renderer.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../entity/time_series.dart';

class TimeSeriesBar extends StatelessWidget {
  final dynamic seriesList;
  final bool animate;

  TimeSeriesBar(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory TimeSeriesBar.withSampleData() {
    return new TimeSeriesBar(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      domainAxis: new charts.DateTimeAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
            axisLineStyle: charts.LineStyleSpec(
              color: charts.MaterialPalette
                  .white, // this also doesn't change the Y axis labels
            ),
            labelStyle: new charts.TextStyleSpec(
              fontSize: 12,
              color: charts.MaterialPalette.white,
            ),
            lineStyle: charts.LineStyleSpec(
              thickness: 1,
              color: charts.MaterialPalette.gray.shadeDefault,
            )),
        tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
          hour: new charts.TimeFormatterSpec(
            format: 'HH:mm',
            transitionFormat: 'HH:mm',
          ),
        ),
      ),
      // Set the default renderer to a bar renderer.
      // This can also be one of the custom renderers of the time series chart.
      defaultRenderer: new charts.BarRendererConfig<DateTime>(),
      defaultInteractions: false,
      // If default interactions were removed, optionally add select nearest
      // and the domain highlighter that are typical for bar charts.
      behaviors: [new charts.SelectNearest(), new charts.DomainHighlighter()],
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSteps, DateTime>> _createSampleData() {
    final data = [

      new TimeSeriesSteps( time: new DateTime(2019, 6, 1),  steps: 200),
      new TimeSeriesSteps( time: new DateTime(2019, 6, 2),  steps: 500),
      new TimeSeriesSteps( time: new DateTime(2019, 6, 3),  steps: 700),
      new TimeSeriesSteps( time: new DateTime(2019, 6, 4),  steps: 220),
      new TimeSeriesSteps( time: new DateTime(2019, 6, 5),  steps: 160),
      new TimeSeriesSteps( time: new DateTime(2019, 6, 6),  steps: 25),
      new TimeSeriesSteps( time: new DateTime(2019, 6, 7),   steps: 1000),
      new TimeSeriesSteps( time: new DateTime(2019, 6, 8),   steps: 280),
      new TimeSeriesSteps( time: new DateTime(2019, 6, 9),   steps: 360),
      new TimeSeriesSteps( time: new DateTime(2019, 6, 10),   steps: 1000),
      new TimeSeriesSteps( time: new DateTime(2019, 6, 11),   steps: 2000),
      new TimeSeriesSteps( time: new DateTime(2019, 6, 12),   steps: 600),
      new TimeSeriesSteps( time: new DateTime(2019, 6, 13),   steps: 555),
      new TimeSeriesSteps( time: new DateTime(2019, 6, 14),   steps: 500),
      new TimeSeriesSteps( time: new DateTime(2019, 6, 15),   steps: 789),
      new TimeSeriesSteps( time: new DateTime(2019, 6, 16),   steps: 1000),
      new TimeSeriesSteps( time: new DateTime(2019, 6, 17),   steps: 900),
      new TimeSeriesSteps( time: new DateTime(2019, 6, 18),   steps: 800),
      new TimeSeriesSteps( time: new DateTime(2019, 6, 19),   steps: 1443),
      new TimeSeriesSteps( time: new DateTime(2019, 6, 20),   steps: 2000),
      new TimeSeriesSteps( time: new DateTime(2019, 6, 21),   steps: 911),
      new TimeSeriesSteps( time: new DateTime(2019, 6, 22),   steps: 3000),
      new TimeSeriesSteps( time: new DateTime(2019, 6, 23),   steps: 4000),
      new TimeSeriesSteps( time: new DateTime(2019, 6, 24),   steps: 3522),
      new TimeSeriesSteps( time: new DateTime(2019, 6, 25),   steps: 1500),
      new TimeSeriesSteps( time: new DateTime(2019, 6, 26),   steps: 900),
      new TimeSeriesSteps( time: new DateTime(2019, 6, 27),   steps: 5000),
      new TimeSeriesSteps( time: new DateTime(2019, 6, 28),   steps: 999),
      new TimeSeriesSteps( time: new DateTime(2019, 6, 29),   steps: 800),
      new TimeSeriesSteps( time: new DateTime(2019, 6, 30),   steps: 900),
    ];

    return [
      new charts.Series<TimeSeriesSteps, DateTime>(
        id: 'Steps',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (TimeSeriesSteps sales, _) => sales.time,
        measureFn: (TimeSeriesSteps sales, _) => sales.steps,
        data: data,
      )
    ];
  }
}

///// Sample time series data type.
//class TimeSeriesSales {
//  final DateTime time;
//  final int sales;
//
//  TimeSeriesSales(this.time, this.sales);
//}