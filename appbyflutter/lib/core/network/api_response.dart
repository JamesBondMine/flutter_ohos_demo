/// 接口统一返回结构：code、msg、data
/// 使用 [ApiResponse.fromJson] 解析，[data] 可通过 [fromJsonData] 转为业务模型
class ApiResponse<T> {
  const ApiResponse({
    required this.code,
    required this.msg,
    this.data,
  });

  final int code;
  final String msg;
  final T? data;

  bool get isSuccess => code == 0;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json, [
    T Function(dynamic)? fromJsonData,
  ]) {
    final rawData = json['data'];
    T? data;
    if (rawData != null && fromJsonData != null) {
      data = fromJsonData(rawData);
    } else if (rawData != null) {
      data = rawData as T?;
    }

    return ApiResponse<T>(
      code: json['code'] as int? ?? -1,
      msg: json['msg'] as String? ?? '',
      data: data,
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'msg': msg,
        'data': data,
      };
}
