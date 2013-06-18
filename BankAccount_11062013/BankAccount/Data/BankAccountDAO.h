//
//  BankAccountDAO.h
//  BankAccount
//
//  Created by El Nino on 6/11/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
#import "AccountLog.h"

@interface BankAccountDAO : NSObject

-(void)insertNewAccount:(Account *)account success:(void (^)(Account *accountInserted))block fail:(void(^)(NSError *error))errBlock;

- (void)getAccountWithAccountNUmber:(NSString *)accountString success:(void (^)(Account * acc))block fail:(void (^)(NSError *error)) eBlock ;

- (void)depositAccount:(Account *)account withAmount:(NSNumber *)amount description:(NSString *)des success:(void (^)(NSDictionary * dict))block fail:(void (^)(NSError *error)) eBlock ;// If success dict will return with format {@"account" : account_objcect, @"accountLog":account_log_object}

- (void)withdrawAccount:(Account *)account withAmount:(NSNumber *)amount description:(NSString *)des success:(void (^)(NSDictionary * dict))block fail:(void (^)(NSError *error)) eBlock;

- (void)getTransFromAccountNumber:(NSString *)accountNumber start:(NSString *)startTime stop:(NSString *)stopTime newestTrans:(NSNumber *)number success:(void (^)(NSDictionary * dict))block fail:(void (^)(NSError *error)) eBlock;

@end
