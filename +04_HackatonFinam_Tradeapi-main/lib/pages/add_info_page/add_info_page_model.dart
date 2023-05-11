import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/login_page/login_page_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddInfoPageModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for fName widget.
  TextEditingController? fNameController;
  String? Function(BuildContext, String?)? fNameControllerValidator;
  // State field(s) for lName widget.
  TextEditingController? lNameController;
  String? Function(BuildContext, String?)? lNameControllerValidator;
  // State field(s) for ChoiceChips widget.
  String? choiceChipsValue;
  FormFieldController<List<String>>? choiceChipsValueController;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    fNameController?.dispose();
    lNameController?.dispose();
  }

  /// Additional helper methods are added here.

}
