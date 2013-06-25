//
//  AccountDAOTest.m
//  BankAccount
//

#import "Kiwi.h"
#import "AccountDAO.h"
#import <LocalStorage/LocalStorage.h>
#import "BankAccount.h"

SPEC_BEGIN(AccountDAOSpec)
describe(@"AccountDAO test", ^{
    __block DBEnviroment *enviromentTest;
    __block AccountDAO *sut;
    
    
    context(@"Insert new account", ^{
        beforeEach(^{
            enviromentTest = [[DBEnviroment alloc] init];
            sut = [[AccountDAO alloc] init];
            sut.databasePath = enviromentTest.databasePath;
        });
        
        afterEach(^{
            enviromentTest = nil;
            sut = nil;
        });
        it(@"Insert new Account to empty database should be successful", ^{            
            if([enviromentTest loadScriptFile:[[NSBundle mainBundle] pathForResource:@"setLayout" ofType:@"sql"]]) {
                Account *accountWillInsert = [[Account alloc] init];
                accountWillInsert.accountNumber = @"1234567890";
                accountWillInsert.balance = @12.25;
                accountWillInsert.timeStamp = [NSDate date];
                
                BOOL returnValue = [sut insertNewAccount:accountWillInsert];
                [[theValue(returnValue) should] equal:theValue(YES)];
            };           
        });
        
        it(@"Insert new Account which's accountnumber is exists", ^{
            if([enviromentTest loadScriptFile:[[NSBundle mainBundle] pathForResource:@"setLayout" ofType:@"sql"]]) {
                Account *accountWillInsert = [[Account alloc] init];
                accountWillInsert.accountNumber = @"1234567890";
                accountWillInsert.balance = @12.25;
                accountWillInsert.timeStamp = [NSDate date];
                
                BOOL returnValue = [sut insertNewAccount:accountWillInsert];
                [[theValue(returnValue) should] equal:theValue(NO)];
                [[[sut.error domain] should] equal:@"PrimaryKeyUniqueError"];
            };
        });
    });
        
});
SPEC_END
