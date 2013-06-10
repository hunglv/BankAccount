//
//  BankAccountDAO.m
//  BankAccount
//
//  Created by El Nino on 6/10/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import "BankAccountDAO.h"

@implementation BankAccountDAO
@synthesize dataAccessHelper;

-(id)initWithDatabaseAccess:(FMDatabase *)dataAccess {
    if (self = [super init]) {
        dataAccessHelper = dataAccess;
    }
    return self;
}

-(NSNumber *)insertEntity:(BankAccountEntity *)entity {
    return nil;
}

-(BankAccountEntity *)getAccountWithAccountNumber:(NSString *)number {
    return nil;
}

-(BankAccountEntity *)deposit:(NSString *)accNumb amount:(NSNumber *)number description:(NSString *)description {
    return nil;
}

@end
