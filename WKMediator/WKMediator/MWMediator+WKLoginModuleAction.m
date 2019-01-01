//
//  MWMediator+WKLoginModuleAction.m
//  WKMediator
//
//  Created by ma wei on 2018/12/30.
//  Copyright © 2018年 ma wei. All rights reserved.
//

#import "MWMediator+WKLoginModuleAction.h"

NSString * const kWKLoginMediatorTargetA = @"Login";
NSString * const kWKLoginMediatorActionLoginViewController = @"LoginViewController";
NSString * const kWKCallBackMediatorActionLoginViewController = @"CallBackViewController";



@implementation MWMediator (WKLoginModuleAction)

- (UIViewController *)JiaMediator_login_viewControllerForLogin
{
    return [self JiaMediator_login_viewControllerForLoginParame:nil];
}

- (UIViewController *)JiaMediator_login_viewControllerForLoginParame:(NSDictionary *)params
{
    UIViewController * ViewC = [self performTarget:kWKLoginMediatorTargetA action:kWKLoginMediatorActionLoginViewController params:params];
    if ([ViewC isKindOfClass:[UIViewController class]]) {
        return ViewC;
    }else{
        return [UIViewController new];
    }
}

@end
