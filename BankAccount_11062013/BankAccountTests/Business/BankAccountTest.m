//
//  BankAccountTest.m
//  BankAccount
//
//  Created by El Nino on 6/11/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import "Kiwi.h"
#import "BankAccount.h"

SPEC_BEGIN(BankAccountTest)
describe(@"BankAccount test", ^{
    __block BankAccountDAO *mockDAO;
    __block BankAccount *sut;
    
    beforeEach(^{
        mockDAO = [BankAccountDAO mock];
        sut = [[BankAccount alloc] initWithDAO:mockDAO];
    });
    
    afterEach(^{
        mockDAO = nil;
        sut = nil;
    });
    
    context(@"BankAccount setup", ^{
        it(@"dao property should is kind of BankAccountDAO class", ^{
            [[sut.dao should] equal:mockDAO];
        });
        
        it(@"Open new account with account number", ^{            
            NSString *accountNumberWillOpenString = [NSString mock];
            Account *mockAccount = [Account mock];
            
            __block Account *accountShouldReturn;
            
            [[sut should] receive:@selector(createAccountWithNumber:) andReturn:mockAccount withArguments:accountNumberWillOpenString];
            
            
            KWCaptureSpy *spy = [mockDAO captureArgument:@selector(insertNewAccount:success:fail:) atIndex:1];
            
            [sut openNewAccountWithNumber:accountNumberWillOpenString success:^(Account *acc) {
                accountShouldReturn = acc;
            } fail:nil];
            
            void (^sucsessInsertDBBlock)(Account *account) = spy.argument;
            sucsessInsertDBBlock(mockAccount);
            [[accountShouldReturn should] equal:mockAccount];
        });
        
        it(@"Get account with account number", ^{
            NSString *accountNumberWillGet = [NSString nullMock];
            __block Account *acccountShouldGet = [Account mock];
            
            __block Account *accountReturn;
            
            KWCaptureSpy *spy = [mockDAO captureArgument:@selector(getAccountWithAccountNUmber:success:fail:) atIndex:1];
            
            [sut getAccountWithAccountNUmber:accountNumberWillGet success:^(Account *acc) {
                accountReturn = acc;
            } fail:nil];
            
            void (^sucsessGetBlock)(Account *account) = spy.argument;
            sucsessGetBlock(acccountShouldGet);
            
            [acccountShouldGet stub:@selector(accountNumber) andReturn:accountNumberWillGet];
            [[accountReturn.accountNumber should] equal:accountNumberWillGet];
        });
        
        it(@"Deposte an account with mount", ^{
            
            NSString *accountNumberString = [NSString nullMock];
            __block Account *accountBerforeDeposit = [Account nullMock];
            __block Account *accountAfterDeposit = [Account mock];
            
            __block Account *realAccount;
            
            [[mockDAO should] receive:@selector(getAccountWithAccountNUmber:success:fail:)];
            
            KWCaptureSpy *spy = [sut captureArgument:@selector(getAccountWithAccountNUmber:success:fail:) atIndex:1];    
            
            
            [sut depositWithAccountNUmber:accountNumberString amount:@10 description:nil success:^(Account *acc) {
                realAccount = acc;
            } fail:nil];
            
            KWCaptureSpy *spy1 = [mockDAO captureArgument:@selector(depositAccount:withAmount:description:success:fail:) atIndex:3];
            
            void (^sucsessGetBlock)(Account *account) = spy.argument;
            sucsessGetBlock(accountBerforeDeposit);
            
            void (^successDepositBlock)(Account *account) = spy1.argument;
            successDepositBlock(accountAfterDeposit);
            
            [accountAfterDeposit stub:@selector(balance) andReturn:@([accountBerforeDeposit.balance integerValue] + 10)];
            
            [[realAccount.balance should] equal:@([accountBerforeDeposit.balance integerValue] + 10)]; // real account should increase 10
        });
    });
});
SPEC_END
