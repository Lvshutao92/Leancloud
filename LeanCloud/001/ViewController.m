//
//  ViewController.m
//  LeanCloud
//
//  Created by ilovedxracer on 2018/9/13.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "ViewController.h"
#import <AVCloud.h>
#import "TableViewCell.h"
#import "DetailsViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *str;
}
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)MBProgressHUD *HUD;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.label.text = @"加载中,请稍等...";
    _HUD.mode = MBProgressHUDModeText;
    
    self.tableview = [[UITableView alloc]initWithFrame:self.view.frame];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
 
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    self.tableview.tableFooterView = v;
    
    [self lodData];
}


- (void)lodData{
    [_HUD showAnimated:YES];
    __weak typeof(self)weakSelf = self;
    AVQuery *query = [AVQuery queryWithClassName:@"HomeContentFile"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
       
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.dataArray addObjectsFromArray:objects];
        [weakSelf.tableview reloadData];
         [weakSelf.HUD hideAnimated:YES];
    }];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 165*SCALE_HEIGHT;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    AVObject *item = [self.dataArray objectAtIndex:indexPath.row];
    AVFile *file =[item objectForKey:@"url"];
    [cell.img sd_setImageWithURL:[NSURL URLWithString:file.url]];
    cell.lab.text = [item objectForKey:@"title"];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailsViewController *de = [[DetailsViewController alloc]init];
    AVObject *item = [self.dataArray objectAtIndex:indexPath.row];
    NSString *string = [item objectForKey:@"title"];
    if ([string isEqualToString:@"北京"]) {
        de.str = @"Beijing_list";
    }else if ([string isEqualToString:@"河南"]){
        de.str = @"Henan_list";
    }else if ([string isEqualToString:@"天津"]){
        de.str = @"TianJin_List";
    }else if ([string isEqualToString:@"河北"]){
        de.str = @"HeBei_List";
    }else if ([string isEqualToString:@"山西"]){
        de.str = @"ShanXi_1";
    }else if ([string isEqualToString:@"陕西"]){
        de.str = @"ShanXi_3";
    }else{
        
    }

    [self presentViewController:de animated:YES completion:nil];
    
}















- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

@end
