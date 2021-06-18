//
//  BrokeBetsApp.swift
//  BrokeBets
//
//  Created by Todd Weidler on 2/5/21.
//

import SwiftUI
import Firebase
import GoogleSignIn




@main
struct BrokeBetsApp: App {
        
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
//    let appState = AppState()
    
    
    var body: some Scene {
        WindowGroup {
            
//            MainAppView(mainAppVM: MainAppVM(appState: appDelegate.appState))
//                .environmentObject(appDelegate.appState)
//                    .environmentObject(UserScreenInfo(getScreenSizeType()))
//                    .environment(\.colorScheme, .light)
//                    .preferredColorScheme(.light)
//
//            CreateUsernameView(viewModel: CreateUsernameVM(userService: appState.userService))
//                .environment(\.colorScheme, .light)
//
            RootAppView(rootAppVM: RootAppVM(appState: appDelegate.appState))
                .environmentObject(appDelegate.appState)
//                    .environmentObject(UserScreenInfo(getScreenSizeType()))
                    .environment(\.colorScheme, .light)
                    .preferredColorScheme(.light)

        }
    }
    
    func getScreenSizeType() -> ScreenSizeType {

        switch(UIDevice.current.name.trimmingCharacters(in: .whitespacesAndNewlines)){

        case "iPhone 6s": return .small
        case "iPhone SE (1st Generation)": return .xsmall
        case "iPhone SE (2nd Generation)": return .small
        case "iPhone 7": return .small
        case "iPhone 8": return .small
        case "iPod touch (7th Generation)": return .xsmall
        default: return .regular
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    
    let appState = AppState()
    
    private var gcmMessageIDKey = "gcm_message_idKey"
    static var fcmToken = String()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        appState.configure()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        registerForPushNotifications()
        
        return true
    }
    
    
    func registerForPushNotifications() {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, _ in
            print("Permission granted: \(granted)")
            guard granted else { return }
            self?.getNotificationSettings()
        }
    }
    
    
    func getNotificationSettings() {
        
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let token = deviceToken.hexString
        AppDelegate.fcmToken = token
        Messaging.messaging().apnsToken = deviceToken
        print("Device Token: \(token)")
        print("FCM Token: \(deviceToken)")
    }
    
    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        print("Failed to register: \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print("Just received remote notification:")
        print(userInfo)
        completionHandler(.newData)
    }
}


extension AppDelegate : UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        
        Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // get the notification type of the notification
        guard let str = userInfo["notificationType"] as? String, let notificationType = NotificationType(rawValue: str) else {
            print("Error: invalid notificationType")
            completionHandler(UNNotificationPresentationOptions.init(rawValue: 0))
            return
        }
        
        let tabsData = notificationType.getAssociatedLocation()
//        let mainTabInd = tabsData.mainTabInd
//        let subTabInd = tabsData.subTabInd
        
//        print("as main: \(self.appState.selectedMainTab)")
//        print("as sub: \(self.appState.selectedSubTab)")
//
//        print("cal main: \(mainTabInd)")
//        print("cal sub: \(subTabInd)")
        
        let curAppLocation = self.appState.currentAppLocation()
        
        if(curAppLocation == tabsData){
            print("User is already at the notification location so no foreground notification will be shown")
            completionHandler(UNNotificationPresentationOptions.init(rawValue: 0))
            return
        }
        
        
        // dont show notification in foreground if the user is already at the location that the notification would take them to if they were to press it
//        if(self.appState.selectedMainTab == mainTabInd && self.appState.selectedSubTab == subTabInd){
//            print("User is already at the notification location so no foreground notification will be shown")
//            completionHandler(UNNotificationPresentationOptions.init(rawValue: 0))
//            return
//        }
        
        print("Foreground notification will be shown")
        completionHandler([[.banner, .sound, .badge]])
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        
        Messaging.messaging().appDidReceiveMessage(userInfo)
        
        if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
            print("****** User opened notification ******")
            
            guard let str = userInfo["notificationType"] as? String, let notificationType = NotificationType(rawValue: str) else {
                print("Error: invalid notificationType")
                return
            }
            
            let tabsData = notificationType.getAssociatedLocation()
//            let mainTabInd = tabsData.mainTabInd
//            let subTabInd = tabsData.subTabInd
            
//            print("selectedMainTab: \(mainTabInd)")
//            print("selectedSubTab: \(subTabInd)")
            
//            self.appState.selectedMainTab = mainTabInd
//            self.appState.selectedSubTab = subTabInd
            
            self.appState.deepLink(to: tabsData)
            
        }
                
        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate {
        
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        let dataDict:[String: String] = ["token": fcmToken ?? ""]
        
        NotificationCenter.default.post(name: NSNotification.Name("FCMToken"), object: nil, userInfo: dataDict)

        AppDelegate.fcmToken = fcmToken ?? ""
        
        print(dataDict)
        
        
        // if the user is signed in
        if let userId = Auth.auth().currentUser?.uid, let token = fcmToken {

            let userFcmDocRef = Firestore.firestore().collection("user_fcm_tokens").document(userId)

            // add the token to the user's array of fcm tokens
            userFcmDocRef.updateData( ["tokens": FieldValue.arrayUnion([token])]){ (error) in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}


extension AppDelegate: GIDSignInDelegate {
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        
        if let error = error {
            print(error.localizedDescription)
            return
        }

        guard let authentication = user.authentication else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
         
        self.appState.userService?.authenticateWithFirebase(with: credential)

    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
    }
}



extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}


enum NotificationType: String {
    
    case new_invitation = "new_invitation" // w
    case draft_started = "draft_started" // synonymous with an invitation being accepted // w
    case user_draft_turn = "user_draft_turn" // whenever it is now the user's turn to draft
    case draft_completed = "draft_completed" // synonymous with an upcoming contest being created
    case draft_expired = "draft_expired"
    case invitation_rejected = "invitation_rejected" // w
    case sent_invitation_expired = "sent_invitation_expired" // w
    case rec_invitation_expired = "rec_invitation_expired" // w
    case contest_completed = "contest_completed"
}

extension NotificationType {
    
    func getAssociatedLocation() -> (mainTabInd: Int, subTabInd: Int){
        
        switch(self){
            case .new_invitation: return (1, 0)
            case .invitation_rejected: return (1, 1)
            case .draft_started: return (2, 0)
            case .draft_completed: return (0, 0)
            case .contest_completed: return (0, 2)
            case .user_draft_turn: return (2, 0)
            case .draft_expired: return (2, 0)
            case .sent_invitation_expired: return (1, 1)
            case .rec_invitation_expired: return (1, 0)
        }
    }
}
