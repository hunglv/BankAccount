//
//  BankAccountDAO.h
//  BankAccount
//
//  Created by El Nino on 6/10/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "BankAccountEntity.h"

@interface BankAccountDAO : NSObject

- (id)initWithDatabaseAccess:(FMDatabase *)dataAccess;

@property (nonatomic, strong) FMDatabase *dataAccessHelper;
- (NSNumber *)insertEntity:(BankAccountEntity *)entity;
- (BankAccountEntity *)getAccountWithAccountNumber:(NSString *)number;
- (BankAccountEntity *)deposit:(NSString *)accNumb amount:(NSNumber *)number description:(NSString *)description;
@end
