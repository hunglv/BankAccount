//
//  BankAccountDAOTest.m
//  BankAccount
//
//  Created by El Nino on 6/10/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import "Kiwi.h"
#import "BankAccountDAO.h"
#import "FMDatabase.h"

SPEC_BEGIN(BankAccountDAOTest)
describe(@"BankAccountDAO test", ^{
    context(@"New instance BankAccountDAO", ^{
        it(@"dataAccessHelper property should be exists", ^{
            FMDatabase *dataAccess = [FMDatabase mock];
            BankAccountDAO *dao = [[BankAccountDAO alloc] initWithDatabaseAccess:dataAccess];
            [[dao.dataAccessHelper should] equal:dataAccess];
        });
    });
   
});
SPEC_END
