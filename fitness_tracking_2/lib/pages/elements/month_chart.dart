/// Example of a time series chart with a confidence interval.
///
/// Confidence interval is defined by specifying the upper and lower measure
/// bounds in the series.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class MonthSeriesConfidenceInterval extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  MonthSeriesConfidenceInterval(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory MonthSeriesConfidenceInterval.withSampleData() {
    return new MonthSeriesConfidenceInterval(
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
          month: new charts.TimeFormatterSpec(
            format: 'mm',
            transitionFormat: '',
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
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final data = [
      new TimeSeriesSales(new DateTime(2019, 06, 1), 0),
      new TimeSeriesSales(new DateTime(2019, 06, 12), 700),
      new TimeSeriesSales(new DateTime(2019, 06, 13), 800),
      new TimeSeriesSales(new DateTime(2019, 06, 14), 260),
      new TimeSeriesSales(new DateTime(2019, 06, 15), 500),
      new TimeSeriesSales(new DateTime(2019, 06, 30), 0),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        // When the measureLowerBoundFn and measureUpperBoundFn is defined,
        // the line renderer will render the area around the bounds.
        measureLowerBoundFn: (TimeSeriesSales sales, _) => sales.sales,
        measureUpperBoundFn: (TimeSeriesSales sales, _) => sales.sales + 5,
        data: data,
      )
    ];
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
