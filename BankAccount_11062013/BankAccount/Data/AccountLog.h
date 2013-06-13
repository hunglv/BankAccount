//
//  AccountLog.h
//  BankAccount
//
//  Created by El Nino on 6/12/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountLog : NSObject

@property (nonatomic, strong) NSString *accountNumber;
@property (nonatomic, strong) NSDate *timeStamp;
@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, strong) NSString *description;

@end
