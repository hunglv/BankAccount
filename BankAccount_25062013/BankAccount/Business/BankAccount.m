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

-(Account *)open:(NSString *)accNum {
    Account *accountWillInsert = [[Account alloc] init];
    accountWillInsert.timeOpened = [NSDate date];
    BOOL insertSuccess = [accountDAO insertAccount:accountWillInsert];
    if (!insertSuccess) {
        accountWillInsert = nil;
    }
    return accountWillInsert;
}

@end
