//
//  BankAccount.m
//  BankAccount
//
//  Created by El Nino on 6/25/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import "BankAccount.h"

@implementation BankAccount

@synthesize accountDAO;
@synthesize transactionDAO;

-(Account *)open:(NSString *)accNum {
    Account *accountWillInsert = [[Account alloc] init];
    accountWillInsert.timeOpened = [NSDate date];
    accountWillInsert.accountNumber = accNum;
    accountWillInsert.balance = @0;
    BOOL insertSuccess = [accountDAO insertAccount:accountWillInsert];
    if (!insertSuccess) {
        accountWillInsert = nil;
    }
    return accountWillInsert;
}

-(Account *)getAccount:(NSString *)accNum {
    Account *accountGet = [accountDAO getAccountWithAccountNumber:accNum];
    return accountGet;
}

-(void)depositAccountNumber:(NSString *)accNum amount:(NSNumber *)amount description:(NSString *)description {
    Account *accountBefore = [self getAccount:accNum];
    if (accountBefore) {
        accountBefore.balance = @(accountBefore.balance.doubleValue + amount.doubleValue);
        if ([accountDAO updateAccount:accountBefore]) {
            Transaction *newTrans = [[Transaction alloc] init];
            newTrans.accountNumber = accNum;
            newTrans.amount = amount;
            newTrans.description = description;
            newTrans.timeStamp = [NSDate date];
            [transactionDAO insertTransaction:newTrans];
        }
    }
}

- (void)withdrawAccountNumber:(NSString *)accNum amount:(NSNumber *)amount description:(NSString *)description {
    Account *accountBefore = [self getAccount:accNum];
    if (accountBefore) {
        accountBefore.balance = @(accountBefore.balance.doubleValue - amount.doubleValue);
        if ([accountDAO updateAccount:accountBefore]) {
            Transaction *newTrans = [[Transaction alloc] init];
            newTrans.accountNumber = accNum;
            newTrans.amount = @((-1) * amount.doubleValue);
            newTrans.description = description;
            newTrans.timeStamp = [NSDate date];
            [transactionDAO insertTransaction:newTrans];
        }
    }
}

-(NSArray *)transactionOccuredWithAccountNumber:(NSString *)accNum {
    NSArray *result = nil;
    result = [transactionDAO transactionOccuredWithAccountNumber:accNum];
    return result;
}

-(NSArray *)transactionOccuredWithAccountNumber:(NSString *)accNum startTime:(NSDate *)start endTime:(NSDate *)end {
    NSArray *result = nil;
    result = [transactionDAO transactionOccuredWithAccountNumber:accNum startTime:start endTime:end];
    return result;
}

-(NSArray *)transactionOccuredWithAccountNumber:(NSString *)accNum numberTransactions:(NSNumber *)number {
    NSArray *result = nil;
    result = [transactionDAO transactionOccuredWithAccountNumber:accNum numberTransactions:number];
    return result;
}

@end
