//
//  BankAccountBusinessServiceTest.m
//  BankAccount
//
//  Created by El Nino on 6/10/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import "Kiwi.h"
#import "BankAccountBusinessService.h"
#import "BankAccountEntity.h"
#import "BankAccountDAO.h"

SPEC_BEGIN(BankAccountBusinessServiceTest)
describe(@"BankAccountBusinessService test", ^{
    context(@"open new BankAccountEntity", ^{
        it(@"open new BankAccountEntity should return balance is zero", ^{
            BankAccountBusinessService *service = [[BankAccountBusinessService alloc] init];
            NSString *accountNumberString = @"1234567890";
            BankAccountEntity *enRe = [service open:accountNumberString];
            BankAccountEntity *entityShouldReturn = [BankAccountEntity mock];
            [entityShouldReturn stub:@selector(accountNumber) andReturn:accountNumberString];
            [entityShouldReturn stub:@selector(balance) andReturn:@0];
            
            [[enRe.accountNumber should] equal:entityShouldReturn.accountNumber];
            [[enRe.balance should] equal:entityShouldReturn.balance];
        });
        
        it(@"bankAccountDAO property shoud be exits", ^{
            BankAccountDAO *dao = [BankAccountDAO mock];
            BankAccountBusinessService *service = [[BankAccountBusinessService alloc] initWithDAO:dao];
            [[service.bankAccountDAO should] equal:dao];
        });
        
        it(@"When open new account insert to database success", ^{
            NSString *accountNumber = [NSString nullMock];
            BankAccountDAO *dao = [BankAccountDAO mock];
            BankAccountEntity *mockentity = [BankAccountEntity mock];
            BankAccountBusinessService *service = [[BankAccountBusinessService alloc] initWithDAO:dao];
            
            [[service should] receive:@selector(open:) andReturn:mockentity withArguments:accountNumber];
            
            [dao stub:@selector(insertEntity:) andReturn:[NSNumber numberWithBool:YES] withArguments:mockentity];
            NSNumber *result = [service openNewAccount:accountNumber];
            [[result should] equal:[NSNumber numberWithBool:YES]];
        });
    });
    
    context(@"get Account", ^{
        it(@"Get an account with acountnumber", ^{
            NSString *accountNumber = [NSString mock];
            BankAccountDAO *dao = [BankAccountDAO mock];
            BankAccountEntity *mockentity = [BankAccountEntity mock];
            BankAccountBusinessService *service = [[BankAccountBusinessService alloc] initWithDAO:dao];
            
            [dao stub:@selector(getAccountWithAccountNumber:) andReturn:mockentity withArguments:accountNumber];
            BankAccountEntity *resultEntity = [service getAccountWithNumber:accountNumber];
            [mockentity stub:@selector(accountNumber) andReturn:accountNumber];
            [[resultEntity.accountNumber should] equal:accountNumber];
        });
    });
    
    context(@"deposit an account", ^{
        it(@"deposit an account with amount", ^{
            NSString *accountNumber = [NSString mock];
            NSNumber *amount = [NSNumber mock];
            NSString *description = [NSString mock];
            BankAccountDAO *dao = [BankAccountDAO mock];
            BankAccountEntity *mockentity = [BankAccountEntity mock];
            BankAccountBusinessService *service = [[BankAccountBusinessService alloc] initWithDAO:dao];
            
            [dao stub:@selector(depositAccount:amount:description:) andReturn:mockentity withArguments:accountNumber, amount, description];
            BankAccountEntity *resultEntity = [service desposit:accountNumber amount:amount description:description];
            [mockentity stub:@selector(accountNumber) andReturn:accountNumber];
            [[resultEntity.accountNumber should] equal:accountNumber];
        });
    });
});
SPEC_END
