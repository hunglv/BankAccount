//
//  BankAccountDAO.h
//  BankAccount
//
//  Created by El Nino on 6/10/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface BankAccountDAO : NSObject

- (id)initWithDatabaseAccess:(FMDatabase *)dataAccess;

@property (nonatomic, strong) FMDatabase *dataAccessHelper;

@end
