import UIKit
import Flutter
import Firebase
import UserNotifications
import OneSignal
import flutter_local_notifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // init Firebase
        FirebaseApp.configure()
        
        // init Firebase Messaging
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        }
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { granted, error in
            if let error = error {
                print("Error requesting notification authorization: \(error.localizedDescription)")
            }
        }
        application.registerForRemoteNotifications()
        
        //init OneSignal
        OneSignal.initWithLaunchOptions(launchOptions)
        OneSignal.setAppId("f4e6a025-6215-4347-a1ad-0aab33f2260e")
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
        })
        OneSignal.setNotificationOpenedHandler { result in
            if let additionalData = result.notification.additionalData {
                print("OneSignal additionalData: \(additionalData)")
            }
        }
        
        //init flutter_local_notifications
        setupFlutterLocalNotifications()
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func setupFlutterLocalNotifications() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error requesting flutter_local_notifications authorization: \(error.localizedDescription)")
            }
        }
    }
    
    override func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        Messaging.messaging().apnsToken = deviceToken
        
        OneSignal.setDeviceToken(deviceToken)
        
        super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
}
