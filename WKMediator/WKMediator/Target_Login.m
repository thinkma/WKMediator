//
//  Target_Login.m
//  WKMediator
//
//  Created by ma wei on 2018/12/30.
//  Copyright © 2018年 ma wei. All rights reserved.
//

#import "Target_Login.h"
#import "LoginViewController.h"
#import "CallBackViewController.h"

@implementation Target_Login

- (UIViewController *)Action_LoginViewController:(NSDictionary *)params
{
    LoginViewController * newVC = [[LoginViewController alloc] initWithParames:params];
    return newVC;
}


- (UIViewController *)Action_CallBackViewController:(NSDictionary *)params
{
    CallBackViewController * newVC = [[CallBackViewController alloc] initWithParames:params];
    return newVC;
}

@end
