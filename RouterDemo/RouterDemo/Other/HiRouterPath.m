#import "HiRouterPath.h"

// in HiParametesViewController.h
NSString *const PARAMETES_MAIN= @"parametes/main";

NSString *const HiParametesViewController= @"HiParametesViewController";

// in HiParametesReceiveViewController.h
NSString *const PARAMETES_MAIN_RECEIVE= @"parametes/main/receive";

NSString *const HiParametesReceiveViewController= @"HiParametesReceiveViewController";

// in HiCallBackViewController.h
NSString *const CALLBACK_MAIN= @"callback/main";

NSString *const HiCallBackViewController= @"HiCallBackViewController";

// in HiRootViewController.h
NSString *const ROOT= @"root";

NSString *const HiRootViewController= @"HiRootViewController";

// in HiCallBackSubViewController.h
NSString *const CALLBACK_SUB= @"callback/sub";

NSString *const HiCallBackSubViewController= @"HiCallBackSubViewController";

// in HiNetworkFilterViewController.h
NSString *const NETWORK_MAIN= @"network/main";

NSString *const HiNetworkFilterViewController= @"HiNetworkFilterViewController";

// in HiPageFilterViewController.h
NSString *const PAGE_MAIN= @"page/main";

NSString *const HiPageFilterViewController= @"HiPageFilterViewController";

// in HiPageSub1ViewController.h
NSString *const PAGE_SUB_SUB1= @"page/sub/sub1";

NSString *const HiPageSub1ViewController= @"HiPageSub1ViewController";

// in HiPageSub2ViewController.h
NSString *const PAGE_SUB_SUB2= @"page/sub/sub2";

NSString *const HiPageSub2ViewController= @"HiPageSub2ViewController";

// in HiPageErrorViewController.h
NSString *const PAGE_ERROR= @"page/error";

NSString *const HiPageErrorViewController= @"HiPageErrorViewController";

// in HiViewModelViewController.h
NSString *const VIEWMODEL= @"viewmodel";

NSString *const HiViewModelViewController= @"HiViewModelViewController";

// in HiNavigationFirstViewControoler.h
NSString *const NAV_FIRST= @"nav/first";

NSString *const HiNavigationFirstViewControoler= @"HiNavigationFirstViewControoler";

// in HiNavigationFourthViewControoler.h
NSString *const NAV_FOURTH= @"nav/fourth";

NSString *const HiNavigationFourthViewControoler= @"HiNavigationFourthViewControoler";

// in HiNavigationThirdViewControoler.h
NSString *const NAV_THIRD= @"nav/third";

NSString *const HiNavigationThirdViewControoler= @"HiNavigationThirdViewControoler";

// in HiNavigationSecondViewControoler.h
NSString *const NAV_SECONDE= @"nav/seconde";

NSString *const HiNavigationSecondViewControoler= @"HiNavigationSecondViewControoler";

@implementation HiRouterPath

+ (NSDictionary *)pathDictionary {
	return @{
			PARAMETES_MAIN: @"HiParametesViewController",
			PARAMETES_MAIN_RECEIVE: @"HiParametesReceiveViewController",
			CALLBACK_MAIN: @"HiCallBackViewController",
			ROOT: @"HiRootViewController",
			CALLBACK_SUB: @"HiCallBackSubViewController",
			NETWORK_MAIN: @"HiNetworkFilterViewController",
			PAGE_MAIN: @"HiPageFilterViewController",
			PAGE_SUB_SUB1: @"HiPageSub1ViewController",
			PAGE_SUB_SUB2: @"HiPageSub2ViewController",
			PAGE_ERROR: @"HiPageErrorViewController",
			VIEWMODEL: @"HiViewModelViewController",
			NAV_FIRST: @"HiNavigationFirstViewControoler",
			NAV_FOURTH: @"HiNavigationFourthViewControoler",
			NAV_THIRD: @"HiNavigationThirdViewControoler",
			NAV_SECONDE: @"HiNavigationSecondViewControoler",
			};
}

@end
