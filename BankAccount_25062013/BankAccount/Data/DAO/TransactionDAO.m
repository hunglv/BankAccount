//
//  TransactionDAO.m
//  BankAccount
//
//  Created by El Nino on 6/26/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import "TransactionDAO.h"

@implementation TransactionDAO

@synthesize dataAccessHelper;

-(BOOL)insertTransaction:(Transaction *)trans {
    __block BOOL val;
    [dataAccessHelper inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
        [dateformat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        NSString *dateOpended = [dateformat stringFromDate:trans.timeStamp];
        
        NSString *stm = [NSString stringWithFormat:@"insert into tran(accountnumber,amount,timestamp) values('%@', %@, '%@')", trans.accountNumber, trans.amount, dateOpended];
        val = [db executeUpdate:stm];
    }];
    return val;
}

- (Transaction *)transactionParser:(FMResultSet *)r {
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    Transaction *tran = [[Transaction alloc] init];
    tran.accountNumber = [r objectForColumnName:@"accountnumber"];
    tran.amount = [r objectForColumnName:@"amount"];
    tran.description = [r objectForColumnName:@"description"];
    tran.timeStamp = [dateformat dateFromString:[r objectForColumnName:@"timestamp"]];
    return tran;
}

-(NSArray *)transactionOccuredWithAccountNumber:(NSString *)accNum {
    __block NSMutableArray *result;
    [dataAccessHelper inTransaction:^(FMDatabase *db, BOOL *rollback) {        
        NSString *stm = [NSString stringWithFormat:@"select * from tran where accountnumber = '%@'", accNum];
        FMResultSet *r = [db executeQuery:stm];
        result = [[NSMutableArray alloc] init];
        while ([r next]) {
            Transaction *tran;
            tran = [self transactionParser:r];
            [result addObject:tran];
        }

    }];
    return result;
}

-(NSArray *)transactionOccuredWithAccountNumber:(NSString *)accNum startTime:(NSDate *)start endTime:(NSDate *)end {
    __block NSMutableArray *result;
    [dataAccessHelper inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSDateFormatter *datefomater = [[NSDateFormatter alloc] init];
        [datefomater setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        NSString *startTime = [datefomater stringFromDate:start];
        NSString *entime = [datefomater stringFromDate:end];
        NSString *stm = [NSString stringWithFormat:@"select * from tran where accountnumber = '%@' and timestamp > '%@' and timestamp < '%@'", accNum, startTime, entime];
        assert([db validateSQL:stm error:nil]);
        FMResultSet *r = [db executeQuery:stm];
        result = [[NSMutableArray alloc] init];
        while ([r next]) {
            Transaction *tran;
            tran = [self transactionParser:r];
            [result addObject:tran];
        }
        
    }];
    return result;
}

- (NSArray *)transactionOccuredWithAccountNumber:(NSString *)accNum numberTransactions:(NSNumber *)number {
    return nil;
}

@end
