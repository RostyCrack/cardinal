import UIKit
import Flutter
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Coloca tu API Key aquí
        GMSServices.provideAPIKey("AIzaSyDymvq4vRKFAnBMT4LP68GrY2lvb7gg58k")

        // Registrar plugins de Flutter
        GeneratedPluginRegistrant.register(with: self)

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
