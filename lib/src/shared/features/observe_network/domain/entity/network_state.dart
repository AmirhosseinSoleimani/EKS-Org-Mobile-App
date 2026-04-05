
import 'network_type.dart';

class NetworkStatus {
  final NetworkType type;
  const NetworkStatus(this.type);

  bool get isAvailable => type != NetworkType.none;
  bool get isWifi => type == NetworkType.wifi;
  bool get isMobile => type == NetworkType.mobile;

}