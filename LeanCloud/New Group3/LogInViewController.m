//
//  LogInViewController.m
//  BiJi
//
//  Created by ilovedxracer on 2018/9/11.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "LogInViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "Manager.h"
#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"
@interface LogInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextfiled;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfiled;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.passwordTextfiled.secureTextEntry = YES;
    self.userNameTextfiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTextfiled.clearButtonMode = UITextFieldViewModeWhileEditing;
}



- (IBAction)clickLogin:(id)sender {
    [AVUser logInWithUsernameInBackground:self.userNameTextfiled.text password:self.passwordTextfiled.text block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            //NSLog(@"登录成功=====");
            [Manager writewenjianming:@"username" content:self.userNameTextfiled.text];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self loginError];
        }
    }];
}

- (void)loginError{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"登录失败，请检查网络后重试" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *centain = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:centain];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.userNameTextfiled resignFirstResponder];
    [self.passwordTextfiled resignFirstResponder];
}



- (IBAction)clickSlipRegisterPage:(id)sender {
    
    RegisterViewController *regis = [[RegisterViewController alloc]init];
    regis.title = @"账号注册";
    [self.navigationController pushViewController:regis animated:YES];
    
}



- (IBAction)clickSlipForgetPasswordPage:(id)sender {
    
    ForgetPasswordViewController *forgetPassword = [[ForgetPasswordViewController alloc]init];
    forgetPassword.title = @"找回密码";
    [self.navigationController pushViewController:forgetPassword animated:YES];
    
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = YES;
}


@end
