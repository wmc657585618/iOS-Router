# iOS-Router

## 描述
+ router 是为了解耦合而写的,包括了界面解耦,view-model 解耦

### 页面 (pages) 

#### 注册路由
```
- (void) registRoute:(NSDictionary<NSString *, NSString *> *)routeDictionary;
```
> 该方法是将页面注册到路由,字典中的 key 表示页面路劲,value 表示页面类型

> 例如:

```
 {
 	"home" : "HomeViewController"
 }
```

> 其中 : home 表示 HomeViewCon 的路径 , HomeViewController 表示 home 对应的 class,

#### 使用
##### 跳转指定路径
```
/**
 跳转到指定路径
 */
- (HiRouterBuilder *) build:(NSString *)path;

/**
 跳转到指定路径 并且可以传参
 */
- (HiRouterBuilder *) build:(NSString *)path withParameters:(NSDictionary *)parameters;

/**
 跳转到指定路径 能够获取回调
 */
- (HiRouterBuilder *) build:(NSString *)path callBack:(HiRouterCallBack)callBack;

/**
 跳转到指定路径 能够传参和回调
 */
- (HiRouterBuilder *) build:(NSString *)path withParameters:(NSDictionary *)parameters callBack:(HiRouterCallBack)callBack;
```
> 例子:

```
[HiRouter.instance build:path callBack:^(NSDictionary *callBack) {
         
 }];
```

```
[HiRouter.instance build:path withParameters:@{key : value}];
```

##### 获取参数
```
- (NSDictionary *) parametersForViewController:(UIViewController *)viewController;
```

##### 获取回调(相邻 viewController 间回调)
```
- (HiRouterCallBack) callBackForViewController:(UIViewController *)viewController;
```
> 例子:

```
@property (copy, nonatomic) HiRouterCallBack callBack;

viewController 需要持有 HiRouterCallBack 对象,

self.callBack = [HiRouter.instance callBackForViewController:self];

在需要回传的地方
self.callBack(@{ key : value});

```

### view model
#### 注册 view model
```
- (void) registViewModelRoute:(NSDictionary<NSString *, NSDictionary *> *)viewModelRouteDictionary;
```
> 该方法是通过注册的方式绑定 view 和 model

> 字典的格式是:

```
{
	"login" : {
					"receiver" : "LoginReceiver",
					"invorker" : "LoginInvorker"
				}
}
```

> 其中 login 表示需要绑定的路径, 
> 
> receiver invorker 是固定字段,表示需要绑定的对象, 
> 
> LoginReceiver LoginInvorker 表示对应的 class,

#### 使用
```
/**
 通过注册路径的方式
 */
- (HiRouterVMBuilder *) buildViewModel:(NSString *)path;

/**
 动态手动绑定 view model
 */
- (HiRouterVMBuilder *) buildViewModelInDynamic:(id<HiRouterViewModel>)objectA objectB:(id<HiRouterViewModel>)objectB;

/**
  更新绑定的 view model
 */
- (void) updateVMBuilder:(HiRouterVMBuilder *)builder objectA:(id<HiRouterViewModel>)objectA objectB:(id<HiRouterViewModel>)objectB;

/**
  绑定一组 view model
 */
- (HiRouterVMBuilder *) buildViewModeGrouplInDynamic:(id<HiRouterViewModel>)objectA objectB:(id<HiRouterViewModel>)objectB reuseIdentifier:(NSString *)reuseIdentifier group:(HiRouterVMBuilderGroup *)group;
```

##### 绑定 view model( view 和 model 是一一对应,不能一对多);
> 在创建 view 和 model 的地方需要持有 HiRouterVMBuilder 或者 HiRouterVMBuilderGroup
> 
> HiRouterVMBuilder 单一的绑定
> 
> HiRouterVMBuilderGroup 可以绑定一组

```
@property (strong, nonatomic) HiRouterVMBuilder *vmBuilder;

@property (strong, nonatomic) HiRouterVMBuilderGroup *builderGroup;
```

##### HiRouterVMBuilder
> 通过注册路径的方式创建可以获取到 对应的 view 和 model 的实例, view 和 model 已经绑定
> 
> 手动绑定需要指定 view 和 model,


##### HiRouterVMBuilderGroup
> 包含了一组 HiRouterVMBuilder
> 
> 可以通过 key 获取 HiRouterVMBuilder.

#### view 和 model
##### HiRouterViewModel 接口
```
- (void) invorkerCommond:(HiRouterCommond)invorkerCommond;

- (void) received:(NSDictionary *)receive;
```
> view 和 model 必须遵循 RouterViewModel 接口

```
#import "HiRouterProtocol.h"

@interface Model : NSObject<HiRouterViewModel>

```
##### model 层
```
@property (copy, nonatomic) HiRouterCommond commond;

- (void)invorkerCommond:(HiRouterCommond)invorkerCommond {
    
    self.commond = invorkerCommond;
}
```
> model 需要持有 HiRouterCommond 对象, 实现 HiRouterViewModel 接口

> 在需要将数据传送给 view 时调用

```
self.commond(@{ key : value});
```

> 接受 view 传来的数据

```
- (void)received:(NSDictionary *)receive {
    
}
```

##### view 层
```
@property (copy, nonatomic) HiRouterCommond commond;

- (void)invorkerCommond:(HiRouterCommond)invorkerCommond {
    
    self.commond = invorkerCommond;
}
```
> view 需要持有 HiRouterCommond 对象, 实现 HiRouterViewModel 接口

> 在需要将数据传送给 model 时调用

```
self.commond(@{ key : value});
```

> 接受 model 传来的数据

```
- (void)received:(NSDictionary *)receive {
    
}
```
