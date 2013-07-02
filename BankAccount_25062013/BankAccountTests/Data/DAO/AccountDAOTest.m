//
//  AccountDAOTest.m
//  BankAccount
//

#import "Kiwi.h"
#import "AccountDAO.h"
#import <LocalStorage/LocalStorage.h>

SPEC_BEGIN(AccountDAOSpec)
describe(@"AccountDAO test", ^{
    __block DBEnviroment *env;
    __block AccountDAO *sut;
    __block NSString *accNumber;
    
    beforeEach(^{
        env = [[DBEnviroment alloc] init];
        sut = [[AccountDAO alloc] init];
        sut.dataAccessHelper = env.databaseQueue;
        accNumber = @"1234567890";
    });
    
    afterEach(^{
        env = nil;
        sut = nil;
        accNumber = nil;
    });
    context(@"insert new account", ^{
        it(@"insert into empty database should success", ^{
            Account *accountWillInsert = [[Account alloc] init];
            accountWillInsert.accountNumber = accNumber;
            accountWillInsert.balance = @0;
            accountWillInsert.timeOpened = [NSDate date];
            
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tc1" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            BOOL val = [sut insertAccount:accountWillInsert];
            [[theValue(val) should] equal:theValue(YES)];
        });
        
        it(@"insert into which's accountnumber is exists", ^{
            Account *accountWillInsert = [[Account alloc] init];
            accountWillInsert.accountNumber = accNumber;
            accountWillInsert.balance = @0;
            accountWillInsert.timeOpened = [NSDate date];
            
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tc2" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            BOOL val = [sut insertAccount:accountWillInsert];
            [[theValue(val) should] equal:theValue(NO)];
        });
    });
    
    context(@"Get account", ^{
        it(@"get account, there's no account in database.", ^{
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tc1" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            Account *accountGet = [sut getAccountWithAccountNumber:accNumber];
            [accountGet shouldBeNil];
            [sut.error shouldNotBeNil];
        });
        
        it(@"get account, there's no account with given account number in database", ^{
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tc3" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            Account *accountGet = [sut getAccountWithAccountNumber:accNumber];
            [accountGet shouldBeNil];
            [sut.error shouldNotBeNil];
        });
        
        it(@"get account, there's account with given account number in database", ^{
            
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tc2" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            Account *accountGet = [sut getAccountWithAccountNumber:accNumber];
            [accountGet shouldNotBeNil];
            [[accountGet.accountNumber should] equal:accNumber];
            [sut.error shouldBeNil];
        });
    });
    
    context(@"Update account", ^{
        it(@"update account if there's account in database should be successful", ^{
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tc2" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            Account *accountBeforeUpdate = [sut getAccountWithAccountNumber:accNumber];
            accountBeforeUpdate.balance = @(accountBeforeUpdate.balance.doubleValue + 50);
            
            BOOL val = [sut updateAccount:accountBeforeUpdate];
            [[theValue(val) should] equal:theValue(YES)];
            
        });
    });
});
SPEC_END
