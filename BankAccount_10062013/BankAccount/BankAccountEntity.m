//
//  BankAccountEntity.m
//  BankAccount
//
//  Created by El Nino on 6/10/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import "BankAccountEntity.h"

@implementation BankAccountEntity

@synthesize accountNumber;
@synthesize balance;
@synthesize openTimestamp;

- (id)init
{
    self = [super init];
    if (self) {
        accountNumber = [[NSString alloc] init];
        balance = [NSNumber numberWithInteger:0];
        openTimestamp = [NSDate date];
    }
    return self;
}

@end
