//
//  LiuYanViewController.m
//  LeanCloud
//
//  Created by ilovedxracer on 2018/10/8.
//  Copyright © 2018 ilovedxracer. All rights reserved.
//

#import "LiuYanViewController.h"

@interface LiuYanViewController ()<UITextFieldDelegate,UITextViewDelegate>
@property(nonatomic,strong)UITextField *text1;
@property(nonatomic,strong)UITextField *text2;
@property(nonatomic,strong)UITextView  *textView;
@end

@implementation LiuYanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 50)];
    v.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: v];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    btn1.frame = CGRectMake(10, 5, 40, 40);
    [btn1 addTarget:self action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];
    btn1.layer.masksToBounds = YES;
    btn1.layer.cornerRadius = 20;
    [v addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"提交" forState:UIControlStateNormal];
    btn2.frame = CGRectMake(50, 5, self.view.frame.size.width-100, 40);
    [btn2 addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn2.layer.masksToBounds = YES;
    btn2.layer.cornerRadius = 20;
    [v addSubview:btn2];
    
    self.text1 = [[UITextField alloc]initWithFrame:CGRectMake(20, 88, self.view.frame.size.width-40, 50)];
    self.text1.delegate = self;
    self.text1.placeholder = @"姓名";
    self.text1.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.text1];
    
    self.text2 = [[UITextField alloc]initWithFrame:CGRectMake(20, 158, self.view.frame.size.width-40, 50)];
    self.text2.delegate = self;
    self.text2.placeholder = @"联系方式";
    self.text2.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.text2];
    
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(20, 228, self.view.frame.size.width-40, 150)];
    self.textView.delegate = self;
    [self.view addSubview:self.textView];
    
}










- (void)click1{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)click2{
    if (self.textView.text.length > 0 && self.text1.text.length > 0 && self.text2.text.length > 0) {
        AVObject *todoFolder = [[AVObject alloc] initWithClassName:self.idstr];// 构建对象
        [todoFolder setObject:self.textView.text forKey:@"content"];// 设置名称
        [todoFolder setObject:self.text1.text forKey:@"name"];
        [todoFolder setObject:self.text2.text forKey:@"phone"];
        
        [todoFolder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                NSDictionary *dict = [[NSDictionary alloc]init];
                NSNotification *notification =[NSNotification notificationWithName:@"change_3ceng" object:nil userInfo:dict];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                NSLog(@"error === %@",error);
            }
        }];// 保存到云端
    }
}


@end
