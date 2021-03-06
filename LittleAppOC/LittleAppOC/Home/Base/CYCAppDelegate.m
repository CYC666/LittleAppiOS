//
//  CYCAppDelegate.m
//  LittleAppOC
//
//  Created by CaoYicheng on 2017/1/15.
//  Copyright © 2017年 CYC. All rights reserved.
//

#import "CYCAppDelegate.h"
#import "CYCTabBarController.h"
#import "CYCLeftController.h"
#import "MMDrawerController.h"
#import "ThemeManager.h"
#import "PasswordController.h"
#import "CYCTouchIDController.h"
#import <SMS_SDK/SMSSDK.h>
#import "CYCLoginController.h"
#import <AVFoundation/AVFoundation.h>

@interface CYCAppDelegate ()
@end

@implementation CYCAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 判断是否已经存在登录之后的手机号，如果不存在，那么显示短信登录界面
    if ([CUSER objectForKey:CUserPhone]) {
        
        if ([CUSER boolForKey:CTouchID]) {
            
            // 如果需要touchID，那么显示验证touchID界面，不需要输入密码
            CYCTouchIDController *controller = [[CYCTouchIDController alloc] init];
            self.window.rootViewController = controller;
            
        
        } else {
            
            // 判断本地是否存有进入App的密码，如果有那就进入输入密码页面
            if ([CUSER objectForKey:CPassword]) {
                PasswordController *controller = [[PasswordController alloc] init];
                controller.controllerType = PasswordControllerGoIn;
                self.window.rootViewController = controller;
                
                
            } else {
            
                _mainController = [[MMDrawerController alloc] initWithCenterViewController:[[CYCTabBarController alloc] init]
                                                                  leftDrawerViewController:[[CYCLeftController alloc] init]];
                _mainController.maximumLeftDrawerWidth = cLeftControllerWidth;
                _mainController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
                _mainController.closeDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
                self.window.rootViewController = _mainController;

            
            }
            
            
        }
        
    } else {
        self.window.rootViewController = [[CYCLoginController alloc] init];
    }

    [self.window makeKeyAndVisible];
    
    // 允许后台使用扬声器播放
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    
    // 开启接收远程控制
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    // 是否禁止屏幕自动锁屏
    if ([CUSER boolForKey:CLockScreen]) {

        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    } else {

        [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    }
    
    // 变暗
    if ([CUSER boolForKey:CDarkScreen]) {
        
        [UIView animateWithDuration:1.0f animations:^{
            [UIApplication sharedApplication].delegate.window.alpha = 0.2;
        } completion:^(BOOL finished) {
            
        }];
    } else {
        
        [UIView animateWithDuration:1.0f animations:^{
            [UIApplication sharedApplication].delegate.window.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // 进入后台之后，就把主窗口设置为输入密码的窗口，那样的话就不会在下次显示的时候先显示tabbar
    if ([CUSER objectForKey:CPassword]) {
        PasswordController *controller = [[PasswordController alloc] init];
        controller.controllerType = PasswordControllerGoIn;
        self.window.rootViewController = controller;
    }
    // 不能在这里设置这个，不然程序永远不能杀死
//    else if ([CUSER boolForKey:CTouchID]) {
//        CYCTouchIDController *controller = [[CYCTouchIDController alloc] init];
//        self.window.rootViewController = controller;
//    }
    // 如果没有设置密码，那么久没必要去操作了
    
    
}



- (void)applicationWillEnterForeground:(UIApplication *)application {


    
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    

    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


// 处理接收到远程控制的方法,并在发送接收到远程控制的通知。
-(void)remoteControlReceivedWithEvent:(UIEvent *)event {

    if(event.type==UIEventTypeRemoteControl) {
        
        NSInteger order=-1;
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlPause:
                order=UIEventSubtypeRemoteControlPause;
                break;
            case UIEventSubtypeRemoteControlPlay:
                order=UIEventSubtypeRemoteControlPlay;
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                order=UIEventSubtypeRemoteControlNextTrack;
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                order=UIEventSubtypeRemoteControlPreviousTrack;
                break;
            case UIEventSubtypeRemoteControlTogglePlayPause:
                order=UIEventSubtypeRemoteControlTogglePlayPause;
                break;
            default:
                order=-1;
                break;
        }
        NSDictionary *orderDict=@{@"order":@(order)};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kAppDidReceiveRemoteControlNotification" object:nil userInfo:orderDict];
    }

}
































@end
