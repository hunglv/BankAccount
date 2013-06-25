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
    
    beforeEach(^{
        mockAccountDAO = [AccountDAO mock];
        sut = [[BankAccount alloc] init];
        sut.accountDAO = mockAccountDAO;
        accountNumber = [NSString nullMock];
    });
    
    afterEach(^{
        mockAccountDAO = nil;
        sut = nil;
        accountNumber = nil;
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
        
});
SPEC_END
