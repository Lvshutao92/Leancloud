//MainTabBarViewController

#import "MainTabBarViewController.h"
#import "UserViewController.h"
#import "ViewController.h"
#import "LiaotianViewController.h"
#import "BijiViewController.h"
#import "IMViewController.h"



@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (instancetype)init {
    if (self = [super init]) {
        ViewController *oneVc = [[ViewController alloc]init];
        //UINavigationController *aaa = [[UINavigationController alloc]initWithRootViewController:oneVc];
        oneVc.tabBarItem.image = [UIImage imageNamed:@"1"];
        oneVc.title = @"省份";
        oneVc.tabBarItem.selectedImage = [UIImage imageNamed:@"01"];
        
        
        IMViewController *imVc = [[IMViewController alloc]init];
        UINavigationController *ddd = [[UINavigationController alloc]initWithRootViewController:imVc];
        imVc.tabBarItem.image = [UIImage imageNamed:@"3"];
        imVc.title = @"联系人";
        imVc.tabBarItem.selectedImage = [UIImage imageNamed:@"03"];
        
        
        
        
        LiaotianViewController *twoVc = [[LiaotianViewController alloc]init];
        UINavigationController *bbb = [[UINavigationController alloc]initWithRootViewController:twoVc];
        twoVc.tabBarItem.image = [UIImage imageNamed:@"3"];
        twoVc.title = @"圈子";
        twoVc.tabBarItem.selectedImage = [UIImage imageNamed:@"03"];
        
        
        BijiViewController *thrVc = [[BijiViewController alloc]init];
        UINavigationController *ccc = [[UINavigationController alloc]initWithRootViewController:thrVc];
        thrVc.tabBarItem.image = [UIImage imageNamed:@"4"];
        thrVc.title = @"笔记";
        thrVc.tabBarItem.selectedImage = [UIImage imageNamed:@"04"];
        
        
        
        UserViewController *fourVc = [[UserViewController alloc]init];
        UINavigationController *mainfourVC = [[UINavigationController alloc]initWithRootViewController:fourVc];
        fourVc.title = @"我的";
        mainfourVC.tabBarItem.image = [UIImage imageNamed:@"2"];
        mainfourVC.tabBarItem.selectedImage = [UIImage imageNamed:@"02"];
        
        self.tabBar.tintColor = [UIColor redColor];
        self.viewControllers = @[oneVc,bbb,ccc,mainfourVC];
    }
    return self;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
