//
//  BankAccountBusinessService.h
//  BankAccount
//
//  Created by El Nino on 6/10/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BankAccountEntity.h"
#import "BankAccountDAO.h"

@interface BankAccountBusinessService : NSObject

- (BankAccountEntity *)open:(NSString *)accountNumber;

- (NSNumber *)openNewAccount:(NSString *)accountNumer;

- (BankAccountEntity *)getAccountWithNumber:(NSString *)number;
- (BankAccountEntity *)desposit:(NSString *)acc amount:(NSNumber *)number description:(NSString *)des;

- (id)initWithDAO:(BankAccountDAO *)dao;

@property (nonatomic, strong) BankAccountDAO *bankAccountDAO;



@end
