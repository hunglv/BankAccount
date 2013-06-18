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
        mockDAO = [BankAccountDAO nullMock];
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
            
            KWCaptureSpy *spy = [sut captureArgument:@selector(getAccountWithAccountNUmber:success:fail:) atIndex:1];    
            
            KWCaptureSpy *spy1 = [mockDAO captureArgument:@selector(depositAccount:withAmount:description:success:fail:) atIndex:3];
            
            [sut depositWithAccountNUmber:accountNumberString amount:@10 description:nil success:^(Account *acc, AccountLog *accLog) {
                realAccount = acc;
            } fail:nil];           
            
            void (^sucsessGetBlock)(Account *account) = spy.argument;
            sucsessGetBlock(accountBerforeDeposit);
            
            void (^successDepositBlock)(NSDictionary *dict) = spy1.argument;
            successDepositBlock(@{@"account":accountAfterDeposit});
            
            [accountAfterDeposit stub:@selector(balance) andReturn:@([accountBerforeDeposit.balance integerValue] + 10)];
            
            [[realAccount.balance should] equal:@([accountBerforeDeposit.balance integerValue] + 10)]; // real account should increase 10
        });
        
        it(@"deposte an account with amount should add an accountLog to database", ^{
            NSString *accountNumberString = [NSString nullMock];
            NSString *descriptionString = [NSString nullMock];
            __block Account *accountBerforeDeposit = [Account nullMock];
            __block Account *accountAfterDeposit = [Account nullMock];
            __block AccountLog *accountLogAfterDepost = [AccountLog nullMock];
            __block NSNumber *amountWillDespote = [NSNumber nullMock];
            __block AccountLog *realAccountLog;
            
            KWCaptureSpy *spy = [sut captureArgument:@selector(getAccountWithAccountNUmber:success:fail:) atIndex:1];
            
            KWCaptureSpy *spy1 = [mockDAO captureArgument:@selector(depositAccount:withAmount:description:success:fail:) atIndex:3];
            
            [[sut should] receive:@selector(getAccountWithAccountNUmber:success:fail:) withArguments:accountNumberString,any(),any()];
            [sut depositWithAccountNUmber:accountNumberString amount:amountWillDespote description:descriptionString success:^(Account *acc, AccountLog *accLog) {
                realAccountLog = accLog;
            } fail:nil];
            
            void (^sucsessGetBlock)(Account *account) = spy.argument;
            sucsessGetBlock(accountBerforeDeposit);
            
            void (^successDepositBlock)(NSDictionary *dict) = spy1.argument;
            successDepositBlock(@{@"account":accountAfterDeposit, @"accountLog":accountLogAfterDepost});
                        
            [[realAccountLog should] equal:accountLogAfterDepost];
        });
        
        it(@"withDraw an account", ^{
            NSString *accountNumberString = [NSString nullMock];
            NSString *descriptionString = [NSString nullMock];
            __block Account *accountBerforeWithdraw = [Account nullMock];
            __block Account *accountAfterWithdraw = [Account nullMock];
            __block AccountLog *accountLogAfterWithdraw = [AccountLog nullMock];
            __block NSNumber *amountWillWithdraw = [NSNumber nullMock];
            __block AccountLog *realAccountLog;
            __block Account *realAccount;
            
            KWCaptureSpy *spy = [sut captureArgument:@selector(getAccountWithAccountNUmber:success:fail:) atIndex:1];
            
            KWCaptureSpy *spy1 = [mockDAO captureArgument:@selector(withdrawAccount:withAmount:description:success:fail:) atIndex:3];
            
            [[mockDAO should] receive:@selector(withdrawAccount:withAmount:description:success:fail:) withArguments:accountBerforeWithdraw,amountWillWithdraw,descriptionString,any(),any()];
            [[sut should] receive:@selector(getAccountWithAccountNUmber:success:fail:) withArguments:accountNumberString,any(),any()];
            
            [sut withdrawAccountNUmber:accountNumberString amount:amountWillWithdraw description:descriptionString success:^(Account *acc, AccountLog *accLog) {
                realAccountLog = accLog;
                realAccount = acc;
            } fail:nil];
            void (^sucsessGetBlock)(Account *account) = spy.argument;
            sucsessGetBlock(accountBerforeWithdraw);
            
            void (^successDepositBlock)(NSDictionary *dict) = spy1.argument;
            successDepositBlock(@{@"account":accountAfterWithdraw, @"accountLog":accountLogAfterWithdraw});
            
            [[realAccountLog should] equal:accountLogAfterWithdraw];
            [[realAccount should] equal:accountAfterWithdraw];
        });
        
    });
    
    context(@"Account transaction", ^{
        it(@"convertDate funtion test", ^{
        });
        
       it(@"Get transaction with Agument newestTrans, startTime, stopTime, accountNumber", ^{
           NSString *accountNumberMock = [NSString nullMock];
           NSDate *timeMock = [NSDate nullMock];
           NSNumber *newestTransMock = [NSNumber nullMock];
           
           NSString *timeStringMock = [NSString nullMock];
           
           __block Account *accountReturn;
           __block NSArray *arrayReturn;
           
           Account *accountShouldReturn = [Account nullMock];
           NSArray *arrayShouldReturn = [NSArray nullMock];
           
           [[sut should] receive:@selector(convertDate:withDateFormat:) andReturn:timeStringMock withCount:2 arguments:timeMock,any()];
           KWCaptureSpy *spy = [mockDAO captureArgument:@selector(getTransFromAccountNumber:start:stop:newestTrans:success:fail:) atIndex:4];
           
           [sut getTransWithNewestTransNumb:newestTransMock accountNumber:accountNumberMock startTime:timeMock stopTime:timeMock success:^(Account *account, NSArray *trans) {
               accountReturn = account;
               arrayReturn = trans;
           } fail:nil];
           
           void (^successGetFromDAOBlock)(NSDictionary *dict) = spy.argument;
           successGetFromDAOBlock(@{@"account":accountShouldReturn, @"transactions":arrayShouldReturn});
           
           [[accountReturn should] equal:accountShouldReturn];
           [[arrayReturn should] equal:arrayShouldReturn];
           
       });
    });
});
SPEC_END
