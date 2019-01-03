#import <Foundation/Foundation.h>

extern NSString *const PARAMETES_MAIN; // in HiParametesViewController.h

extern NSString *const PARAMETES_MAIN_RECEIVE; // in HiParametesReceiveViewController.h

extern NSString *const CALLBACK_MAIN; // in HiCallBackViewController.h

extern NSString *const ROOT; // in HiRootViewController.h

extern NSString *const CALLBACK_SUB; // in HiCallBackSubViewController.h

extern NSString *const NETWORK_MAIN; // in HiNetworkFilterViewController.h

extern NSString *const PAGE_MAIN; // in HiPageFilterViewController.h

extern NSString *const PAGE_SUB_SUB1; // in HiPageSub1ViewController.h

extern NSString *const PAGE_SUB_SUB2; // in HiPageSub2ViewController.h

extern NSString *const PAGE_ERROR; // in HiPageErrorViewController.h

extern NSString *const VIEWMODEL; // in HiViewModelViewController.h

@interface HiRouterPath : NSObject

@property (nonatomic, readonly, class) NSDictionary *pathDictionary;

@end
