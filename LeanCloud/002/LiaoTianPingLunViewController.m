//LiaoTianPingLunViewController

#import "LiaoTianPingLunViewController.h"

@interface LiaoTianPingLunViewController ()<UITextViewDelegate>
@property(nonatomic,strong)UITextView *textview;

@end

@implementation LiaoTianPingLunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
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
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    btn.frame = CGRectMake(20, height+190, SCREEN_WIDTH-40, 40);
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    
}

- (void)click{
    NSString *currentUsername = [AVUser currentUser].username;
    AVObject *todoFolder = [[AVObject alloc] initWithClassName:self.idStr];// 构建对象
    [todoFolder setObject:self.textview.text forKey:@"content"];
    [todoFolder setObject:currentUsername forKey:@"username"];
    [todoFolder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSDictionary *dict = [[NSDictionary alloc]init];
            NSNotification *notification =[NSNotification notificationWithName:@"successPL" object:nil userInfo:dict];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            NSLog(@"error === %@",error);
        }
    }];
}














@end
