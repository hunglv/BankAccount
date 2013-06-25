//
//  AccountDAO.m
//  BankAccount
//
//  Created by El Nino on 6/19/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import "AccountDAO.h"

#import <LocalStorage/LocalStorage.h>

@interface AccountDAO()

@property (nonatomic, strong) FMDatabaseQueue *dataAccessHelper;

@end

@implementation AccountDAO

@synthesize databasePath;
@synthesize dataAccessHelper = _dataAccessHelper;
@synthesize error;

-(BOOL)insertNewAccount:(Account *)accountInsert {
    NSDateFormatter *fomater = [[NSDateFormatter alloc] init];
    [fomater setDateFormat:@"MM/DD/YYYY"];
    NSString *dateString = [fomater stringFromDate:accountInsert.timeStamp];
    __block NSString *stm = [NSString stringWithFormat:@"insert into account(accountNumber, balance, timestamp) values('%@',%@,'%@')", accountInsert.accountNumber, accountInsert.balance, dateString];
    __block BOOL resultInsert = NO;
    [_dataAccessHelper inTransaction:^(FMDatabase *db, BOOL *rollback) {
        resultInsert = [db executeUpdate:stm];
    }];
    return resultInsert;
}

-(Account *)getAccountWithAccountNumber:(NSString *)accountNumber {
    return nil;
}

-(BOOL)updateAccount:(Account *)accountUpdate {
    return NO;
}

-(void)setDatabasePath:(NSString *)_databasePath {
    databasePath = _databasePath;
    _dataAccessHelper = [FMDatabaseQueue databaseQueueWithPath:databasePath];
}

@end
