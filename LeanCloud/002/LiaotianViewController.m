//LiaotianViewController

#import "LiaotianViewController.h"
#import "LiaotianAddViewController.h"
#import "LogInViewController.h"
#import "LiaoTianTableViewCell.h"
#import "LiaoTianDetailsViewController.h"
@interface LiaotianViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *str;
    CGFloat height;
}
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)MBProgressHUD *HUD;

@end

@implementation LiaotianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *color = [UIColor redColor];
    [self.navigationController.navigationBar setBarTintColor:color];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickAdd)];
    self.navigationItem.rightBarButtonItem = bar;
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.label.text = @"加载中,请稍等...";
    _HUD.mode = MBProgressHUDModeText;
    
    self.tableview = [[UITableView alloc]initWithFrame:self.view.frame];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    [self.tableview registerClass:[LiaoTianTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    self.tableview.tableFooterView = v;
    
    [self lodData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change:) name:@"change" object:nil];
}
- (void)change:(NSNotification *)text {
    [self lodData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LiaoTianDetailsViewController *de = [[LiaoTianDetailsViewController alloc]init];
    de.navigationItem.title = @"详情";
    AVObject *item = [self.dataArray objectAtIndex:indexPath.row];
    de.idStr = [NSString stringWithFormat:@"PL_%@",[item objectForKey:@"objectId"]];
    de.nameStr    = [item objectForKey:@"username"];
    de.contentStr = [item objectForKey:@"content"];
    [self.navigationController pushViewController:de animated:YES];
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
    
    CGFloat width = [Manager widthForString:[item objectForKey:@"username"] fontSize:14 andHeight:20];
    cell.lab1.frame = CGRectMake(10, 10, width+10, 20);
    
    CGFloat heig = [Manager heightForString:[item objectForKey:@"content"] fontSize:18 andWidth:SCREEN_WIDTH-20];
    cell.lab2.frame = CGRectMake(10, 35, SCREEN_WIDTH-20, heig);
    
    height = heig +45;
    
    cell.lab1.text = [item objectForKey:@"username"];
    cell.lab2.text = [item objectForKey:@"content"];
    return cell;
}





- (void)clickAdd {
   
    if ([Manager judgeWhetherIsEmptyAnyObject:[Manager redingwenjianming:@"username"]] != YES) {
        LogInViewController *login = [[LogInViewController alloc]init];
        login.title = @"账号登录";
        [self.navigationController pushViewController:login animated:YES];
    }else{
        LiaotianAddViewController *login = [[LiaotianAddViewController alloc]init];
        login.title = @"发布";
        [self.navigationController pushViewController:login animated:YES];
    }
    
}

- (void)lodData{
    [_HUD showAnimated:YES];
    __weak typeof(self)weakSelf = self;
    AVQuery *query = [AVQuery queryWithClassName:@"LiaoTian"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [weakSelf.HUD hideAnimated:YES];
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.dataArray addObjectsFromArray:objects];
        [weakSelf.tableview reloadData];
    }];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}


- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

@end
