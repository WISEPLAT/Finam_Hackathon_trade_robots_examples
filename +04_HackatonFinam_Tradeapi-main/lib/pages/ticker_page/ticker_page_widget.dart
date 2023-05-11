import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'ticker_page_model.dart';
export 'ticker_page_model.dart';

class TickerPageWidget extends StatefulWidget {
  const TickerPageWidget({
    Key? key,
    required this.ticker,
  }) : super(key: key);

  final String? ticker;

  @override
  _TickerPageWidgetState createState() => _TickerPageWidgetState();
}

class _TickerPageWidgetState extends State<TickerPageWidget> {
  late TickerPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TickerPageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      width: 100.0,
                      height: 70.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondary,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(),
                              child: Icon(
                                Icons.chevron_left_outlined,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                size: 24.0,
                              ),
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            flex: 2,
                            child: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: Color(0x00FFFFFF),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: AutoSizeText(
                                      widget.ticker!,
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .displayMedium
                                          .override(
                                            fontFamily: 'Montserrat',
                                            color:
                                                (Theme.of(context).brightness ==
                                                            Brightness.dark) ==
                                                        true
                                                    ? Colors.white
                                                    : Colors.black,
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 10.0, 8.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(
                        width: 100.0,
                        height: 426.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 5.0, 10.0),
                          child: Container(
                            width: 300.0,
                            height: 316.0,
                            child: FlutterFlowLineChart(
                              data: [
                                FFLineChartData(
                                  xData: FFAppState().xx,
                                  yData: FFAppState().yy,
                                  settings: LineChartBarData(
                                    color: FlutterFlowTheme.of(context).info,
                                    barWidth: 1.0,
                                    isCurved: true,
                                    dotData: FlDotData(show: false),
                                    belowBarData: BarAreaData(
                                      show: true,
                                      color: Color(0x901C4494),
                                    ),
                                  ),
                                )
                              ],
                              chartStylingInfo: ChartStylingInfo(
                                backgroundColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                showGrid: true,
                                borderColor: Colors.black,
                                borderWidth: 1.0,
                              ),
                              axisBounds: AxisBounds(),
                              xAxisLabelInfo: AxisLabelInfo(),
                              yAxisLabelInfo: AxisLabelInfo(
                                showLabels: true,
                                labelTextStyle: GoogleFonts.getFont(
                                  'Roboto',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 8.0,
                                ),
                                labelInterval: 10.0,
                                labelFormatter: LabelFormatter(
                                  numberFormat: (val) => formatNumber(
                                    val,
                                    formatType: FormatType.decimal,
                                    decimalType: DecimalType.automatic,
                                    currency: '₽',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(flex: 3),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FFButtonWidget(
                      onPressed: () {
                        print('Button pressed ...');
                      },
                      text: 'Купить',
                      options: FFButtonOptions(
                        width: 180.0,
                        height: 70.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: Color(0xFF01833E),
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              fontFamily: 'Montserrat',
                              color:
                                  FlutterFlowTheme.of(context).primaryBtnText,
                              fontWeight: FontWeight.bold,
                            ),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    FFButtonWidget(
                      onPressed: () {
                        print('Button pressed ...');
                      },
                      text: 'Продать',
                      options: FFButtonOptions(
                        width: 180.0,
                        height: 70.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: Color(0xFF8C0021),
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              fontFamily: 'Montserrat',
                              color:
                                  FlutterFlowTheme.of(context).primaryBtnText,
                              fontWeight: FontWeight.bold,
                            ),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
