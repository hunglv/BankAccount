//
//  BankAccountEntity.m
//  BankAccount
//
//  Created by El Nino on 6/7/13.
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
        balance = [[NSNumber alloc] initWithInt:-1];
        openTimestamp = [[NSDate alloc] init];
    }
    return self;
}

@end
