#import "ViewController.h"
#import "Howxm/Howxm-Swift.h"

@interface ViewController ()
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    Howxm.logLevel = LoggerDebug;

    NSLog(@"Initialized: %@", [Howxm checkInitialized] ? @"true" : @"false");

    UIViewController *rootViewController = [self getRootViewController];
    [Howxm initializeSDK:@"5ed93d69-7f44-44a7-8769-f8ad131a2010" :rootViewController :^{
        NSLog(@"initializeSDK success");
        NSLog(@"Initialized: %@", [Howxm checkInitialized] ? @"true" : @"false");

        [self initCallbacks];

        Customer *customer = [[Customer alloc] init:@"uid_001" :@"张三" :@"zhangsan@howxm.com" :@"13000000000" :@{@"age": @18}];
        [Howxm identify:customer :^{
            NSLog(@"identify success");
            [Howxm checkOpen:@"6329d0091a5c789fb97eab345585fded" :@"uid_001" :^{
                NSLog(@"checkOpen success");
            } :^{
                NSLog(@"checkOpen failed");
            }];
            //[Howxm open:@"6329d0091a5c789fb97eab345585fded" :nil :nil :nil];
            [Howxm event:@"payment_click" :@{@"price": @100, @"channel": @"Objective-C"} :nil :^{
                NSLog(@"event success");
            } :^(NSString * _Nullable errorMessage) {
                NSLog(@"event failed: %@", errorMessage);
            }];
        } :^{
            NSLog(@"identify failed");
        }];
    } :nil];
}

- (void)initCallbacks {

    [Howxm onBeforeOpen:^(NSString *_Nonnull campaignId, NSString *_Nullable uid, NSDictionary<NSString *, id> *_Nullable extraAttributes) {
        NSLog(@"onBeforeOpen campaignId: %@", campaignId);
        NSLog(@"onBeforeOpen uid: %@", uid);
        NSLog(@"onBeforeOpen extraAttributes: %@", extraAttributes);
    }];

    [Howxm onOpen:^(NSString *_Nonnull campaignId, NSString *_Nullable uid, NSDictionary<NSString *, id> *_Nullable extraAttributes) {
        NSLog(@"onOpen campaignId: %@", campaignId);
        NSLog(@"onOpen uid: %@", uid);
        NSLog(@"onOpen extraAttributes: %@", extraAttributes);
    }];

    [Howxm onClose:^(NSString *_Nonnull campaignId, NSString *_Nullable uid) {
        NSLog(@"onClose campaignId: %@", campaignId);
        NSLog(@"onClose uid: %@", uid);
    }];

    [Howxm onPageComplete:^(NSString *_Nonnull campaignId, NSString *_Nullable uid, NSArray *_Nonnull fieldEntries) {
        NSLog(@"onPageComplete campaignId: %@", campaignId);
        NSLog(@"onPageComplete uid: %@", uid);
        NSLog(@"onPageComplete fieldEntries: %@", fieldEntries);
    }];

    [Howxm onComplete:^(NSString *_Nonnull campaignId, NSString *_Nullable uid) {
        NSLog(@"onComplete campaignId: %@", campaignId);
        NSLog(@"onComplete uid: %@", uid);
    }];
}

- (UIViewController *)getRootViewController {
    UIViewController *rootViewController = nil;
    if (@available(iOS 13.0, *)) {
        UIWindowScene *windowScene = (UIWindowScene *) [UIApplication sharedApplication].connectedScenes.allObjects.firstObject;
        rootViewController = windowScene.windows.firstObject.rootViewController;
    } else {
        rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    return rootViewController;
}
@end
