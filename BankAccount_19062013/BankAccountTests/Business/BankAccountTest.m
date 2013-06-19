//
//  BankAccountTest.m
//  BankAccount
//

#import "Kiwi.h"
#import "BankAccount.h"
#import "Account.h"
#import "AccountDAO.h"

SPEC_BEGIN(BankAccountSpec)
describe(@"BankAccount test", ^{
    
    __block AccountDAO *mockDAO;
    __block BankAccount *sut;
    __block NSString *accountNumber;
    
    beforeEach(^{
        accountNumber = [NSString nullMock];
        sut = [[BankAccount alloc] init];
        mockDAO = [AccountDAO mock];
        sut.accountDAO = mockDAO;
    });
    afterEach(^{
        accountNumber = nil;
        sut = nil;
        mockDAO = nil;
    });
    
    context(@"Open new Account", ^{
       it(@"Open new Account with Account number, if success should have balance is zero", ^{
           
           [mockDAO stub:@selector(insertNewAccount:) andReturn:theValue(YES) withArguments:any()];
           
           Account *accountOpened = [sut open:accountNumber];
           
           [[accountOpened.accountNumber should] equal:accountNumber];
           [[accountOpened.balance should] equal:@0];
           
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
       it(@"Deposit account with amountnumber", ^{
           Account *accountBeforDeposit = [Account nullMock];
           NSNumber *amount = @(123.45);
           
           [mockDAO stub:@selector(updateAccount:) andReturn:theValue(YES) withArguments:accountBeforDeposit];
           
           Account *accountReturn = [sut deposit]
       });
    });
        
});
SPEC_END
