//
//  BankAccountDAO.m
//  BankAccount
//
//  Created by El Nino on 6/11/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import "BankAccountDAO.h"

@implementation BankAccountDAO

-(void)insertNewAccount:(Account *)account success:(void (^)(Account *))block fail:(void (^)(NSError *))errBlock {
    
}

-(void)getAccountWithAccountNUmber:(NSString *)accountString success:(void (^)(Account *))block fail:(void (^)(NSError *))eBlock {
    
}

- (void)depositAccount:(Account *)account withAmount:(NSNumber *)amount description:(NSString *)des success:(void (^)(NSDictionary * acc))block fail:(void (^)(NSError *error)) eBlock  {
    
}

- (void)withdrawAccount:(Account *)account withAmount:(NSNumber *)amount description:(NSString *)des success:(void (^)(NSDictionary * dict))block fail:(void (^)(NSError *error)) eBlock {
    
}

-(void)getTransFromAccountNumber:(NSString *)accountNumber start:(NSString *)startTime stop:(NSString *)stopTime newestTrans:(NSNumber *)number success:(void (^)(NSDictionary *))block fail:(void (^)(NSError *))eBlock {
    
}

@end
