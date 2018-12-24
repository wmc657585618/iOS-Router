# iOS-Router

## 描述
+ router 是为了解耦合而写的,包括了界面解耦,view-model 解耦

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
- (HiRouterBuilder *) build:(NSString *)path action:(HiRouterNavigationAction)action;

/**
创建 viewcontroller, 设置 源 viewcontroller 和导航跳转方式
*/
- (HiRouterBuilder *) build:(NSString *)path fromViewController:(UIViewController<HiRouterPageProtocol> *)viewController action:(HiRouterNavigationAction)action;

/**
创建 viewcontroller, 设置 源 viewcontroller ，参数和导航跳转方式
*/
- (HiRouterBuilder *) build:(NSString *)path fromViewController:(UIViewController<HiRouterPageProtocol> *)viewController withParameters:(id)parameters action:(HiRouterNavigationAction)action;

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
*/
- (void) invork:(NSObject<HiRouterViewModel> *)invork postData:(id)data;

```

### 网络拦截器
```
/**
url 预处理
*/
- (id<HiNetworkFilterProtocol>)performURL:(NSString *)url parameters:(id)parameters;

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
@property (nonatomic,readonly) HiRouterNavigationAction navigationAction;
```

### HiNetworkFilterProtocol
```
/**
自定义 结果
可以是 上传方式： POST,GET...
*/
@property (nonatomic,readonly) NSString *result;
```