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
    }else if ([string isEqualToString:@"香港"]){
        de.str = @"Xianggang_List";
    }else if ([string isEqualToString:@"澳门"]){
        de.str = @"Aomen_List";
    }else if ([string isEqualToString:@"台湾"]){
        de.str = @"Taiwan_List";
    }else if ([string isEqualToString:@"吉林"]){
        de.str = @"Jilin_List";
    }else if ([string isEqualToString:@"内蒙古"]){
        de.str = @"Neimenggu_List";
    }else if ([string isEqualToString:@"辽宁"]){
        de.str = @"Liaoning_List";
    }else if ([string isEqualToString:@"黑龙江"]){
        de.str = @"Heilongjiang_List";
    }else if ([string isEqualToString:@"上海"]){
        de.str = @"Shanghai_List";
    }else if ([string isEqualToString:@"江苏"]){
        de.str = @"Jiangsu_List";
    }else if ([string isEqualToString:@"浙江"]){
        de.str = @"Zhejiang_List";
    }else if ([string isEqualToString:@"安徽"]){
        de.str = @"Anhui_List";
    }else if ([string isEqualToString:@"福建"]){
        de.str = @"Fujian_List";
    }else if ([string isEqualToString:@"江西"]){
        de.str = @"Jiangxi_List";
    }else if ([string isEqualToString:@"山东"]){
        de.str = @"Shandong_List";
    }else if ([string isEqualToString:@"湖南"]){
        de.str = @"Hunan_List";
    }else if ([string isEqualToString:@"湖北"]){
        de.str = @"Hubei_List";
    }else if ([string isEqualToString:@"广东"]){
        de.str = @"Guangdong_List";
    }else if ([string isEqualToString:@"广西"]){
        de.str = @"Guangxi_List";
    }else if ([string isEqualToString:@"海南"]){
        de.str = @"Hainan_List";
    }else if ([string isEqualToString:@"重庆"]){
        de.str = @"Chongqing_List";
    }else if ([string isEqualToString:@"四川"]){
        de.str = @"Sichuan_List";
    }else if ([string isEqualToString:@"贵州"]){
        de.str = @"Guizhou_List";
    }else if ([string isEqualToString:@"云南"]){
        de.str = @"Yunnan_List";
    }else if ([string isEqualToString:@"西藏"]){
        de.str = @"Xizang_List";
    }else if ([string isEqualToString:@"甘肃"]){
        de.str = @"Gansu_List";
    }else if ([string isEqualToString:@"青海"]){
        de.str = @"Qinghai_List";
    }else if ([string isEqualToString:@"宁夏"]){
        de.str = @"Ningxia_List";
    }else if ([string isEqualToString:@"新疆"]){
        de.str = @"Xinjiang_List";
    }
    
    
    
    else{
        
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
