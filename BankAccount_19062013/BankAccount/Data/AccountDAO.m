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

-(BOOL)insertNewAccount:(Account *)accountInsert {
    return NO;
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
