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
           [[accountOpened.timeStamp should] equal:mockDate];
           
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
    
});
SPEC_END
