//
//  UserViewController.m
//  LeanCloud
//
//  Created by 吕书涛 on 2018/9/17.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//


#import "UserViewController.h"
#import "Manager.h"
#import "LogInViewController.h"
#import "UserInfomationViewController.h"
#import "WTFKViewController.h"
#import "GYWMViewController.h"

@interface UserViewController ()
@property(nonatomic,strong)UIView *headerBGView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeight;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIButton *userBtn;

@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;
@property (weak, nonatomic) IBOutlet UIImageView *yeliImg;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:.8 alpha:.4];
    UIColor *color = [UIColor redColor];
    [self.navigationController.navigationBar setBarTintColor:color];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    

    
    self.userImg.layer.masksToBounds = YES;
    self.userImg.layer.cornerRadius = 45;
    
    if ([[Manager iphoneType]isEqualToString:@"iPhone X"]) {
        self.topHeight.constant = 88;
    }else{
        self.topHeight.constant = 64;
    }
    
    
    
   
}











- (IBAction)clickWTFK:(id)sender {
    WTFKViewController *login = [[WTFKViewController alloc]init];
    login.title = @"问题反馈";
    [self.navigationController pushViewController:login animated:YES];
}




- (IBAction)clickGYWM:(id)sender {
    GYWMViewController *login = [[GYWMViewController alloc]init];
    login.title = @"关于我们";
    [self.navigationController pushViewController:login animated:YES];
}





- (IBAction)clickSwitchkaiguan:(id)sender {
    UISwitch *swit = (UISwitch *)sender;
    if (swit.on) {
        self.view.window.alpha = 0.5;
        self.yeliImg.image = [UIImage imageNamed:@"yeli"];
        
    }else{
        self.view.window.alpha = 1.0;
        self.yeliImg.image = [UIImage imageNamed:@"baitian"];
    }
}

- (IBAction)clickUserButton:(id)sender {
    
    if ([Manager judgeWhetherIsEmptyAnyObject:[Manager redingwenjianming:@"username"]] != YES) {
        LogInViewController *login = [[LogInViewController alloc]init];
        login.title = @"账号登录";
        [self.navigationController pushViewController:login animated:YES];
    }else{
        UserInfomationViewController *login = [[UserInfomationViewController alloc]init];
        login.title = @"账号信息";
        [self.navigationController pushViewController:login animated:YES];
    }
    
    
}

- (IBAction)clickLogOut:(id)sender {
    [AVUser logOut];  //清除缓存用户对象
    [AVUser currentUser]; // 现在的currentUser是nil了
    [Manager remove:@"username"];
    
    [self isOrNo];
    
}

- (void)isOrNo{
    NSString *currentUsername = [AVUser currentUser].username;// 当前用户名
    
    if ([Manager judgeWhetherIsEmptyAnyObject:[Manager redingwenjianming:@"username"]] == YES) {
        self.userName.text = currentUsername;
        self.logoutBtn.hidden = NO;
    }else{
        self.userName.text = @"登录/注册";
        self.logoutBtn.hidden = YES;
    }
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
    [self isOrNo];
}

@end







