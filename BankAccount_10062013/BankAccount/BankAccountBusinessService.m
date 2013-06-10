//
//  BankAccountBusinessService.m
//  BankAccount
//
//  Created by El Nino on 6/10/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import "BankAccountBusinessService.h"

@implementation BankAccountBusinessService

@synthesize bankAccountDAO;

-(id)initWithDAO:(BankAccountDAO *)dao {
    if (self = [super init]) {
        bankAccountDAO = dao;
    }
    return self;
}

-(BankAccountEntity *)open:(NSString *)accountNumber {
    BankAccountEntity *re = [[BankAccountEntity alloc] init];
    [re setAccountNumber:accountNumber];
    [re setBalance:@0];
    return re;
}

-(NSNumber *)openNewAccount:(NSString *)accountNumer {
    BankAccountEntity *entity = [self open:accountNumer];
    NSNumber * value =  [bankAccountDAO insertEntity:entity];
    return value;
}

-(BankAccountEntity *)getAccountWithNumber:(NSString *)number {
    BankAccountEntity *entity = [bankAccountDAO getAccountWithAccountNumber:number];
    return entity;
}

-(BankAccountEntity *)desposit:(NSString *)acc amount:(NSNumber *)number description:(NSString *)des {
    return nil;
}

@end
