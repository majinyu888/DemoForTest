//
//  KVOPerson.m
//  GithubDemoTest
//
//  Created by hb on 2018/9/17.
//  Copyright © 2018年 com.bm.hb. All rights reserved.
//

#import "KVOPerson.h"
#import "KVOAccount.h"

@interface KVOPerson()

@end

@implementation KVOPerson

- (instancetype)initWithName:(NSString *)name age:(NSUInteger)age account:(KVOAccount *)account {
    if (self = [super init]) {
        self.name = name;
        self.age = age;
        self.account = account;
    }
    return self;
}

- (void)addObserver {
    /*
     监听器对象为Person类的对象本身，被监听的对象为Person类对象持有的account
     监听的属性路径为account的balance，可以监听嵌套的对象比如account有一个对象是bank可以监听bank是否营业，可以写"bank.isOpen"
     监听上下文设置为nil，相信很多人在使用的时候都会这么写
     */
    [self.account addObserver:self forKeyPath:@"balance" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
}

// 监听器回调方法  override

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    //判断被监听对象是否为account，并且通过NSString来判断监听属性路径是否一致
    if (object == self.account && [keyPath isEqualToString:@"balance"]) {
        NSLog(@"NewBalance: %lf", self.account.balance);
    } else if (object == self && [keyPath isEqualToString:@"name"]) {
        NSLog(@"NewName: %@", self.name);
    }
}



- (void)dealloc {
    /*
     切记，当我们添加监听器时一定要在对象被销毁前删除该监听器
     删除监听器传递的参数要与添加监听器传参一致
     监听器也不可以重复删除，如果没有注册监听器而去执行删除操作也会抛出异常
     */
    [self.account removeObserver:self forKeyPath:@"balance"];
     [self removeObserver:self forKeyPath:@"name"];
}

@end
