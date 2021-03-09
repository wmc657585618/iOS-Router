#import "HiRouterPath.h"
#import "HiRouter.h"

NSString *const viewmodel = @"viewmodel";
NSString *const page_sub_sub1 = @"page/sub/sub1";
NSString *const page_error = @"page/error";
NSString *const page_sub_sub2 = @"page/sub/sub2";
NSString *const page_main = @"page/main";
NSString *const root_controller = @"root/controller";
NSString *const nav_fourth = @"nav/fourth";
NSString *const nav_first = @"nav/first";
NSString *const nav_seconde = @"nav/seconde";
NSString *const nav_third = @"nav/third";
NSString *const parametes_main_receive = @"parametes/main/receive";
NSString *const parametes_main = @"parametes/main";
NSString *const callback_main = @"callback/main";
NSString *const callback_sub = @"callback/sub";
NSString *const network_main = @"network/main";
@implementation HiRouterPath

+ (void)loadData {
	viewmodel.hi_class = NSClassFromString(@"HiViewModelViewController");
	page_sub_sub1.hi_class = NSClassFromString(@"HiPageSub1ViewController");
	page_error.hi_class = NSClassFromString(@"HiPageErrorViewController");
	page_sub_sub2.hi_class = NSClassFromString(@"HiPageSub2ViewController");
	page_main.hi_class = NSClassFromString(@"HiPageFilterViewController");
	root_controller.hi_class = NSClassFromString(@"HiRootViewController");
	nav_fourth.hi_class = NSClassFromString(@"HiNavigationFourthViewControoler");
	nav_first.hi_class = NSClassFromString(@"HiNavigationFirstViewControoler");
	nav_seconde.hi_class = NSClassFromString(@"HiNavigationSecondViewControoler");
	nav_third.hi_class = NSClassFromString(@"HiNavigationThirdViewControoler");
	parametes_main_receive.hi_class = NSClassFromString(@"HiParametesReceiveViewController");
	parametes_main.hi_class = NSClassFromString(@"HiParametesViewController");
	callback_main.hi_class = NSClassFromString(@"HiCallBackViewController");
	callback_sub.hi_class = NSClassFromString(@"HiCallBackSubViewController");
	network_main.hi_class = NSClassFromString(@"HiNetworkFilterViewController");
}

@end