//
//  BankAccountTest.m
//  BankAccount
//

#import "Kiwi.h"
#import "BankAccount.h"

SPEC_BEGIN(BankAccountSpec)
describe(@"BankAccount test", ^{
    
    __block AccountDAO *mockAccountDAO;
    __block BankAccount *sut;
    __block NSString *accountNumber;
    __block TransactionDAO *mockTransactionDAO;
    
    beforeEach(^{
        mockAccountDAO = [AccountDAO nullMock];
        mockTransactionDAO = [TransactionDAO nullMock];
        sut = [[BankAccount alloc] init];
        sut.accountDAO = mockAccountDAO;
        sut.transactionDAO = mockTransactionDAO;
        accountNumber = [NSString nullMock];
    });
    
    afterEach(^{
        mockAccountDAO = nil;
        sut = nil;
        accountNumber = nil;
        mockTransactionDAO = nil;
    });
    context(@"Open account", ^{       
        it(@"open new account (success) should get account with balance is zero, accountNumber is accountNumber, timeOpen is current date ", ^{
            NSDate *dateMock = [NSDate mock];
            [NSDate stub:@selector(date) andReturn:dateMock];
            
            [mockAccountDAO stub:@selector(insertAccount:) andReturn:theValue(YES)];
            
            KWCaptureSpy *capSpy = [mockAccountDAO captureArgument:@selector(insertAccount:) atIndex:0];
            
            Account *accountOpened = [sut open:accountNumber];
            
            Account *accountShouldInsert = capSpy.argument;
            
            [[accountOpened should] equal:accountShouldInsert];
            [[accountOpened.accountNumber should] equal:accountNumber];
            [[accountOpened.balance should] equal:@0];
            [[accountOpened.timeOpened should] equal:dateMock];
            
        });
    });
    
    context(@"Get account", ^{
        it(@"get account with given account number (success)", ^{
            Account *accountMock = [Account nullMock];
            
            [mockAccountDAO stub:@selector(getAccountWithAccountNumber:) andReturn:accountMock];
            
            KWCaptureSpy *spy = [mockAccountDAO captureArgument:@selector(getAccountWithAccountNumber:) atIndex:0];
            
            [sut getAccount:accountNumber];
            
            NSString *accountNumberArg = spy.argument;
            [[accountNumberArg should] equal:accountNumber];
        });
    });
    
    context(@"Deposit account", ^{
        it(@"deposit account with given accountNumber, amount, desctiption. account balance will increase amount", ^{
            Account *accountBeforDeposit = [[Account alloc] init];
            accountBeforDeposit.balance = @100;
            
            NSNumber *balanceBeforDeposit = accountBeforDeposit.balance;
            
            NSNumber *amount = @(50.25);
            
            [sut stub:@selector(getAccount:) andReturn:accountBeforDeposit];
            [[sut should] receive:@selector(getAccount:) andReturn:accountBeforDeposit withArguments:accountNumber];
            
            KWCaptureSpy *spy = [mockAccountDAO captureArgument:@selector(updateAccount:) atIndex:0];
            
            [sut depositAccountNumber:accountNumber amount:amount description:[NSString nullMock]];
            
            Account *accountUpdate = spy.argument;
            [[theValue(accountUpdate.balance.doubleValue - amount.doubleValue) should] equal:theValue(balanceBeforDeposit.doubleValue)];
        });
        
        it(@"deposit should save a transaction", ^{
            Account *accountDeposit = [Account nullMock];
            NSDate *mockCurrentDate = [NSDate nullMock];
            [NSDate stub:@selector(date) andReturn:mockCurrentDate];
            NSString *mockDescription = [NSString nullMock];
            NSNumber *mockAmount = [NSNumber nullMock];
            
            [sut stub:@selector(getAccount:) andReturn:accountDeposit];
            
            [mockAccountDAO stub:@selector(updateAccount:) andReturn:theValue(YES)];
            
            KWCaptureSpy *spy = [mockTransactionDAO captureArgument:@selector(insertTransaction:) atIndex:0];
            
            [sut depositAccountNumber:accountNumber amount:mockAmount description:mockDescription];
            
            Transaction *tranShouldInsert = spy.argument;
            
            [[tranShouldInsert.amount should] equal:mockAmount];
            [[tranShouldInsert.timeStamp should] equal:mockCurrentDate];
            [[tranShouldInsert.description should] equal:mockDescription];
            [[tranShouldInsert.accountNumber should] equal:accountNumber];
        });
    });
    
    context(@"Withdraw account", ^{
        it(@"withdraw account with given accountNumber, amount, desctiption. account balance will decrease amount", ^{
            Account *accountBeforWithdraw = [[Account alloc] init];
            accountBeforWithdraw.balance = @100;
            
            NSNumber *balanceBeforDeposit = accountBeforWithdraw.balance;
            
            NSNumber *amount = @(50.25);
            
            [sut stub:@selector(getAccount:) andReturn:accountBeforWithdraw];
            [[sut should] receive:@selector(getAccount:) andReturn:accountBeforWithdraw withArguments:accountNumber];
            
            KWCaptureSpy *spy = [mockAccountDAO captureArgument:@selector(updateAccount:) atIndex:0];
            
            [sut withdrawAccountNumber:accountNumber amount:amount description:[NSString nullMock]];
            
            Account *accountUpdate = spy.argument;
            [[theValue(accountUpdate.balance.doubleValue + amount.doubleValue) should] equal:theValue(balanceBeforDeposit.doubleValue)];
        });
        
        it(@"withdraw should save a transaction", ^{
            Account *accountDeposit = [Account nullMock];
            NSDate *mockCurrentDate = [NSDate nullMock];
            [NSDate stub:@selector(date) andReturn:mockCurrentDate];
            NSString *mockDescription = [NSString nullMock];
            NSNumber *mockAmount = @50;
            
//            [sut stub:@selector(getAccount:) andReturn:accountDeposit];
            [[sut should] receive:@selector(getAccount:) andReturn:accountDeposit];
            [mockAccountDAO stub:@selector(updateAccount:) andReturn:theValue(YES)];
            
            KWCaptureSpy *spy = [mockTransactionDAO captureArgument:@selector(insertTransaction:) atIndex:0];
            
            [sut withdrawAccountNumber:accountNumber amount:mockAmount description:mockDescription];
            
            Transaction *tranShouldInsert = spy.argument;
            
            [[theValue(tranShouldInsert.amount.doubleValue) should] equal:theValue(mockAmount.doubleValue * (-1))];
            [[tranShouldInsert.timeStamp should] equal:mockCurrentDate];
            [[tranShouldInsert.description should] equal:mockDescription];
            [[tranShouldInsert.accountNumber should] equal:accountNumber];
        });
    });
    
    context(@"Get transaction", ^{
        it(@"get transaction occured on account with given accountNumber ", ^{
            KWCaptureSpy *spy = [mockTransactionDAO captureArgument:@selector(transactionOccuredWithAccountNumber:) atIndex:0];
            [sut transactionOccuredWithAccountNumber:accountNumber];
            NSString *accountCapture = spy.argument;
            [[accountCapture should] equal:accountNumber];
        });
        
        it(@"get transaction occured on account with given accountNumber, start time, end time", ^{
            NSDate *mockStartTime = [NSDate mock];
            NSDate *mockEndTime = [NSDate mock];
            [[mockTransactionDAO should] receive:@selector(transactionOccuredWithAccountNumber:startTime:endTime:) andReturn:any() withArguments:accountNumber, mockStartTime, mockEndTime];
            [sut transactionOccuredWithAccountNumber:accountNumber startTime:mockStartTime endTime:mockEndTime];
        });
        
        it(@"get transaction occured on account with given accountNumber, number transactions", ^{
            NSNumber *mockNumber = [NSNumber mock];
            [[mockTransactionDAO should] receive:@selector(transactionOccuredWithAccountNumber:numberTransactions:) andReturn:any() withArguments:accountNumber, mockNumber];
            [sut transactionOccuredWithAccountNumber:accountNumber numberTransactions:mockNumber];
        });
    });
        
});
SPEC_END
