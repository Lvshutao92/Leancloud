//
//  ForgetPasswordViewController.m
//  BiJi
//
//  Created by ilovedxracer on 2018/9/11.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "Manager.h"
#import <XYQRegexPattern/XYQRegexPatternHelper.h>
@interface ForgetPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *text1;


@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.text1.keyboardType = UIKeyboardTypeEmailAddress;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.text1 resignFirstResponder];
}


- (IBAction)clickUpdataPassword:(id)sender {
    
    [AVUser requestPasswordResetForEmailInBackground:self.text1.text block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"请前往邮箱重置密码" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *centain = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:centain];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            //NSLog(@"error");
        }
    }];
    
    
}
















@end
