//
//  BankAccountDAO.h
//  BankAccount
//
//  Created by El Nino on 6/7/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "BankAccountEntity.h"

@interface BankAccountDAO : NSObject

-(id)initWithDataAccessHelper:(FMDatabase *)helper;

@property (nonatomic, strong) FMDatabase *dataAccessHelper;

- (BankAccountEntity *)getAccount:(NSString *)accountNumber;

@end
