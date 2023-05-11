import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/ticker_page/ticker_page_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'market_page_model.dart';
export 'market_page_model.dart';

class MarketPageWidget extends StatefulWidget {
  const MarketPageWidget({Key? key}) : super(key: key);

  @override
  _MarketPageWidgetState createState() => _MarketPageWidgetState();
}

class _MarketPageWidgetState extends State<MarketPageWidget> {
  late MarketPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MarketPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.apiResultn93 = await StockCall.call();
      if ((_model.apiResultn93?.succeeded ?? true)) {
        await SharesTable().update(
          data: {
            'bonds': getJsonField(
              (_model.apiResultn93?.jsonBody ?? ''),
              r'''$.data.securities[:].code''',
            ),
          },
          matchingRows: (rows) => rows.eq(
            'id',
            1,
          ),
        );
      }
    });

    _model.textController ??= TextEditingController();
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

    return FutureBuilder<List<SharesRow>>(
      future: SharesTable().querySingleRow(
        queryFn: (q) => q.eq(
          'id',
          1,
        ),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50.0,
              height: 50.0,
              child: CircularProgressIndicator(
                color: FlutterFlowTheme.of(context).primary,
              ),
            ),
          );
        }
        List<SharesRow> marketPageSharesRowList = snapshot.data!;
        final marketPageSharesRow = marketPageSharesRowList.isNotEmpty
            ? marketPageSharesRowList.first
            : null;
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 40.0, 8.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Container(
                            width: 100.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: TextFormField(
                              controller: _model.textController,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Поиск',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 14.0,
                                ),
                              ),
                              style: FlutterFlowTheme.of(context).bodyMedium,
                              validator: _model.textControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: 436.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5.0, 5.0, 5.0, 10.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Все тикеры',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Builder(
                                              builder: (context) {
                                                final ticker =
                                                    marketPageSharesRow?.bonds
                                                            ?.toList() ??
                                                        [];
                                                return ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: ticker.length,
                                                  itemBuilder:
                                                      (context, tickerIndex) {
                                                    final tickerItem =
                                                        ticker[tickerIndex];
                                                    return Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5.0,
                                                                  5.0,
                                                                  5.0,
                                                                  5.0),
                                                      child: InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TickerPageWidget(
                                                                ticker: marketPageSharesRow!
                                                                    .bonds[
                                                                        tickerIndex]
                                                                    .toString(),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                          width: 50.0,
                                                          height: 75.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                blurRadius: 3.0,
                                                                color: Color(
                                                                    0x33000000),
                                                                offset: Offset(
                                                                    0.0, 1.0),
                                                              )
                                                            ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      AutoSizeText(
                                                                    tickerItem
                                                                        .toString(),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 100.0,
                                                                  child:
                                                                      VerticalDivider(
                                                                    thickness:
                                                                        1.0,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .accent4,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        300.0,
                                                                    height:
                                                                        300.0,
                                                                    child:
                                                                        FlutterFlowLineChart(
                                                                      data: [
                                                                        FFLineChartData(
                                                                          xData:
                                                                              FFAppState().xx,
                                                                          yData:
                                                                              FFAppState().yy,
                                                                          settings:
                                                                              LineChartBarData(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).info,
                                                                            barWidth:
                                                                                1.0,
                                                                            isCurved:
                                                                                true,
                                                                            dotData:
                                                                                FlDotData(show: false),
                                                                            belowBarData:
                                                                                BarAreaData(
                                                                              show: true,
                                                                              color: Color(0x901C4494),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                      chartStylingInfo:
                                                                          ChartStylingInfo(
                                                                        backgroundColor:
                                                                            FlutterFlowTheme.of(context).secondaryBackground,
                                                                        showGrid:
                                                                            true,
                                                                        showBorder:
                                                                            false,
                                                                      ),
                                                                      axisBounds:
                                                                          AxisBounds(),
                                                                      xAxisLabelInfo:
                                                                          AxisLabelInfo(),
                                                                      yAxisLabelInfo:
                                                                          AxisLabelInfo(),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
