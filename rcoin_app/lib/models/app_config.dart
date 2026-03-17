import 'dart:convert';
import 'dart:developer';

void tryCatch(Function? f) {
  try {
    f?.call();
  } catch (e, stack) {
    log('$e');
    log('$stack');
  }
}

class FFConvert {
  FFConvert._();
  static T? Function<T extends Object?>(dynamic value) convert =
  <T>(dynamic value) {
    if (value == null) {
      return null;
    }
    return json.decode(value.toString()) as T?;
  };
}

T? asT<T extends Object?>(dynamic value, [T? defaultValue]) {
  if (value is T) {
    return value;
  }
  try {
    if (value != null) {
      final String valueS = value.toString();
      if ('' is T) {
        return valueS as T;
      } else if (0 is T) {
        return int.parse(valueS) as T;
      } else if (0.0 is T) {
        return double.parse(valueS) as T;
      } else if (false is T) {
        if (valueS == '0' || valueS == '1') {
          return (valueS == '1') as T;
        }
        return (valueS == 'true') as T;
      } else {
        return FFConvert.convert<T>(value);
      }
    }
  } catch (e, stackTrace) {
    log('asT<$T>', error: e, stackTrace: stackTrace);
    return defaultValue;
  }

  return defaultValue;
}

class AppConfig {
  AppConfig({
    required this.appkey,
    required this.clientcer,
    required this.clientkey,
    required this.clientp12,
    required this.endpoints,
    required this.version,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) => AppConfig(
    appkey: asT<String>(json['appKey'])!,
    clientcer: asT<String>(json['clientCer'])!,
    clientkey: asT<String>(json['clientKey'])!,
    clientp12: asT<String>(json['clientP12'])!,
    endpoints:
    Endpoints.fromJson(asT<Map<String, dynamic>>(json['endpoints'])!),
    version: asT<String>(json['version'])!,
  );

  String appkey;
  String clientcer;
  String clientkey;
  String clientp12;
  Endpoints endpoints;
  String version;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'appKey': appkey,
    'clientCer': clientcer,
    'clientKey': clientkey,
    'clientP12': clientp12,
    'endpoints': endpoints,
    'version': version,
  };
}

class Endpoints {
  Endpoints({
    required this.http,
    required this.tcp,
  });

  factory Endpoints.fromJson(Map<String, dynamic> json) => Endpoints(
    http: Http.fromJson(asT<Map<String, dynamic>>(json['http'])!),
    tcp: Tcp.fromJson(asT<Map<String, dynamic>>(json['tcp'])!),
  );

  Http http;
  Tcp tcp;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'http': http,
    'tcp': tcp,
  };
}

class Http {
  Http({
    required this.ip,
    required this.dns,
  });

  factory Http.fromJson(Map<String, dynamic> json) {
    final List<String>? ip = json['ip'] is List ? <String>[] : null;
    if (ip != null) {
      for (final dynamic item in json['ip']!) {
        if (item != null) {
          tryCatch(() {
            ip.add(asT<String>(item)!);
          });
        }
      }
    }

    final List<Object>? dns = json['dns'] is List ? <Object>[] : null;
    if (dns != null) {
      for (final dynamic item in json['dns']!) {
        if (item != null) {
          tryCatch(() {
            dns.add(asT<Object>(item)!);
          });
        }
      }
    }
    return Http(
      ip: ip!,
      dns: dns!,
    );
  }

  List<String> ip;
  List<Object> dns;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'ip': ip,
    'dns': dns,
  };
}

class Tcp {
  Tcp({
    required this.ip,
    required this.dns,
  });

  factory Tcp.fromJson(Map<String, dynamic> json) {
    final List<String>? ip = json['ip'] is List ? <String>[] : null;
    if (ip != null) {
      for (final dynamic item in json['ip']!) {
        if (item != null) {
          tryCatch(() {
            ip.add(asT<String>(item)!);
          });
        }
      }
    }

    final List<Object>? dns = json['dns'] is List ? <Object>[] : null;
    if (dns != null) {
      for (final dynamic item in json['dns']!) {
        if (item != null) {
          tryCatch(() {
            dns.add(asT<Object>(item)!);
          });
        }
      }
    }
    return Tcp(
      ip: ip!,
      dns: dns!,
    );
  }

  List<String> ip;
  List<Object> dns;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'ip': ip,
    'dns': dns,
  };
}
