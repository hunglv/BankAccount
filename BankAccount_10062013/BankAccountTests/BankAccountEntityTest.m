//
//  BankAccountEntityTest.m
//  BankAccount
//
//  Created by El Nino on 6/10/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import "Kiwi.h"
#import "BankAccountEntity.h"

SPEC_BEGIN(BankAccountEntityTest)
describe(@"BankAccountEntity test", ^{
    
    context(@"Test property", ^{
        it(@"accountNumber property is kind of class NSString", ^{
            BankAccountEntity *en = [[BankAccountEntity alloc] init];
            [[theValue([en.accountNumber isKindOfClass:[NSString class]]) should] equal:theValue(YES)];
        });
        
        it(@"balance property is kind of class NSNumber", ^{
            BankAccountEntity *en = [[BankAccountEntity alloc] init];
            [[theValue([en.balance isKindOfClass:[NSNumber class]]) should] equal:theValue(YES)];
        });
        
        it(@"openTimestamp is kind of class NSDate", ^{
            BankAccountEntity *en = [[BankAccountEntity alloc] init];
            [[theValue([en.openTimestamp isKindOfClass:[NSDate class]]) should] equal:theValue(YES)];
        });
    });
});
SPEC_END
