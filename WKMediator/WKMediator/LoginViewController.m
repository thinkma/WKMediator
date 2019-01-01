//
//  LoginViewController.m
//  WKMediator
//
//  Created by ma wei on 2018/12/30.
//  Copyright © 2018年 ma wei. All rights reserved.
//

#import "LoginViewController.h"
#import "MWMediatorNavigator.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"init Login");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Login";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(20, 200, 200, 30)];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * buttonlogin = [[UIButton alloc] initWithFrame:CGRectMake(20, 400, 200, 30)];
    buttonlogin.backgroundColor = [UIColor redColor];
    [self.view addSubview:buttonlogin];
    [buttonlogin setTitle:@"登陆" forState:UIControlStateNormal];
    [buttonlogin addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];


    // Do any additional setup after loading the view.
}

- (void)login
{
    UIViewController * vc =  [[MWMediator sharedInstance] performActionWithUrl:[NSURL URLWithString:@"wkScheme://Login/LoginViewController"] withParams:nil completion:^(NSDictionary *info) {
    }];
    
    
    
    // 当BaseViewController = nil 时候， 用 rootViewController 进行跳转。
    [[MWMediatorNavigator navigator] showURLController:vc baseViewController:nil routeMode:NavigationModePush];

    
}

//- (void)back
//{
//    if (self.presentingViewController) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    } else {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
