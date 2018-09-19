//
//  KVOPerson.h
//  GithubDemoTest
//
//  Created by hb on 2018/9/17.
//  Copyright © 2018年 com.bm.hb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KVOAccount.h"

@class KVOAccount;

@interface KVOPerson : NSObject

@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, assign, readwrite) NSUInteger age;
@property (nonatomic, strong, readwrite) KVOAccount *account;

- (instancetype)initWithName:(NSString *)name age:(NSUInteger)age account:(KVOAccount *)account;

- (void)addObserver;

@end
