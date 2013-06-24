//
//  DBEnviroment.h
//  LocalStorage
//
//  Created by El Nino on 6/22/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBEnviroment : NSObject

@property (nonatomic, strong) NSString *databasePath;

- (BOOL)loadScriptFile:(NSString *)filePath;
- (NSArray *)classifyQuerry:(NSString *)scriptString ;
@end
