import 'package:injectable/injectable.dart';
// import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

@module
abstract class SlidingPanelControllerModule {
  @singleton
  PanelController get panelController => _getPanelController();

  PanelController _getPanelController() {
    PanelController panelController = PanelController();
    return panelController;
  }
}
