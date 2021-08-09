# iOS-Router

## 描述
+ router 是为了解耦合而写的,包括了界面解耦,view-model 解耦

# 2.0.0 之前
### 页面 (pages) 

#### 注册路由
```
- (void) registRoute:(NSDictionary<NSString *, NSString *> *)routeDictionary;
```

#### 使用
```
/**
 创建 viewcontroller
*/
- (HiRouterBuilder *) build:(NSString *)path;

/**
创建 viewcontroller, 并且设置导航跳转方式
*/
- (HiRouterBuilder *) build:(NSString *)path action:(HiRouterTransitioningAction)action;

/**
创建 viewcontroller, 设置 源 viewcontroller 和导航跳转方式
*/
- (HiRouterBuilder *) build:(NSString *)path fromViewController:(UIViewController<HiRouterPageProtocol> *)viewController action:(HiRouterTransitioningAction)action;

/**
创建 viewcontroller, 设置 源 viewcontroller ，参数和导航跳转方式
*/
- (HiRouterBuilder *) build:(NSString *)path fromViewController:(UIViewController<HiRouterPageProtocol> *)viewController withParameters:(id)parameters action:(HiRouterTransitioningAction)action;

/**
viewcontroller 回调
*/
- (BOOL) routerCallBackFromViewController:(UIViewController<HiRouterPageProtocol> *)viewController callBackParameters:(id)callBackParameters;
```

### view model
#### 绑定 view 和 model
```
/**
绑定 view 和 model
*/
- (void) buildViewModelInDynamic:(NSObject<HiRouterViewModel> *)objectA objectB:(NSObject<HiRouterViewModel> *)objectB;

/**
object 回调
return success or failed
*/
- (BOOL) invork:(NSObject<HiRouterViewModel> *)invork postData:(id)data;

```

### 网络拦截器
```
/**
url 预处理
*/
- (id<HiNetworkFilterProtocol>)performURL:(NSString *)url parameters:(id)parameters;

```
### 导航
```
**
 pop 到最后一个通过 path 创建的 viewController
 */
- (NSError *)popToPath:(NSString *)path parameters:(id)parameters animated:(BOOL)animated;

/**
 删除 viewController
 */
- (NSError *)removePath:(NSString *)path parameters:(id)parameters;

/**
  向路由中最后一个通过 path 创建的 viewController 发送数据
 */
- (NSError *)postParameters:(id)parameters toPath:(NSString *)path;

/**
 获取最后一个通过 path 的 viewController
 */
- (UIViewController<HiRouterPageProtocol> *)topViewControllerForPath:(NSString *)path;
```
### HiRouterPageProtocol
```
/**
接受到其它页面传来的参数
*/
- (void)recivedParameters:(id)parameters;

/**
接受到其它页面回传过来的参数
*/
- (void)recivedCallBack:(id)callBack;
```

### HiFilterProtocol
```
/**
优先级
当多个过滤条件满足时，执行优先级高的
*/
@property (nonatomic,readonly) NSUInteger priority;

/**
过滤条件
*/
@property (nonatomic,readonly) NSString *filterRegex;

/**
源路径
过滤器会将拦截到的路径回传过来
*/
@property (nonatomic,copy) NSString *originPath;

/**
转发的路径
*/
@property (nonatomic,readonly) NSString *forwardPath;

/**
参数
*/
@property (nonatomic,strong) id parameters;
```

### HiPageFilterProtocol
```
/**
跳转方式
*/
@property (nonatomic,readonly) HiRouterTransitioningAction transitioningAction;
```

### HiNetworkFilterProtocol
```
/**
自定义 结果
可以是 上传方式： POST,GET...
*/
@property (nonatomic,readonly) NSString *result;
```

# 2.0.0
## 使用
### 注册

#### 注解
```
@Router(xxxx/xxxx, AAAAAAContreoller)
@interface AAAAAAContreoller : UIViewController
```
#### 非注解
```
@"xxxx/xxxx".hi_class = [AAAAAAContreoller class];
```

### 实例化
```
+ (instancetype)hi_instanceForPath:(NSString *)path;

+ (instancetype)hi_instanceForPath:(NSString *)path withInitParameters:(id)parameters;

+ (instancetype)hi_instanceForPath:(NSString *)path withInitParameters:(id)parameters request:(id)request;
```

- ```AAAAAAContreoller *viewController = [AAAAAAContreoller hi_instanceForPath:@"xxxx/xxxx"];```

```
/// 创建 path 相对的 实例对象
- (id)hi_objectForPath:(NSString *)path;

/// 创建 path 相对的 实例对象
- (id)hi_objectForPath:(NSString *)path withInitParameters:(id)parameters;

/// 创建 path 相对的 实例对象
- (id)hi_objectForPath:(NSString *)path withInitParameters:(id)parameters request:(id)request;
```
- ```AAAAAAContreoller *viewController = [objc hi_instanceForPath:@"xxxx/xxxx"];```

### protocol
```
@protocol HiInit <NSObject>

+ (instancetype)hi_init:(id)parameters;

@end

@protocol HiNetWork <NSObject>

@optional
/// 得到 response (回调)
- (id)hi_response:(id)response;

/// 得到 request (请求)
- (id)hi_request:(id)request;

@end
```
#### 实现
```
@implementation AAAAAAContreoller

+ (instancetype)hi_init:(id)parameters{
    return [[self alloc] init];
}

// 请求参数
- (id)hi_request:(id)request {
    return @"";
}

// 回调参数
- (id)hi_response:(id)response {
    return @"";
}
@end
```

### 调用
#### ViewController
```
[self hi_pushPath:parameters withInitParameters:@"hello world" animated:true];
```

#### 实例化一个对象
```
[NSObject hi_instanceForPath:@"xxxx"]
```

### 回调
```
/// 回调
/// 优先 block
- (void)hi_makeResponse:(id)response;
```

```
[objc hi_makeResponse:@"test"];
```



## 过滤器
```
/// 过滤器 遵守 HiFilter 协议的
/// 只能有一个过滤器,多个 只有第一个 遵守 HiFilter 协议的 有效
- (void)becomeFilter;
+ (void)becomeFilter;
```

### 实现
```
- (HiFilterBody)hiFilterPath:(HiEnvironment *)env {
    return hiFilterMake(env.path, env.parameters);
}

- (HiFilterBody)hiFilterTransition:(HiEnvironment *)env {
    return hiFilterTransitioningMake(env.path, env.parameters, env.transition, env.modal);
}
```