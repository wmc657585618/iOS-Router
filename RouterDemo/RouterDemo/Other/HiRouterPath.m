#import "HiRouterPath.h"

// in HiParametesViewController.h
NSString *const PARAMETES_MAIN= @"parametes/main";

// in HiParametesReceiveViewController.h
NSString *const PARAMETES_MAIN_RECEIVE= @"parametes/main/receive";

// in HiCallBackViewController.h
NSString *const CALLBACK_MAIN= @"callback/main";

// in HiRootViewController.h
NSString *const ROOT= @"root";

// in HiCallBackSubViewController.h
NSString *const CALLBACK_SUB= @"callback/sub";

// in HiNetworkFilterViewController.h
NSString *const NETWORK_MAIN= @"network/main";

// in HiPageFilterViewController.h
NSString *const PAGE_MAIN= @"page/main";

// in HiPageSub1ViewController.h
NSString *const PAGE_SUB_SUB1= @"page/sub/sub1";

// in HiPageSub2ViewController.h
NSString *const PAGE_SUB_SUB2= @"page/sub/sub2";

// in HiPageErrorViewController.h
NSString *const PAGE_ERROR= @"page/error";

// in HiViewModelViewController.h
NSString *const VIEWMODEL= @"viewmodel";

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
			};
}

@end
