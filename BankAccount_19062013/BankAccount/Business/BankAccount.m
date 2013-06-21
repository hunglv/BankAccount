//
//  BankAccount.m
//  BankAccount
//
//  Created by El Nino on 6/19/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import "BankAccount.h"

@implementation BankAccount

@synthesize accountDAO;
@synthesize accountLogDAO;

-(Account *)open:(NSString *)accountNumber {
    Account *account = [[Account alloc] init];
    account.accountNumber = accountNumber;
    account.balance = @0;
    account.timeStamp = [NSDate date];
    if ([accountDAO insertNewAccount:account]) {
        return account;
    }
    return nil;
}

-(Account *)getAccount:(NSString *)accountNumber {
    Account *accountGet = [accountDAO getAccountWithAccountNumber:accountNumber];
    return accountGet;
}

-(Account *)depositAccountNumber:(NSString *)account amount:(NSNumber *)amount description:(NSString *)description {
    Account *accountGet = [self getAccount:account];
    Account *accountAfter = [[Account alloc] init];
    accountAfter.balance = @(accountGet.balance.doubleValue + amount.doubleValue);
    accountAfter.accountNumber = accountGet.accountNumber;
    accountAfter.timeStamp = accountGet.timeStamp;
    if([accountDAO updateAccount:accountAfter]) {
        AccountLog *accLog = [self createAccountLogWithAccountNumber:account amount:amount description:description];
        [accountLogDAO insertAccountLog:accLog];
        return accountAfter;
    }
    return nil;
}

-(AccountLog *)createAccountLogWithAccountNumber:(NSString *)accountNumber amount:(NSNumber *)amount description:(NSString *)des {
    AccountLog *accLog = [[AccountLog alloc] init];
    accLog.accountNumber = accountNumber;
    accLog.amount = amount;
    accLog.description = des;
    accLog.timeStamp = [NSDate date];
    
    return accLog;
}
@end
