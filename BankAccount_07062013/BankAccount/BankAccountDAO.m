//
//  BankAccountDAO.m
//  BankAccount
//
//  Created by El Nino on 6/7/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import "BankAccountDAO.h"

@implementation BankAccountDAO

@synthesize dataAccessHelper;

-(id)initWithDataAccessHelper:(FMDatabase *)helper {
    if (self = [super init]) {
        dataAccessHelper = helper;
    }
    return self;
}

- (BankAccountEntity *)getAccount:(NSString *)accountNumber {
    NSString *stm = nil;
    FMResultSet *r = [dataAccessHelper executeQuery:stm];
    BankAccountEntity *entity = [[BankAccountEntity alloc] init];
    if ([r next]) {        
        entity.accountNumber = [r objectForColumnName:@"accountNumber"];
        entity.balance = [r objectForColumnName:@"balance"];
        entity.openTimestamp = [r objectForColumnName:@"openTimestamp"];
    }
    return entity;
}

@end
