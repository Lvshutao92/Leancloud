//GYWMViewController

#import "GYWMViewController.h"

@interface GYWMViewController ()<UITextViewDelegate>
@property(nonatomic,strong)UITextView *textview;
@end

@implementation GYWMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat height;
    if ([[Manager iphoneType]isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    self.textview = [[UITextView alloc]initWithFrame:CGRectMake(20, height+10, SCREEN_WIDTH-40, SCREEN_HEIGHT- height-10)];
    self.textview.font = FONT(20);
    self.textview.delegate = self;
    self.textview.editable = NO;
    self.textview.text = @"中国地理大全\n\n一起讨论学地理\n\n进一步了解中国\n\n记录心得\n\n一起约玩\n\n交朋友\n\n在这里\n\n你会变得博学\n\n宽阔你的视野\n\n在这里\n\n丰富你的人生";
    [self.view addSubview:self.textview];
    
    
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
