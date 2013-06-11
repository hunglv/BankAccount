//
//  BankAccount.h
//  BankAccount
//
//  Created by El Nino on 6/11/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BankAccountDAO.h"


@interface BankAccount : NSObject

-(id)initWithDAO:(BankAccountDAO *)_dao;

@property (nonatomic, strong) BankAccountDAO *dao;

- (Account *)createAccountWithNumber:(NSString *)accountNumberString;

- (void)openNewAccountWithNumber:(NSString *)accountString success:(void (^)(Account * acc))block fail:(void (^)(NSError *error)) eBlock ;

- (void)getAccountWithAccountNUmber:(NSString *)accountString success:(void (^)(Account * acc))block fail:(void (^)(NSError *error)) eBlock ;

- (void)depositWithAccountNUmber:(NSString *)accountString amount:(NSNumber *)amount description:(NSString *)descrip success:(void (^)(Account * acc))block fail:(void (^)(NSError *error)) eBlock ;

@end
