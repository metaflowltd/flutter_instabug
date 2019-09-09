import Flutter
import UIKit
import Instabug


extension IBGInvocationEvent{
    static func fromString(invocationEventString:String) -> IBGInvocationEvent {
        switch invocationEventString{
        case "screenshot":
            return IBGInvocationEvent.screenshot
        case "floatingButton":
            return IBGInvocationEvent.floatingButton
        case "shake":
            return IBGInvocationEvent.shake
        case "twoFingersSwipeLeft":
            return IBGInvocationEvent.twoFingersSwipeLeft
        case "rightEdgePan":
            return IBGInvocationEvent.rightEdgePan
        default:
            return IBGInvocationEvent.screenshot
        }
    }
}

public class SwiftFlutterInstabugPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_instabug", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterInstabugPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "startInstabug" {
            self.startInstabug(call, result: result)
        } else if call.method == "identifyUser"{
            self.identifyUser(call, result: result)
        } else if (call.method == "isOn") {
            guard let  params = call.arguments as? Dictionary<String, Bool> else {
                result(FlutterError(code: "Missing arguments", message: nil, details: nil))
                return
            }
            let turnOn = params["isOn"] ?? true
            if turnOn { Instabug.setInvocationEvent(IBGInvocationEvent.screenshot) } else { Instabug.setInvocationEvent(IBGInvocationEvent.none) }
            
        } else{
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func startInstabug(_ call: FlutterMethodCall, result: @escaping FlutterResult){
        guard let params = call.arguments as? Dictionary<String,String> else {
            result(FlutterError(code: "Missing arguments", message: nil, details: nil))
            return
        }
        
        guard let token = params["token"] else {
            result(FlutterError(code: "Missing arguments", message: "Missing Instabug token", details: nil))
            return
        }
        
        var invocationEvent = IBGInvocationEvent.screenshot
        if let invocationEventString = params["invocationEvent"]{
            invocationEvent = IBGInvocationEvent.fromString(invocationEventString: invocationEventString)
        }
        
        Instabug.start(withToken: token, invocationEvent: invocationEvent)
        result("Instabug started")
    }
    
    private func identifyUser(_ call: FlutterMethodCall, result: @escaping FlutterResult){
        guard let params = call.arguments as? Dictionary<String,String> else {
            result(FlutterError(code: "Missing arguments", message: nil, details: nil))
            return
        }
        
        guard let email = params["email"] else {
            result(FlutterError(code: "Missing arguments", message: "Missing user email", details: nil))
            return
        }
        
        let name = params["name"]
        Instabug.identifyUser(withEmail: email, name: name)
        
        result("Instabug user identified")
    }
    
}
