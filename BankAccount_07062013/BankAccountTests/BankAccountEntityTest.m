//
//  BankAccountEntityTest.m
//  BankAccount
//
//  Created by El Nino on 6/7/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import "Kiwi.h"
#import "BankAccountEntity.h"

SPEC_BEGIN(BankAccountEntityTest)
describe(@"BankAccountEntity test", ^{
    it(@"accountNumber property should be exists", ^{
        BankAccountEntity *entity = [[BankAccountEntity alloc] init];
        [entity.accountNumber shouldNotBeNil];
    });
    
    it(@"balance property shoud be exists", ^{
        BankAccountEntity *entity = [[BankAccountEntity alloc] init];
        [entity.balance shouldNotBeNil];
    });
    
    it(@"openTimestamp property shoud be exists", ^{
        BankAccountEntity *entity = [[BankAccountEntity alloc] init];
        [entity.openTimestamp shouldNotBeNil];
    });
});
SPEC_END
