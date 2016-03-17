//
//  ViewController.m
//  LeranCoreData
//
//  Created by DavidLee on 16/3/16.
//  Copyright © 2016年 DavidLee. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "Employee.h"
@interface ViewController ()

@property(nonatomic,strong)NSManagedObjectContext *context;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建模型
    //创建一个实体类
    //创建上下文
    //1.创建上下文
    self.context = [[NSManagedObjectContext alloc] initWithConcurrencyType:0];
   //2,创建模型文件
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
     //2.创建调度器
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
                    
    //路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *finalPath = [path stringByAppendingPathComponent:@"employee.sqlite"];
    NSURL *url = [NSURL fileURLWithPath:finalPath];
    NSLog(@"%@",finalPath);

    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:nil];
    self.context.persistentStoreCoordinator = coordinator;
}
- (IBAction)addAction:(UIButton *)sender {
    Employee *employee = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:self.context];
    employee.birthday = [NSDate date];
    employee.name = @"Peter";
    employee.height = @(16);
    NSError *error = nil;
    [self.context save:&error];
    if (!error) {
        NSLog(@"保存成功");
    }
}
- (IBAction)readEmployee:(UIButton *)sender {
    
    //1，创建抓取请求对象
    
    NSFetchRequest *fetchReq = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    //2，设置过滤条件
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name = %@",@"David"];
    fetchReq.predicate = pre;
    //3，排序
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"height" ascending:YES];
    fetchReq.sortDescriptors = @[sort];
    //4，执行
    NSError *error = nil;
   NSArray *array =  [self.context executeFetchRequest:fetchReq error:&error];
    if (!error) {
        NSLog(@"读取成功");
    }
    
    for (Employee *emp in array) {
        NSLog(@"名字%@高度%@",emp.name,emp.height);
    }
    
    NSLog(@"%@",array);
    
}


-(IBAction)updateEmployee:(id)sender
{
    NSFetchRequest *fetchReq = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    //2，设置过滤条件
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name = %@",@"David"];
    fetchReq.predicate = pre;
    
    NSError *error = nil;
    NSArray *array =  [self.context executeFetchRequest:fetchReq error:&error];
    if (!error) {
        NSLog(@"更新成功");
    }
    
    for (Employee *emp in array) {
        emp.height = @(40);
    }
    
    [self.context save:nil];
    
    
}
- (IBAction)deleteEmployee:(UIButton *)sender {
    
    NSFetchRequest *fetchReq = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    
    //2，设置过滤条件
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name = %@",@"David"];
    fetchReq.predicate = pre;
    NSError *error = nil;
    NSArray *array =  [self.context executeFetchRequest:fetchReq error:&error];
    if (!error) {
        NSLog(@"删除成功");
    }
    
    for (Employee *emp in array) {
        [self.context deleteObject:emp];
    }
    
    [self.context save:nil];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
