//
//  MWMediator+WKLoginModuleAction.h
//  WKMediator
//
//  Created by ma wei on 2018/12/30.
//  Copyright © 2018年 ma wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWMediator.h"



@interface MWMediator (WKLoginModuleAction)

- (UIViewController *)JiaMediator_login_viewControllerForLogin;

- (UIViewController *)JiaMediator_login_viewControllerForLoginParame:(NSDictionary *)params;


@end


