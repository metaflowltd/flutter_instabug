#import "FlutterInstabugPlugin.h"
#import <flutter_instabug/flutter_instabug-Swift.h>

@implementation FlutterInstabugPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterInstabugPlugin registerWithRegistrar:registrar];
}
@end
