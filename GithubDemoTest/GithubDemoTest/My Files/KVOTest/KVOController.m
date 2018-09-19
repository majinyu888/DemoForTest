//
//  KVOController.m
//  GithubDemoTest
//
//  Created by hb on 2018/9/17.
//  Copyright © 2018年 com.bm.hb. All rights reserved.
//



/*
 注册监听器
 监听器对象为observer，被监听对象为消息的发送者即方法的调用者在回调函数中会被回传
 监听的属性路径为keyPath支持点语法的嵌套
 监听类型为options支持按位或来监听多个事件类型
 监听上下文context主要用于在多个监听器对象监听相同keyPath时进行区分
 添加监听器只会保留监听器对象的地址，不会增加引用，也不会在对象释放后置空，因此需要自己持有监听对象的强引用，该参数也会在回调函数中回传
 */
// - (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

/*
 删除监听器
 监听器对象为observer，被监听对象为消息的发送者即方法的调用者，应与addObserver方法匹配
 监听的属性路径为keyPath，应与addObserver方法的keyPath匹配
 监听上下文context，应与addObserver方法的context匹配
 */
// - (void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(nullable void *)context API_AVAILABLE(macos(10.7), ios(5.0), watchos(2.0), tvos(9.0));

/*
 与上一个方法相同，只是少了context参数
 推荐使用上一个方法，该方法由于没有传递context可能会产生异常结果
 */
// - (void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

/*
 监听器对象的监听回调方法
 keyPath即为监听的属性路径
 object为被监听的对象
 change保存被监听的值产生的变化
 context为监听上下文，由add方法回传
 */
// - (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context;

#import "KVOController.h"

#import "KVOPerson.h"
#import "KVOAccount.h"

@interface KVOController ()

@property (nonatomic, strong) KVOPerson *person;

@end

@implementation KVOController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    KVOAccount *account = [[KVOAccount alloc] init];
    account.accountNumber = @"10";
    account.balance = 100;
    self.person = [[KVOPerson alloc] initWithName:@"JAMES & TMac" age:10 account:account];
    
 
    
    /// 监听 account.balance
    /// 监听 person.name
    [self.person addObserver];
       _person.account.balance = 10000;
}









@end
