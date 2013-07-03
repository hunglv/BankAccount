//
//  TransactionDAOTest.m
//  BankAccount
//

#import "Kiwi.h"
#import "TransactionDAO.h"
#import <LocalStorage/LocalStorage.h>

SPEC_BEGIN(TransactionDAOSpec)
describe(@"TransactionDAO test", ^{
    __block DBEnviroment *env;
    __block TransactionDAO *sut;
    __block NSString *accNumber;
    
    beforeEach(^{
        env = [[DBEnviroment alloc] init];
        sut = [[TransactionDAO alloc] init];
        sut.dataAccessHelper = env.databaseQueue;
        accNumber = @"1234567890";
    });
    
    afterEach(^{
        env = nil;
        sut = nil;
        accNumber = nil;
    });
    context(@"insert new trans", ^{
        it(@"insert into empty database should success", ^{
            Transaction *tranWillInsert = [[Transaction alloc] init];
            tranWillInsert.accountNumber = accNumber;
            tranWillInsert.amount = @50;
            tranWillInsert.timeStamp = [NSDate date];
            
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tran_sc1" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            BOOL val = [sut insertTransaction:tranWillInsert];
            [[theValue(val) should] equal:theValue(YES)];
        });
    });
        
});
SPEC_END
