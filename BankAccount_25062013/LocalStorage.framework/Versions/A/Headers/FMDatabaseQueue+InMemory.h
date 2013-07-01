//
//  FMDatabaseQueue+InMemory.h
//  DatabaseInMem
//
//  Created by El Nino on 7/1/13.
//  Copyright (c) 2013 El Nino. All rights reserved.
//

#import "FMDatabaseQueue.h"

@interface FMDatabaseQueue (InMemory)

- (id)initInMemoryWithPath:(NSString *)path;
- (BOOL)saveToDisk;

@end
