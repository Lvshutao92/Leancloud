//
//  ThreeCengViewController.m
//  LeanCloud
//
//  Created by ilovedxracer on 2018/10/8.
//  Copyright © 2018 ilovedxracer. All rights reserved.
//

#import "ThreeCengViewController.h"
#import "LiuYanViewController.h"
#import "LogInViewController.h"
#import "LiaoTianTableViewCell.h"
@interface ThreeCengViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *str;
    CGFloat height;
}
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)MBProgressHUD *HUD;

@end

@implementation ThreeCengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 50)];
    v.backgroundColor = [UIColor colorWithWhite:.8 alpha:.5];
    [self.view addSubview: v];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    btn1.frame = CGRectMake(10, 5, 40, 40);
    [btn1 addTarget:self action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];
    btn1.layer.masksToBounds = YES;
    btn1.layer.cornerRadius = 20;
    [v addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"写留言" forState:UIControlStateNormal];
    btn2.frame = CGRectMake(50, 5, self.view.frame.size.width-100, 40);
    [btn2 addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn2.layer.masksToBounds = YES;
    btn2.layer.cornerRadius = 20;
    [v addSubview:btn2];
    
    
    
    
    
   
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50)];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    [self.tableview registerClass:[LiaoTianTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    UIView *vs = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    self.tableview.tableFooterView = vs;
    
    [self lodData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change:) name:@"change_3ceng" object:nil];
}
- (void)change:(NSNotification *)text {
    [self lodData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LiaoTianTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    AVObject *item = [self.dataArray objectAtIndex:indexPath.row];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
   
    cell.lab1.frame = CGRectMake(10, 10, self.view.frame.size.width-20, 30);
    cell.lab1.font = FONT(16);
    
    
    CGFloat heig = [Manager heightForString:[item objectForKey:@"content"] fontSize:18 andWidth:SCREEN_WIDTH-20];
    cell.lab2.frame = CGRectMake(10, 45, SCREEN_WIDTH-20, heig);
    
    height = heig +55;
    
    cell.lab1.text = [NSString stringWithFormat:@"%@-%@",[item objectForKey:@"name"],[item objectForKey:@"phone"]];
    cell.lab2.text = [item objectForKey:@"content"];
    return cell;
}


- (void)lodData{
    __weak typeof(self)weakSelf = self;
    AVQuery *query = [AVQuery queryWithClassName:self.idstr];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.dataArray addObjectsFromArray:objects];
        [weakSelf.tableview reloadData];
    }];
}



- (void)click1{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)click2{
   
        LiuYanViewController *three = [[LiuYanViewController alloc]init];
        three.idstr = self.idstr;
        [self presentViewController:three animated:YES completion:nil];
  
    
}

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

@end
