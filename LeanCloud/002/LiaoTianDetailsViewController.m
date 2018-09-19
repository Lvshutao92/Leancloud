//LiaoTianDetailsViewController

#import "LiaoTianDetailsViewController.h"
#import "LiaoTianTableViewCell.h"
#import "LiaoTian_A_TableViewCell.h"
#import "LogInViewController.h"
#import "LiaoTianPingLunViewController.h"
@interface LiaoTianDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *str;
    CGFloat height;
}
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)MBProgressHUD *HUD;

@end

@implementation LiaoTianDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickPinglunAdd)];
    self.navigationItem.rightBarButtonItem = bar;
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.label.text = @"加载中,请稍等...";
    _HUD.mode = MBProgressHUDModeText;
    
    self.tableview = [[UITableView alloc]initWithFrame:self.view.frame];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    [self.tableview registerClass:[LiaoTianTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableview registerClass:[LiaoTian_A_TableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.view addSubview:self.tableview];
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    self.tableview.tableFooterView = v;
    
    NSLog(@"--------%@",self.idStr);
    
    [self setHeader];
    
    [self lodData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(successPL:) name:@"successPL" object:nil];
}
- (void)successPL:(NSNotification *)text {
    [self lodData];
}

- (void)lodData{
    __weak typeof(self)weakSelf = self;
    AVQuery *query = [AVQuery queryWithClassName:self.idStr];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.dataArray addObjectsFromArray:objects];
        [weakSelf.tableview reloadData];
    }];
}












- (void)clickPinglunAdd{
    if ([Manager judgeWhetherIsEmptyAnyObject:[Manager redingwenjianming:@"username"]] != YES) {
        LogInViewController *login = [[LogInViewController alloc]init];
        login.title = @"账号登录";
        [self.navigationController pushViewController:login animated:YES];
    }else{
        LiaoTianPingLunViewController *login = [[LiaoTianPingLunViewController alloc]init];
        login.title = @"写评论";
        login.idStr = self.idStr;
        [self.navigationController pushViewController:login animated:YES];
    }
}







- (void)setHeader{
    CGFloat heig = [Manager heightForString:self.contentStr fontSize:18 andWidth:SCREEN_WIDTH-20];
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, heig+50)];
    self.tableview.tableHeaderView = v;
    
    UILabel *lab1 = [[UILabel alloc]init];
    CGFloat width = [Manager widthForString:self.nameStr fontSize:14 andHeight:20];
    lab1.frame = CGRectMake(10, 10, width+10, 20);
    lab1.text = self.nameStr;
    lab1.backgroundColor = [UIColor redColor];
    lab1.textColor = [UIColor whiteColor];
    lab1.textAlignment = NSTextAlignmentCenter;
    LRViewBorderRadius(lab1, 3, 0, [UIColor redColor]);
    lab1.font = FONT(14);
    [v addSubview:lab1];
    
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, SCREEN_WIDTH-20, heig)];
    lab2.text = self.contentStr;
    lab2.numberOfLines = 0;
    lab2.font = FONT(18);
    [v addSubview:lab2];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, heig+45, SCREEN_WIDTH, 5)];
    line.backgroundColor = [UIColor colorWithWhite:.9 alpha:.8];
    [v addSubview:line];
}







- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AVObject *item = [self.dataArray objectAtIndex:indexPath.row];
    
    if ([[item objectForKey:@"username"] isEqualToString:self.nameStr]) {
        LiaoTianTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        CGFloat width = [Manager widthForString:[item objectForKey:@"username"] fontSize:14 andHeight:20];
        cell.lab1.frame = CGRectMake(10, 10, width+10, 20);
        CGFloat heig = [Manager heightForString:[item objectForKey:@"content"] fontSize:18 andWidth:SCREEN_WIDTH-20];
        cell.lab2.frame = CGRectMake(10, 35, SCREEN_WIDTH-20, heig);
        height = heig +45;
        cell.lab1.text = [item objectForKey:@"username"];
        cell.lab2.text = [item objectForKey:@"content"];
        return cell;
    }
    
    
    LiaoTian_A_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    CGFloat width = [Manager widthForString:[item objectForKey:@"username"] fontSize:14 andHeight:20];
    cell.lab1.frame = CGRectMake(SCREEN_WIDTH-20-width, 10, width+10, 20);
    CGFloat heig = [Manager heightForString:[item objectForKey:@"content"] fontSize:18 andWidth:SCREEN_WIDTH-20];
    cell.lab2.frame = CGRectMake(10, 35, SCREEN_WIDTH-20, heig);
    height = heig +45;
    cell.lab1.text = [item objectForKey:@"username"];
    cell.lab2.text = [item objectForKey:@"content"];
    return cell;
}









- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
@end
