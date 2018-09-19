//WTFKViewController

#import "WTFKViewController.h"

@interface WTFKViewController ()<UITextViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UITextView *textview;
@property(nonatomic,strong)UITextField *textfield;
@end

@implementation WTFKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupview];
}

- (void)setupview{
    CGFloat height;
    if ([[Manager iphoneType]isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    
    self.textview = [[UITextView alloc]initWithFrame:CGRectMake(20, height+10, SCREEN_WIDTH-40, 150)];
    self.textview.delegate = self;
    self.textview.backgroundColor = [UIColor colorWithWhite:.9 alpha:.8];
    [self.view addSubview:self.textview];
    
    self.textfield = [[UITextField alloc]initWithFrame:CGRectMake(20, height+180, SCREEN_WIDTH-40, 50)];
    self.textfield.delegate = self;
    self.textfield.backgroundColor = [UIColor colorWithWhite:.9 alpha:.8];
    self.textfield.placeholder = @"预留手机号/邮箱/QQ";
    [self.view addSubview:self.textfield];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    btn.frame = CGRectMake(20, height+260, SCREEN_WIDTH-40, 40);
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    
}

- (void)click{
    if (self.textview.text.length > 0 && self.textfield.text.length > 0) {
        
        AVObject *todoFolder = [[AVObject alloc] initWithClassName:@"ProblemOfFeedback"];// 构建对象
        [todoFolder setObject:self.textview.text forKey:@"content"];// 设置名称
        [todoFolder setObject:self.textfield.text forKey:@"LianXinXinXi"];
        [todoFolder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"提交成功" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *centain = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alert addAction:centain];
                [self presentViewController:alert animated:YES completion:nil];
            }else{
                NSLog(@"error === %@",error);
            }
        }];// 保存到云端
    }
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = YES;
}




@end
