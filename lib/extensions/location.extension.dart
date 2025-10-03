part of 'extensions.dart';

extension LocationExt on Location? {
  /// Tính khoảng cách giữa hai điểm tọa độ sử dụng công thức Haversine
  ///
  /// Công thức Haversine tính khoảng cách giữa hai điểm trên bề mặt Trái Đất
  /// dựa trên tọa độ vĩ độ và kinh độ.
  ///
  /// [other]: Vị trí điểm thứ hai để tính khoảng cách
  ///
  /// Returns: Khoảng cách tính bằng kilômét (km)
  ///
  /// Ví dụ:
  /// - location1.calculateDistanceTo(location2) -> 1.5 km
  /// - location1.calculateDistanceTo(null) -> 0.0
  double calculateDistanceTo(Location? other) {
    if (this == null || other == null) {
      return 0.0;
    }

    return _haversineDistance(
      this!.latitude,
      this!.longitude,
      other.latitude,
      other.longitude,
    );
  }

  /// Tính khoảng cách giữa hai điểm với tọa độ được cung cấp riêng biệt
  ///
  /// [lat2, lon2]: Tọa độ điểm thứ hai (vĩ độ, kinh độ)
  ///
  /// Returns: Khoảng cách tính bằng kilômét (km)
  ///
  /// Ví dụ:
  /// - location.calculateDistanceToCoordinates(10.762622, 106.670172) -> ~1.1
  double calculateDistanceToCoordinates(double lat2, double lon2) {
    if (this == null) {
      return 0.0;
    }

    return _haversineDistance(
      this!.latitude,
      this!.longitude,
      lat2,
      lon2,
    );
  }

  /// Tính khoảng cách và trả về chuỗi định dạng đẹp
  ///
  /// [other]: Vị trí điểm thứ hai để tính khoảng cách
  ///
  /// Returns: Chuỗi khoảng cách với đơn vị (km hoặc m)
  ///
  /// Ví dụ:
  /// - location1.formattedDistanceTo(location2) -> "1.1 km"
  /// - location1.formattedDistanceTo(nearbyLocation) -> "500 m"
  String formattedDistanceTo(Location? other) {
    final distance = calculateDistanceTo(other);

    if (distance < 1.0) {
      // Chuyển đổi km sang mét cho khoảng cách nhỏ
      final meters = (distance * 1000).round();
      return '$meters m';
    } else {
      // Giữ nguyên km cho khoảng cách lớn
      return '${distance.toStringAsFixed(1)} km';
    }
  }

  /// Kiểm tra xem vị trí có hợp lệ không
  ///
  /// Returns: true nếu vị trí hợp lệ, false nếu không
  ///
  /// Ví dụ:
  /// - location.isValid -> true
  /// - null.isValid -> false
  bool get isValid {
    if (this == null) {
      return false;
    }

    // Kiểm tra giới hạn tọa độ hợp lệ
    return this!.latitude >= -90 &&
        this!.latitude <= 90 &&
        this!.longitude >= -180 &&
        this!.longitude <= 180;
  }

  /// Chuyển đổi Location thành chuỗi tọa độ
  ///
  /// Returns: Chuỗi tọa độ theo format "lat,lon"
  ///
  /// Ví dụ:
  /// - location.toCoordinateString() -> "10.762622,106.660172"
  String toCoordinateString() {
    if (this == null) {
      return '';
    }

    return '${this!.latitude},${this!.longitude}';
  }

  /// Tạo Location từ chuỗi tọa độ
  ///
  /// [coordinateString]: Chuỗi tọa độ theo format "lat,lon"
  ///
  /// Returns: Location object hoặc null nếu không hợp lệ
  ///
  /// Ví dụ:
  /// - Location.fromCoordinateString("10.762622,106.660172") -> Location object
  /// - Location.fromCoordinateString("invalid") -> null
  static Location? fromCoordinateString(String coordinateString) {
    try {
      final parts = coordinateString.split(',');
      if (parts.length != 2) {
        return null;
      }

      final lat = double.tryParse(parts[0].trim());
      final lon = double.tryParse(parts[1].trim());

      if (lat == null || lon == null) {
        return null;
      }

      // Kiểm tra giới hạn tọa độ hợp lệ
      if (lat < -90 || lat > 90 || lon < -180 || lon > 180) {
        return null;
      }

      return Location(
        latitude: lat,
        longitude: lon,
        timestamp: DateTime.now(),
      );
    } catch (e) {
      return null;
    }
  }

  /// Tính khoảng cách sử dụng công thức Haversine
  ///
  /// Công thức Haversine:
  /// a = sin²(Δφ/2) + cos φ1 ⋅ cos φ2 ⋅ sin²(Δλ/2)
  /// c = 2 ⋅ atan2(√a, √(1−a))
  /// d = R ⋅ c
  ///
  /// Trong đó:
  /// - φ1, φ2: vĩ độ của điểm 1 và 2
  /// - Δφ: hiệu vĩ độ
  /// - Δλ: hiệu kinh độ
  /// - R: bán kính Trái Đất (6371 km)
  ///
  /// Returns: Khoảng cách tính bằng kilômét (km)
  double _haversineDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const double earthRadius = 6371.0; // Bán kính Trái Đất (km)

    // Chuyển đổi độ sang radian
    final lat1Rad = _degreesToRadians(lat1);
    final lon1Rad = _degreesToRadians(lon1);
    final lat2Rad = _degreesToRadians(lat2);
    final lon2Rad = _degreesToRadians(lon2);

    // Tính hiệu vĩ độ và kinh độ
    final deltaLat = lat2Rad - lat1Rad;
    final deltaLon = lon2Rad - lon1Rad;

    // Công thức Haversine
    final a = sin(deltaLat / 2) * sin(deltaLat / 2) +
        cos(lat1Rad) * cos(lat2Rad) * sin(deltaLon / 2) * sin(deltaLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Khoảng cách
    return earthRadius * c;
  }

  /// Chuyển đổi độ sang radian
  ///
  /// [degrees]: Góc tính bằng độ
  /// Returns: Góc tính bằng radian
  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180.0);
  }
}
