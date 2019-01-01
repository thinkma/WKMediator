//
//  ViewController.m
//  WKMediator
//
//  Created by ma wei on 2018/12/30.
//  Copyright © 2018年 ma wei. All rights reserved.
//

#import "ViewController.h"
#import "MWMediator+WKLoginModuleAction.h"
#import "MWMediatorNavigator.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView * showTableView;
@property (nonatomic,strong)NSArray * dataSourceArr;



@property (nonatomic, copy) void (^textBlock)(NSString *msg);

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSourceArr = @[@"URL 跳转",@"URL+外部参数 跳转",@"URL+异步回调",@"URL 模态",@"root Push"];
    [self.view addSubview:self.showTableView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (UITableView *)showTableView
{
    if (!_showTableView) {
        _showTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _showTableView.delegate = self;
        _showTableView.dataSource = self;
    }
    return _showTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSourceArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellindex = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellindex];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellindex];
    }
    
    cell.textLabel.text = self.dataSourceArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    switch (row) {
        case 0:
            [self urlrouteJump];
            break;
        case 1:
            [self urlrouteJumpWithParame];
            break;
        case 2:
            [self urlrouteJumpWithCallBack];
            break;
        case 3:
            [self urlroutePresentWithParame];
            break;
        case 4:
            [self urlroutePresentWithRoot];
            break;
            
        default:
            break;
    }
}


- (void)urlrouteJump
{
    NSString * url = @"wkScheme://Login/LoginViewController?id=1234";
    UIViewController * vc = [[MWMediator sharedInstance] performActionWithUrl:[NSURL URLWithString:url] completion:^(NSDictionary *info) {
    }];
    [[MWMediatorNavigator navigator] showURLController:vc baseViewController:self routeMode:NavigationModePush];
}

- (void)urlrouteJumpWithParame
{
    NSString * url = @"wkScheme://Login/LoginViewController?id=1234";
    //  NSDictionary * dic = @{@"action":@"123",@"method":@"456"};
    NSMutableDictionary * doc = [NSMutableDictionary dictionary];
    [doc setObject:@"123" forKey:@"ede"];
    UIViewController * vc2 = [[MWMediator sharedInstance] performActionWithUrl:[NSURL URLWithString:url] withParams:doc completion:^(NSDictionary * _Nonnull info) {
        NSLog(@"info = %@",info);
    }];
    [[MWMediatorNavigator navigator] showURLController:vc2 baseViewController:self routeMode:NavigationModePush];
}

- (void)urlrouteJumpWithCallBack
{
    self.textBlock = ^(NSString *msg){
        NSLog(@"CallBackViewController控制器中返回值-------%@",msg);
    };
    NSString * url = @"wkScheme://Login/CallBackViewController?id=1234";
    //  NSDictionary * dic = @{@"action":@"123",@"method":@"456"};
    NSMutableDictionary * doc = [NSMutableDictionary dictionary];
    [doc setObject:@"123" forKey:@"ede"];
    [doc setObject:self.textBlock forKey:@"callback"];
    UIViewController * vc2 = [[MWMediator sharedInstance] performActionWithUrl:[NSURL URLWithString:url] withParams:doc completion:^(NSDictionary * _Nonnull info) {
        NSLog(@"info = %@",info);
    }];
    [[MWMediatorNavigator navigator] showURLController:vc2 baseViewController:self routeMode:NavigationModePush];
}

- (void)urlroutePresentWithParame
{
    NSString * url = @"wkScheme://Login/LoginViewController?id=1234";
    //  NSDictionary * dic = @{@"action":@"123",@"method":@"456"};
    NSMutableDictionary * doc = [NSMutableDictionary dictionary];
    [doc setObject:@"123" forKey:@"ede"];
    UIViewController * vc2 = [[MWMediator sharedInstance] performActionWithUrl:[NSURL URLWithString:url] withParams:doc completion:^(NSDictionary * _Nonnull info) {
        NSLog(@"info = %@",info);
    }];
    [[MWMediatorNavigator navigator] showURLController:vc2 baseViewController:self routeMode:NavigationModePresent];
}

- (void)urlroutePresentWithRoot
{
    NSString * url = @"wkScheme://Login/LoginViewController?id=1234";
    //  NSDictionary * dic = @{@"action":@"123",@"method":@"456"};
    NSMutableDictionary * doc = [NSMutableDictionary dictionary];
    [doc setObject:@"123" forKey:@"ede"];
    UIViewController * vc2 = [[MWMediator sharedInstance] performActionWithUrl:[NSURL URLWithString:url] withParams:doc completion:^(NSDictionary * _Nonnull info) {
        NSLog(@"info = %@",info);
    }];
    [[MWMediatorNavigator navigator] showURLController:vc2 baseViewController:self routeMode:NavigationModePush];
}






@end
