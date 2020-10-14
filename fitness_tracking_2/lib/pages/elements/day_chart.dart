import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../entity/time_series.dart';

class TimeSeriesConfidenceInterval extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  TimeSeriesConfidenceInterval(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory TimeSeriesConfidenceInterval.withSampleData() {
    return new TimeSeriesConfidenceInterval(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
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
            format: 'hh:mm',
            transitionFormat: 'HH:mm',
          ),
        ),
      ),
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSteps, DateTime>> _createSampleData() {
    final data = [

      new TimeSeriesSteps(time: new DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day), steps: 0),
      new TimeSeriesSteps(time: new DateTime(2019, 6, 7, 14, 23, 23), steps: 160),
      new TimeSeriesSteps(time: new DateTime(2019, 6, 7, 18, 23, 23), steps: 25),
      new TimeSeriesSteps(time: new DateTime(2019, 6, 7, 22, 23, 23), steps:  100),
      new TimeSeriesSteps(time: new DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+1), steps: 0),

    ];

    return [
      new charts.Series<TimeSeriesSteps, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (TimeSeriesSteps sales, _) => sales.time,
        measureFn: (TimeSeriesSteps sales, _) => sales.steps,
        // When the measureLowerBoundFn and measureUpperBoundFn is defined,
        // the line renderer will render the area around the bounds.
        measureLowerBoundFn: (TimeSeriesSteps sales, _) => sales.steps,
        measureUpperBoundFn: (TimeSeriesSteps sales, _) => sales.steps + 5,
        data: data,
      )
    ];
  }
}


