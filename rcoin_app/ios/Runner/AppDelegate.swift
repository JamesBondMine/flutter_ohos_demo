import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      // 存储数据
      let defaults = UserDefaults.standard
      defaults.set("", forKey: "scheme")
      defaults.synchronize() // 确保数据立即写入
      
      configureFlutterEngine()
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // 存储数据
        let defaults = UserDefaults.standard
        defaults.set("", forKey: "scheme")
        defaults.synchronize() // 确保数据立即写入
        if ((url.query != nil) && ((url.query?.contains("paynopay")) != nil)) {
            defaults.set(url.query, forKey: "scheme")
            defaults.synchronize() // 确保数据立即写入
        }
        return true;
    }
    
    func configureFlutterEngine() {
        // 创建Flutter引擎并运行应用
        let controller: FlutterViewController = window.rootViewController as! FlutterViewController ;
        let channel = FlutterMethodChannel(name: "flutterNativeChannel", binaryMessenger: controller.binaryMessenger)
        channel.setMethodCallHandler({ [self]
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          if call.method == "schemeQuery" {
              let defaults = UserDefaults.standard;
              let info = defaults.string(forKey: "scheme")
              delayClearCodeData()
              result(info);
          } else {
            // 如果方法未知，返回一个错误
            result(FlutterMethodNotImplemented)
          }
        })
      }
    
    func delayClearCodeData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let defaults = UserDefaults.standard
            defaults.set("", forKey: "scheme")
            defaults.synchronize() // 确保数据立即写入
        }
    }
}
