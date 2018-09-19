//
//  RegisterViewController.m
//  BiJi
//
//  Created by ilovedxracer on 2018/9/11.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "RegisterViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "Manager.h"
#import <XYQRegexPattern/XYQRegexPatternHelper.h>
@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *text1;

@property (weak, nonatomic) IBOutlet UITextField *text2;

@property (weak, nonatomic) IBOutlet UITextField *text3;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.text3.keyboardType = UIKeyboardTypeEmailAddress;
    // Do any additional setup after loading the view from its nib.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.text1 resignFirstResponder];
    [self.text2 resignFirstResponder];
    [self.text3 resignFirstResponder];
}

- (IBAction)clickRegister:(id)sender {
    
    AVUser *user = [AVUser user];// 新建 AVUser 对象实例
    user.username = self.text1.text;// 设置用户名
    user.password = self.text2.text;// 设置密码
    user.email = self.text3.text;// 设置邮箱
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            //NSLog(@"注册成功");
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *centain = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 [self.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:centain];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            //NSLog(@"失败的原因可能有多种，常见的是用户名已经存在。===%@",error);
        }
    }];
    
}




//132 7010 9384






@end
