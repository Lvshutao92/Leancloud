//BijiViewController

#import "BijiViewController.h"
#import "Manager.h"
#import "LogInViewController.h"
#import "UpdataBijiViewController.h"
#import "AddBijiViewController.h"
#import "BijiTableViewCell.h"
@interface BijiViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *str;
}
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)MBProgressHUD *HUD;


@end

@implementation BijiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *color = [UIColor redColor];
    [self.navigationController.navigationBar setBarTintColor:color];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickAdd)];
    self.navigationItem.rightBarButtonItem = bar;
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.label.text = @"加载中,请稍等...";
    _HUD.mode = MBProgressHUDModeText;
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    [self.tableview registerClass:[BijiTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    self.tableview.tableFooterView = v;
    
}


- (void)lodData{
    [_HUD showAnimated:YES];
    __weak typeof(self)weakSelf = self;
    NSString *currentUsername = [AVUser currentUser].username;
    AVQuery *query = [AVQuery queryWithClassName:[NSString stringWithFormat:@"A%@",[Manager md5:currentUsername]]];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [weakSelf.HUD hideAnimated:YES];
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.dataArray addObjectsFromArray:objects];
        [weakSelf.tableview reloadData];
    }];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BijiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    AVObject *item = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text = [item objectForKey:@"content"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AVObject *item = [self.dataArray objectAtIndex:indexPath.row];
    UpdataBijiViewController *login = [[UpdataBijiViewController alloc]init];
    login.title = @"修改笔记";
    login.item = item;
    [self.navigationController pushViewController:login animated:YES];
}





- (void)clickAdd{
    if ([Manager judgeWhetherIsEmptyAnyObject:[Manager redingwenjianming:@"username"]] != YES) {
        LogInViewController *login = [[LogInViewController alloc]init];
        login.title = @"账号登录";
        [self.navigationController pushViewController:login animated:YES];
    }else{
        AddBijiViewController *login = [[AddBijiViewController alloc]init];
        login.title = @"写笔记";
        [self.navigationController pushViewController:login animated:YES];
    }
}












- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    if ([Manager judgeWhetherIsEmptyAnyObject:[Manager redingwenjianming:@"username"]] != YES) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否前往登录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *centain = [UIAlertAction actionWithTitle:@"前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            LogInViewController *problemOfFeedback = [[LogInViewController alloc]init];
            problemOfFeedback.navigationItem.title = @"账号登录";
            [self.navigationController pushViewController:problemOfFeedback animated:YES];
            
        }];
        [alert addAction:centain];
        UIAlertAction *no = [UIAlertAction actionWithTitle:@"稍后" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:no];
        [self presentViewController:alert animated:YES completion:nil];
    }
    [self lodData];
}


- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

@end
