import 'package:date_format/date_format.dart';

class DateTimeFormat {
  /// **[HH, ':', nn, ' - ', dd, '/', mm, '/', yyyy]**
  ///
  /// **10:59 - 01/01/2000**
  final HHnnddmmyyyy = [HH, ':', nn, ' - ', dd, '/', mm, '/', yyyy];

  /// **[HH, ':', nn, ' ', dd, '/', mm, '/', yyyy]**
  ///
  /// **01/01/2000 10:59**
  final ddmmyyyyHHnn = [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn];

  /// **[dd, '/', mm, '/', yyyy, ' ', HH, ':', nn, ':', ss]**
  ///
  /// **01/01/2000 10:59:59**
  final ddmmyyyyHHnnss = [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn, ':', ss];

  /// **[yyyy, '-', mm, '-', dd, ' ', HH, ':', nn]**
  ///
  /// **01/01/2000 10:59**
  final yyyymmddHHnn = [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn];

  /// **[HH, ':', nn]**
  ///
  /// **10:59**
  final timeFormat = [HH, ':', nn];

  /// **[D, ', ', dd, '/', mm, '/', yyyy]**
  ///
  /// **Tue, 01/01/2000**
  final Dddmmyyyy = [D, ', ', dd, '/', mm, '/', yyyy];

  /// **[yyyy, '/', mm, '/', dd]**
  ///
  /// **2000/01/01**
  final yyyymmdd = [yyyy, '/', mm, '/', dd];

  /// **[dd, '/', mm, '/', yyyy]**
  ///
  /// **01/01/2000**
  final ddmmyyyy = [dd, '/', mm, '/', yyyy];

  /// **[yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]**
  ///
  /// **2000-01-01 10:59:59**
  final yyyymmddHHnnss = [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss];

  /// **[HH, ':', nn, ', ', dd, '/', mm, '/', yyyy]**
  ///
  /// **10:59, 01/01/2000**
  final HHnnddmmyyWithCommas = [HH, ':', nn, ', ', dd, '/', mm, '/', yyyy];

  /// **[D, '\n', dd]**
  ///
  /// **Tue**
  ///
  /// **01**
  final DAbovedd = [D, '\n', dd];

  /// **[mm, ' ', yyyy]**
  ///
  /// **01 2000**
  final mmSpaceyyyy = [mm, ' ', yyyy];

  /// **[yyyy, mm, dd, HH, nn, ss]**
  ///
  /// **20001225105959**
  final yyyymmddHHnnssWithoutSeparate = [yyyy, mm, dd, HH, nn, ss];

  /// **[dd, mm, yyyy, HH, nn, ss]**
  ///
  /// **26072024105959**
  final ddmmyyyyHHnnssWithoutSeparate = [dd, mm, yyyy, HH, nn, ss];

  /// **[yyyy-mm]**
  ///
  /// **2024-07**
  final yyyyDashmm = [yyyy, '-', mm];

  /// **[yyyy-mm-dd]**
  ///
  /// **2024-07-31**
  final yyyyDashmmDashdd = [yyyy, '-', mm, '-', dd];

  /// **[dd-mm-yyyy]**
  ///
  /// **31-07-2024**
  final ddDashmmDashyyyy = [dd, '-', mm, '-', yyyy];

  /// **[HH:nn:ss]**
  ///
  /// **10:59:59**
  final HHmmss = [HH, ':', nn, ':', ss];

  /// **[Tháng mm, yyyy]**
  /// **Tháng 01, 2024**
  final mmCommayyyy = ['Tháng ', mm, ',', yyyy];
}
