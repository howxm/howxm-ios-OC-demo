#import "ViewController.h"
#import "Howxm/Howxm-Swift.h"

@interface ViewController ()
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    Howxm *howxm = [[Howxm alloc] init];
    [self initCallbacks:howxm];

    howxm.logLevel = LoggerDebug;

    NSLog(@"Initialized: %@", [howxm checkInitialized] ? @"true" : @"false");

    UIViewController *rootViewController = [self getRootViewController];
    [howxm initializeSDK:@"5a406af5-5caa-44f5-b477-95b5d1e5ed9f" :rootViewController :^{
        NSLog(@"initializeSDK success");
        NSLog(@"Initialized: %@", [howxm checkInitialized] ? @"true" : @"false");

        Customer *customer = [[Customer alloc] init:@"uid_001" :@"zuos" :@"zuos@howxm.com" :@"13000000000" :nil];
        [howxm identify:customer :^{
            NSLog(@"identify success");
            [howxm checkOpen:@"8d6d3fb38515f3a966017cd530696bc1" :nil :^{
                NSLog(@"checkOpen success");
            } :^{
                NSLog(@"checkOpen failed");
            }];
            // [howxm open:@"8d6d3fb38515f3a966017cd530696bc1" :nil :nil :nil];
            [howxm event:@"test" :@{@"a": @"1", @"b": @2} :nil :nil :nil];
        } :^{
            NSLog(@"identify failed");
        }];
    } :nil];
}

- (void)initCallbacks:(Howxm *)howxm {

    [howxm onBeforeOpen:^(NSString *_Nonnull campaignId, NSString *_Nullable uid, NSDictionary<NSString *, id> *_Nullable extraAttributes) {
        NSLog(@"onBeforeOpen campaignId: %@", campaignId);
        NSLog(@"onBeforeOpen uid: %@", uid);
        NSLog(@"onBeforeOpen extraAttributes: %@", extraAttributes);
    }];

    [howxm onOpen:^(NSString *_Nonnull campaignId, NSString *_Nullable uid, NSDictionary<NSString *, id> *_Nullable extraAttributes) {
        NSLog(@"onOpen campaignId: %@", campaignId);
        NSLog(@"onOpen uid: %@", uid);
        NSLog(@"onOpen extraAttributes: %@", extraAttributes);
    }];

    [howxm onClose:^(NSString *_Nonnull campaignId, NSString *_Nullable uid) {
        NSLog(@"onClose campaignId: %@", campaignId);
        NSLog(@"onClose uid: %@", uid);
    }];

    [howxm onPageComplete:^(NSString *_Nonnull campaignId, NSString *_Nullable uid, NSArray *_Nonnull fieldEntries) {
        NSLog(@"onPageComplete campaignId: %@", campaignId);
        NSLog(@"onPageComplete uid: %@", uid);
        NSLog(@"onPageComplete fieldEntries: %@", fieldEntries);
    }];

    [howxm onComplete:^(NSString *_Nonnull campaignId, NSString *_Nullable uid) {
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
