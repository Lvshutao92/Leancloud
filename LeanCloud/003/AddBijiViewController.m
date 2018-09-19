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

#import "AddBijiViewController.h"

@interface AddBijiViewController ()<UITextViewDelegate>
@property(nonatomic,strong)UITextView *textview;
@end

@implementation AddBijiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.textview = [[UITextView alloc]initWithFrame:self.view.frame];
    self.textview.delegate = self;
    [self.view addSubview:self.textview];
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(clickSave)];
    self.navigationItem.rightBarButtonItem = bar;
}

- (void)clickSave {
    if (self.textview.text.length > 0) {
        NSString *currentUsername = [AVUser currentUser].username;
        AVObject *todoFolder = [[AVObject alloc] initWithClassName:[NSString stringWithFormat:@"A%@",[Manager md5:currentUsername]]];// 构建对象
        [todoFolder setObject:self.textview.text forKey:@"content"];// 设置名称
        [todoFolder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                NSLog(@"error === %@",error);
            }
        }];// 保存到云端
    }
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
