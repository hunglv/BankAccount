//
//  BankAccountDAOTest.m
//  BankAccount
//
//  Created by El Nino on 6/7/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import "Kiwi.h"
#import "BankAccountDAO.h"
#import "FMDatabase.h"
#import "BankAccountEntity.h"

SPEC_BEGIN(BankAccountDAOTest)
describe(@"BankAccountDAO test", ^{
    context(@"BankAccountDAO setup", ^{
        it(@"have a property dataAccessHelper is type of class FMDatabase", ^{
            FMDatabase *helper = [[FMDatabase alloc] init];
            BankAccountDAO *dao = [[BankAccountDAO alloc] initWithDataAccessHelper:helper];
            [[dao.dataAccessHelper should] equal:helper];
        });
    });
    
    context(@"Get Account with account Number", ^{
        it(@"test get account", ^{
            NSString *accountNumberWillGet  = @"1234567890";
            NSNumber *balanceWillGet = @123;
            NSDate *dateWillGet = [NSDate date];
            FMDatabase *mockDatabase = [FMDatabase nullMock];
            BankAccountDAO *dao = [[BankAccountDAO alloc] initWithDataAccessHelper:mockDatabase];
            FMResultSet *mockResultSet = [FMResultSet nullMock];
            [mockDatabase stub:@selector(executeQuery:) andReturn:mockResultSet];
            [mockResultSet stub:@selector(next) andReturn:theValue(YES)];
            [mockResultSet stub:@selector(objectForColumnName:) andReturn:accountNumberWillGet withArguments:@"accountNumber"];
            [mockResultSet stub:@selector(objectForColumnName:) andReturn:balanceWillGet withArguments:@"balance"];
            [mockResultSet stub:@selector(objectForColumnName:) andReturn:dateWillGet withArguments:@"openTimestamp"];
            
            BankAccountEntity *bankAccountShouldRecive = [BankAccountEntity nullMock];
            [bankAccountShouldRecive stub:@selector(accountNumber) andReturn:accountNumberWillGet];
            [bankAccountShouldRecive stub:@selector(balance) andReturn:balanceWillGet];
            [bankAccountShouldRecive stub:@selector(openTimestamp) andReturn:dateWillGet];
            
            BankAccountEntity *accountGet = [dao getAccount:accountNumberWillGet];
            [[accountGet.accountNumber should] equal:bankAccountShouldRecive.accountNumber];
        });
    });
});
SPEC_END
