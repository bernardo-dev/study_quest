import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../widgets/app_drawer.dart';
import '../../providers/progress_provider.dart';
import '../../models/progress_data.dart';

class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  String selectedPage = 'Progresso';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProgressProvider>(context, listen: false).startTimer();
    });
  }

  @override
  void dispose() {
    Provider.of<ProgressProvider>(context, listen: false).stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress Chart'),
      ),
      drawer: AppDrawer(
        selectedPage: selectedPage,
        onItemSelected: (String page) {
          setState(() {
            selectedPage = page;
          });
        },
      ),
      body: Consumer<ProgressProvider>(
        builder: (context, progressProvider, child) {
          final double desiredStudyTime = progressProvider.getDesiredStudyTime(context);
          print(desiredStudyTime);
          return SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(
              plotBands: <PlotBand>[
                PlotBand(// Sua Meta de Estudos
                  start: desiredStudyTime,
                  end: desiredStudyTime - 0.008,
                  text: 'Meta de Estudo Diária',
                  color: Colors.green,
                  textStyle: TextStyle(color: Colors.green),
                  verticalTextAlignment: TextAnchor.end,
                  horizontalTextAlignment: TextAnchor.end,
                ),
                PlotBand(// Média dos Usuaários
                  start: 2,
                  end: 2 - 0.008,
                  text: 'Media dos Usuários',
                  color: Colors.red,
                  textStyle: TextStyle(color: Colors.red),
                  verticalTextAlignment: TextAnchor.end,
                  horizontalTextAlignment: TextAnchor.start,
                ),
              ],
            ),
            title: ChartTitle(text: 'Progresso de Estudo'),
            legend: Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CartesianSeries>[
              LineSeries<ProgressData, String>(
                dataSource: progressProvider.progressData,
                xValueMapper: (ProgressData data, _) => data.date,
                yValueMapper: (ProgressData data, _) => double.parse(data.timeSpent.toStringAsFixed(1)),
                name: 'Tempo de Estudo realizado',
                dataLabelSettings: DataLabelSettings(isVisible: true),
              ),
            ],
          );
        },
      ),
    );
  }
}

