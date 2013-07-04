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
    
    context(@"get all transaction with given account number", ^{
        
        it(@"in database, there's no transaction with given account number", ^{
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tran_sc1" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            NSArray *allTrans = [sut transactionOccuredWithAccountNumber:accNumber];
            [allTrans shouldNotBeNil];
            [[theValue(allTrans.count) should] equal:theValue(0)];
        });
        
        it(@"in database, there're some transactions with given account number, total should equal 9", ^{
            accNumber = @"0123456789";
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tran_sc2" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            NSArray *allTrans = [sut transactionOccuredWithAccountNumber:accNumber];
            [allTrans shouldNotBeNil];
            [[theValue(allTrans.count) should] equal:theValue(9)];
        });
        
        it(@"in database, there're some transactions but there's no transaction with given account number, total should equal 0", ^{
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tran_sc2" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            NSArray *allTrans = [sut transactionOccuredWithAccountNumber:accNumber];
            [allTrans shouldNotBeNil];
            [[theValue(allTrans.count) should] equal:theValue(0)];
        });        
    });
    
    context(@"get all transaction with given account number, start time, end time", ^{
        it(@"in database, there're some transactions with given account number but timeOpened is not into between start time and end time", ^{
            accNumber = @"0123456789";
            NSString *startTime = @"2012-01-01 12:12:13";
            NSString *endTime = @"2012-01-02 12:12:12";
            NSDateFormatter *datefomater = [[NSDateFormatter alloc] init];
            [datefomater setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
            NSDate *startDate = [datefomater dateFromString:startTime];
            NSDate *endDate = [datefomater dateFromString:endTime];
            
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tran_sc2" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            NSArray *allTrans = [sut transactionOccuredWithAccountNumber:accNumber startTime:startDate endTime:endDate];
            [allTrans shouldNotBeNil];
            [[theValue(allTrans.count) should] equal:theValue(0)];
        });
        
        it(@"in database, there're some transactions with given account number but timeOpened is into between start time and end time.", ^{
            accNumber = @"0123456789";
            NSString *startTime = @"2012-01-01 12:12:13";
            NSString *endTime = @"2012-01-02 12:12:12";
            NSDateFormatter *datefomater = [[NSDateFormatter alloc] init];
            [datefomater setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
            NSDate *startDate = [datefomater dateFromString:startTime];
            NSDate *endDate = [datefomater dateFromString:endTime];
            
            NSString *scriptFilePath = [[NSBundle mainBundle] pathForResource:@"tran_sc3" ofType:@"sql"];
            [env loadScriptFile:scriptFilePath];
            
            NSArray *allTrans = [sut transactionOccuredWithAccountNumber:accNumber startTime:startDate endTime:endDate];
            [allTrans shouldNotBeNil];
            [[theValue(allTrans.count) should] equal:theValue(3)];
        });
    });
        
});
SPEC_END
