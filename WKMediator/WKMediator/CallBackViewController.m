//
//  CallBackViewController.m
//  WKMediator
//
//  Created by ma wei on 2018/12/31.
//  Copyright © 2018年 ma wei. All rights reserved.
//

#import "CallBackViewController.h"

@interface CallBackViewController ()

@property (nonatomic, copy) void (^textCallBlock)(NSString *msg);


@end

@implementation CallBackViewController


- (instancetype)initWithParames:(NSDictionary *)Parames
{
    self = [super initWithParames:Parames];
    if (self) {
        self.textCallBlock = Parames[@"callback"];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    self.title = @"CallBack";
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, 200, 30)];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    [button setTitle:@"异步返回" forState:UIControlStateNormal];
    button.center = self.view.center;
    [button addTarget:self action:@selector(didClickButtonCallBack) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view.
}

- (void)didClickButtonCallBack
{
    if (self.textCallBlock) {
        self.textCallBlock(@"CallBackViewController  返回值。1111");
    }
    [self.navigationController popViewControllerAnimated:YES];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
