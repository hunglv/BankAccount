//
//  AccountDAOTest.m
//  BankAccount
//

#import "Kiwi.h"
#import "AccountDAO.h"
#import <LocalStorage/LocalStorage.h>

SPEC_BEGIN(AccountDAOSpec)
describe(@"AccountDAO test", ^{
    context(@"insert new account", ^{
        it(@"insert into empty database should success", ^{
            Account *accountWillInsert = [[Account alloc] init];
            accountWillInsert.accountNumber = @"1234567890";
            accountWillInsert.balance = @0;
            accountWillInsert.timeOpened = [NSDate date];
            
            DBEnviroment *env = [[DBEnviroment alloc] init];
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tc1" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            AccountDAO *sut = [[AccountDAO alloc] init];
            sut.dataAccessHelper = env.databaseQueue;
            
            BOOL val = [sut insertAccount:accountWillInsert];
            [[theValue(val) should] equal:theValue(YES)];
        });
        
        it(@"insert into which's accountnumber is exists", ^{
            Account *accountWillInsert = [[Account alloc] init];
            accountWillInsert.accountNumber = @"1234567890";
            accountWillInsert.balance = @0;
            accountWillInsert.timeOpened = [NSDate date];
            
            DBEnviroment *env = [[DBEnviroment alloc] init];
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tc2" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            AccountDAO *sut = [[AccountDAO alloc] init];
            sut.dataAccessHelper = env.databaseQueue;
            
            BOOL val = [sut insertAccount:accountWillInsert];
            [[theValue(val) should] equal:theValue(NO)];
        });
    });
});
SPEC_END
