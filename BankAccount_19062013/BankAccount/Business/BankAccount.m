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

-(Account *)open:(NSString *)accountNumber {
    Account *account = [[Account alloc] init];
    account.accountNumber = accountNumber;
    account.balance = @0;
    if ([accountDAO insertNewAccount:account]) {
        return account;
    }
    return nil;
}

-(Account *)getAccount:(NSString *)accountNumber {
    Account *accountGet = [accountDAO getAccountWithAccountNumber:accountNumber];
    return accountGet;
}

@end
