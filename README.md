# howxm-ios-OC-demo

> OC项目调用SDK代码示例

## 1.安装sdk，建议使用pod安装, 详情参考：https://howxm.com/help/articles/ios-x-sdk
> pod 'Howxm', '版本号'

## 2.代码中调用SDK接口, 更多示例参考 - [ViewController.m](OCDemo/ViewController.m)
```objective-c++
[Howxm initializeSDK:@"your appId" :rootViewController :^{
        NSLog(@"initializeSDK success");
        NSLog(@"Initialized: %@", [Howxm checkInitialized] ? @"true" : @"false");

        [self initCallbacks];

        Customer *customer = [[Customer alloc] init:@"uid_001" :@"张三" :@"zhangsan@howxm.com" :@"13000000000" :nil];
        [Howxm identify:customer :^{
            NSLog(@"identify success");
            [Howxm checkOpen:@"your campaignId" :nil :^{
                NSLog(@"checkOpen success");
            } :^{
                NSLog(@"checkOpen failed");
            }];
            [Howxm event:@"payment_click" :@{@"price": @100} :nil :nil :nil];
        } :^{
            NSLog(@"identify failed");
        }];
    } :nil];
```

- 弹出效果 (系统启动后会自动弹出)
![img.png](img.png)