//
//  BankAccount.m
//  BankAccount
//
//  Created by El Nino on 6/11/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import "BankAccount.h"
#import "AccountLog.h"

@implementation BankAccount

@synthesize dao;

-(id)initWithDAO:(BankAccountDAO *)_dao {
    if (self = [super init]) {
        dao = _dao;
    }
    return self;
}

-(Account *)createAccountWithNumber:(NSString *)accountNumberString {
    return nil;
}

-(AccountLog *)createAccontLogWithNumber:(NSString *)string amount:(NSNumber *)amount description:(NSString *)description timestamp:(NSDate *)date {
    return nil;
}

-(NSDate *)timeStampNow {
    return nil;
}

- (void)openNewAccountWithNumber:(NSString *)accountString success:(void (^)(Account * acc))block fail:(void (^)(NSError *error)) eBlock {
    Account *account = [self createAccountWithNumber:accountString];
    [dao insertNewAccount:account success:^(Account *accountInserted) {
        if (block) {
            block(accountInserted);
        }
    } fail:^(NSError *error) {
        
    }];
}

-(void)getAccountWithAccountNUmber:(NSString *)accountString success:(void (^)(Account *))block fail:(void (^)(NSError *))eBlock {
    [dao getAccountWithAccountNUmber:accountString success:^(Account *acc) {
        if (block) {
            block(acc);
        }
    } fail:^(NSError *error) {
        
    }];
}

- (void)depositWithAccountNUmber:(NSString *)accountString amount:(NSNumber *)amount description:(NSString *)descrip success:(void (^)(Account * acc, AccountLog *accLog))block fail:(void (^)(NSError *error)) eBlock  {
    [self getAccountWithAccountNUmber:accountString success:^(Account *acc) {
        [dao depositAccount:acc withAmount:amount description:descrip success:^(NSDictionary *dict) {
            if (block) {
                Account *account = [dict objectForKey:@"account"];
                AccountLog *accLog = [dict objectForKey:@"accountLog"];
                block(account, accLog);
            }
        } fail:^(NSError *error) {
            
        }];
    } fail:^(NSError *error) {
        
    }];
}

- (void)withdrawAccountNUmber:(NSString *)accountString amount:(NSNumber *)amount description:(NSString *)descrip success:(void (^)(Account * acc,AccountLog *accLog))block fail:(void (^)(NSError *error)) eBlock  {
    [self getAccountWithAccountNUmber:accountString success:^(Account *acc) {
        [dao withdrawAccount:acc withAmount:amount description:descrip success:^(NSDictionary *dict) {
            if (block) {
                Account *account = [dict objectForKey:@"account"];
                AccountLog *accLog = [dict objectForKey:@"accountLog"];
                block(account, accLog);
            }
        } fail:^(NSError *error) {
            
        }];
    } fail:^(NSError *error) {
        
    }];
}

@end
