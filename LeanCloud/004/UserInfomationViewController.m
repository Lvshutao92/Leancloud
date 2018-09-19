//
//  UserInfomationViewController.m
//  LeanCloud
//
//  Created by 吕书涛 on 2018/9/17.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "UserInfomationViewController.h"
#import "Manager.h"
@interface UserInfomationViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeight;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIImageView *userimg;

@end

@implementation UserInfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userimg.layer.masksToBounds = YES;
    self.userimg.layer.cornerRadius = 20;
    if ([[Manager iphoneType]isEqualToString:@"iPhone X"]) {
        self.topHeight.constant = 88;
    }else{
        self.topHeight.constant = 64;
    }
    
    NSString *currentUsername = [AVUser currentUser].username;
    self.username.text = currentUsername;
}



- (IBAction)clickChangeImg:(id)sender {
    
    
    
    
}







- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.userimg.image = [UIImage imageNamed:@"baitian"];
}









- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
@end
