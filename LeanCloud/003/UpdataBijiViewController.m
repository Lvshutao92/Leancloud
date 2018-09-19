/**
 * ━━━━━━大橙子踏神兽而来━━━━━━
 * 　　　┏┓　　　┏┓
 * 　　┏┛┻━━━┛┻┓
 * 　　┃　　　　　　　┃
 * 　　┃　　　━　　　┃
 * 　　┃　┳┛　┗┳　┃
 * 　　┃　　　　　　　┃
 * 　　┃　　　┻　　　┃
 * 　　┃　　　　　　　┃
 * 　　┗━┓　　　┏━┛Code is far away from bug with the animal protecting
 * 　　　　┃　　　┃    神兽保佑,代码无bug
 * 　　　　┃　　　┃
 * 　　　　┃　　　┗━━━┓
 * 　　　　┃　　　　　　　┣┓
 * 　　　　┃　　　　　　　┏┛
 * 　　　　┗┓┓┏━┳┓┏┛
 * 　　　　　┃┫┫　┃┫┫
 * 　　　　　┗┻┛　┗┻┛
 *
 * ━━━━━━感觉萌萌哒━━━━━━
 */

#import "UpdataBijiViewController.h"

@interface UpdataBijiViewController ()<UITextViewDelegate>
@property(nonatomic,strong)UITextView *textview;

@end

@implementation UpdataBijiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.textview = [[UITextView alloc]initWithFrame:self.view.frame];
    self.textview.delegate = self;
    self.textview.text = [self.item objectForKey:@"content"];
    [self.view addSubview:self.textview];
    
    UIBarButtonItem *bar1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(clickUpdata)];
    UIBarButtonItem *bar2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(clickDelete)];
    
    self.navigationItem.rightBarButtonItems = @[bar1,bar2];
}

- (void)clickUpdata {

    NSString *currentUsername = [AVUser currentUser].username;
    
    AVQuery *query = [AVQuery queryWithClassName:[NSString stringWithFormat:@"A%@",[Manager md5:currentUsername]]];
    [query whereKey:@"objectId" equalTo:self.item.objectId];
    
    [self.item setObject:self.textview.text forKey:@"content"];
    
    AVSaveOption *option = [[AVSaveOption alloc]init];
    option.query = query;
    
    [self.item saveInBackgroundWithOption:option block:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            NSLog(@"%@",error);
        }
    }];
    
}
- (void)clickDelete {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否要删除！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *centain = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.item deleteInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                NSLog(@"%@",error);
            }
        }];
    }];
    UIAlertAction *fo = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:centain];
    [alert addAction:fo];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
@end
