//
//  Employee+CoreDataProperties.h
//  DLCoreData
//
//  Created by DavidLee on 16/3/18.
//  Copyright © 2016年 DavidLee. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Employee.h"

NS_ASSUME_NONNULL_BEGIN

@interface Employee (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *birthday;
@property (nullable, nonatomic, retain) NSNumber *height;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) Department *departNumber;

@end

NS_ASSUME_NONNULL_END
