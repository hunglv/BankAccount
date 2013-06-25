//
//  BankAccountTest.m
//  BankAccount
//

#import "Kiwi.h"
#import "BankAccount.h"
#import "Account.h"
#import "AccountDAO.h"
#import "AccountLog.h"
#import "AccountLogDAO.h"

SPEC_BEGIN(BankAccountSpec)
describe(@"BankAccount test", ^{
    
    __block AccountDAO *mockDAO;
    __block BankAccount *sut;
    __block NSString *accountNumber;
    __block AccountLogDAO *accountLogDAO;
    
    beforeEach(^{
        accountNumber = [NSString nullMock];
        sut = [[BankAccount alloc] init];
        mockDAO = [AccountDAO nullMock];
        accountLogDAO = [AccountLogDAO nullMock];
        sut.accountDAO = mockDAO;
        sut.accountLogDAO = accountLogDAO;
    });
    afterEach(^{
        accountNumber = nil;
        sut = nil;
        mockDAO = nil;
    });
    
    context(@"Open new Account", ^{
       it(@"Open new Account with Account number, if success should have balance is zero, should have timestamp", ^{
           
           [mockDAO stub:@selector(insertNewAccount:) andReturn:theValue(YES) withArguments:any()];
           
           NSDate *mockDate = [NSDate mock];
           [NSDate stub:@selector(date) andReturn:mockDate];
           
           Account *accountOpened = [sut open:accountNumber];
           
           [[accountOpened.accountNumber should] equal:accountNumber];
           [[accountOpened.balance should] equal:@0];
           [accountOpened.timeStamp shouldBeNil];
           
       });
    });
    
    context(@"Get Account", ^{
       it(@"Get account with account number, if success account's accountnumber should equal account number given", ^{
           Account *accountShouldReturn = [Account nullMock];
           [accountShouldReturn stub:@selector(accountNumber) andReturn:accountNumber];
           
           [mockDAO stub:@selector(getAccountWithAccountNumber:) andReturn:accountShouldReturn withArguments:accountNumber];
           
           Account *accountReturn = [sut getAccount:accountNumber];
           
           [[accountReturn.accountNumber should] equal:accountNumber];
           
       });
    });
    
    context(@"Deposit account", ^{
       it(@"Deposit account with amountnumber, after deposit account balance will increase amountnumber", ^{
           Account *accountBeforDeposit = [Account nullMock];
           [accountBeforDeposit stub:@selector(balance) andReturn:@0];
           NSNumber *amount = @(123.45);
           NSString *description = [NSString nullMock];
           
           Account *accountReturn;

           [sut stub:@selector(getAccount:) andReturn:accountBeforDeposit withArguments:accountNumber];
           // Check selector getAccount should be call
           [[sut should] receive:@selector(getAccount:) andReturn:accountBeforDeposit withArguments:accountNumber];
           
           [mockDAO stub:@selector(updateAccount:) andReturn:theValue(YES) withArguments:accountReturn];
           // Check mockDAO should call selector updateAccount
           [[mockDAO should] receive:@selector(updateAccount:) andReturn:theValue(YES) withArguments:any()];
           
           accountReturn = [sut depositAccountNumber:accountNumber amount:amount description:description];
           
           [[accountReturn.balance should] equal:@(accountBeforDeposit.balance.doubleValue + amount.doubleValue)];
           
       });
        
        it(@"create new AccountLog object with accountNumber, amount, description. timestamp will be equal time when create", ^{
            NSNumber *amount = [NSNumber nullMock];
            NSString *description = [NSString nullMock];
            NSDate *mockDate = [NSDate mock];
            [NSDate stub:@selector(date) andReturn:mockDate];
            
            AccountLog *accoutLog = [sut createAccountLogWithAccountNumber:accountNumber amount:amount description:description];
            
            [[accoutLog.accountNumber should] equal:accountNumber];
            [[accoutLog.amount should] equal:amount];
            [[accoutLog.timeStamp should] equal:mockDate];
            [[accoutLog.description should] equal:description];
        });
        
        it(@"Deposit account should call selector insertAccountLog in accountLogDAO object", ^{
            [mockDAO stub:@selector(updateAccount:) andReturn:theValue(YES)];
            [[accountLogDAO should] receive:@selector(insertAccountLog:)];
            [[sut should] receive:@selector(createAccountLogWithAccountNumber:amount:description:)];
            [sut depositAccountNumber:[NSString nullMock] amount:[NSNumber nullMock] description:[NSString nullMock]];
        });
    });
    
    context(@"Withdraw account", ^{
        it(@"Withdraw account with amountnumber, after withdraw account balance will decrease amountnumber", ^{
            Account *accountBeforWithdraw = [Account nullMock];
            [accountBeforWithdraw stub:@selector(balance) andReturn:@123];
            NSNumber *amount = @(100);
            NSString *description = [NSString nullMock];
            
            Account *accountReturn;
            
            [sut stub:@selector(getAccount:) andReturn:accountBeforWithdraw withArguments:accountNumber];
            // Check selector getAccount should be call
            [[sut should] receive:@selector(getAccount:) andReturn:accountBeforWithdraw withArguments:accountNumber];
            
            [mockDAO stub:@selector(updateAccount:) andReturn:theValue(YES) withArguments:accountReturn];
            // Check mockDAO should call selector updateAccount
            [[mockDAO should] receive:@selector(updateAccount:) andReturn:theValue(YES) withArguments:any()];
            
            accountReturn = [sut withdrawAccountNumber:accountNumber amount:amount description:description];
            
            [[accountReturn.balance should] equal:@(accountBeforWithdraw.balance.doubleValue - amount.doubleValue)];
            
        });
        
        it(@"Withdraw account should call selector insertAccountLog in accountLogDAO object, amount in accountlog should be neagtive", ^{
            NSNumber *amount = @10;
            
            [mockDAO stub:@selector(updateAccount:) andReturn:theValue(YES)];
            [[accountLogDAO should] receive:@selector(insertAccountLog:)];
            [[sut should] receive:@selector(createAccountLogWithAccountNumber:amount:description:) withArguments:any(),@(-10), any()];
            [sut withdrawAccountNumber:[NSString nullMock] amount:amount description:[NSString nullMock]];
        });
    });
    
    context(@"Get trans with accountNumber", ^{
        it(@"get trans should call selector getTransactionWithAccountNumber in accountLogDAO object", ^{
            [[accountLogDAO should] receive:@selector(getTransactionWithAccountNumber:) andReturn:any() withArguments:accountNumber];
            [sut getTransactionOccuredWithAccountNumber:accountNumber];
        });
        
        it(@"get transaction occured with start time, stop time should call selecter getTransactionWithAccountNumber:start:stop: in accountLog object ", ^{
            NSDate *start = [NSDate nullMock];
            NSDate *stop = [NSDate nullMock];
            [[accountLogDAO should] receive:@selector(getTransactionWithAccountNumber:start:stop:) andReturn:any() withArguments:accountNumber, start, stop];
            [sut getTransactionOccuredWithAccountNumber:accountNumber start:start stop:stop];
        });
        
        it(@"get transaction occured newest should call selector getTransactionWithAccountNumber:numberNewest:", ^{
            NSNumber *numberNewest = [NSNumber nullMock];
            [[accountLogDAO should] receive:@selector(getTransactionWithAccountNumber:numberNewest:) andReturn:any() withArguments:accountNumber,numberNewest];
            [sut getTransactionOccuredWithAccountNumber:accountNumber numberNewest:numberNewest];
        });
    });
    
});
SPEC_END
