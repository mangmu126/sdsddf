
//

#import "SHTabBarViewController.h"
#import "SHNavigationController.h"
#import "HomeViewController.h"
#import "EarnMoneyViewController.h"
#import "ShareViewController.h"
#import "SpendMoneyViewController.h"
#import "MeViewController.h"
@interface SHTabBarViewController ()

@end

@implementation SHTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
   /**** 设置所有UITabBarItem的文字属性 ****/
    [self setupItemTitleTextAttributes];
    
     /**** 添加子控制器 ****/
    [self setupChildViewControllers];
    
    self.tabBar.barTintColor = [UIColor whiteColor];
    
    
    
}




/**
 *  添加子控制器
 */
- (void)setupChildViewControllers
{
    [self setupOneChildViewController:[[SHNavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]] title:@"主页" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setupOneChildViewController:[[SHNavigationController alloc] initWithRootViewController:[[EarnMoneyViewController alloc] init]] title:@"赚钱" image:@"tabBar_new_icon"
selectedImage:@"tabBar_new_click_icon"];
    
    [self setupOneChildViewController:[[SHNavigationController alloc] initWithRootViewController:[[ShareViewController alloc] init]] title:@"分享" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setupOneChildViewController:[[SHNavigationController alloc] initWithRootViewController:[[SpendMoneyViewController alloc] init]] title:@"花钱" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setupOneChildViewController:[[SHNavigationController alloc] initWithRootViewController:[[MeViewController alloc] init]] title:@"我的" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    
    
}
/**
 *  设置所有UITabBarItem的文字属性
 */
- (void)setupItemTitleTextAttributes
{
    // 普通状态下的文字属性
    UITabBarItem *item = [UITabBarItem appearance];
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

/**
 *  初始化一个子控制器
 *
 *  @param vc            子控制器
 *  @param title         标题
 *  @param image         图标
 *  @param selectedImage 选中的图标
 */

- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.tabBarItem.title = title;
    if (image.length) {
        
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    [self addChildViewController:vc];
}


@end
