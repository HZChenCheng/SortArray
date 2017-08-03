//
//  ViewController.m
//  数组的排序
//
//  Created by 陈诚 on 2017/8/3.
//  Copyright © 2017年 iOS_Developer. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   
    // 1.使用NSComparator排序
    {
        // 产生随机数
        NSMutableArray *unsortDataM = [NSMutableArray array];
        for (NSInteger index = 0; index < 20; index++) {
            int random = arc4random()%20;
            [unsortDataM addObject:@(random)];
        }
        NSLog(@"使用NSComparator排序前的数据:%@",unsortDataM);
        
        NSArray *sortedData = [unsortDataM sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            NSInteger value1 = (NSInteger)obj1;
            NSInteger value2 = (NSInteger)obj2;
            
            if (value1 < value2) {
                return NSOrderedAscending;
            }else {
                return NSOrderedDescending;
            }
        }];
        
        NSLog(@"使用NSComparator排序后的数据:%@",sortedData);

    }
    
    // 2.使用NSDescriptor排序
    {
        Person *person1 = [[Person alloc] init];
        person1.age = 39;
        person1.height = 178;
        
        Person *person2 = [[Person alloc] init];
        person2.age = 25;
        person2.height = 165;
        
        Person *person3 = [[Person alloc] init];
        person3.age = 55;
        person3.height = 170;
        
        Person *person4 = [[Person alloc] init];
        person4.age = 15;
        person4.height = 165;
        
        Person *person5 = [[Person alloc] init];
        person5.age = 38;
        person5.height = 177;
        
        NSMutableArray *unsortDataM = [NSMutableArray arrayWithObjects:person1,person2,person3,person4,person5, nil];
        NSLog(@"使用NSDescriptor排序前的数据:%@",unsortDataM);
        
        NSSortDescriptor *firstDescriptor  = [[NSSortDescriptor alloc] initWithKey:@"age" ascending:YES];
        NSSortDescriptor *secondDescriptor = [[NSSortDescriptor alloc] initWithKey:@"height" ascending:YES];
        
        // 第一优先级先按照年龄排，年龄相同的按照第二优先级排序
        NSArray *sortArray = [NSArray arrayWithObjects:firstDescriptor,secondDescriptor,nil];
        NSArray  *sortedData = [unsortDataM sortedArrayUsingDescriptors:sortArray];
        NSLog(@"使用NSDescriptor排序后的数据");
        for (Person *person in sortedData) {
            NSLog(@"age:%d,height:%d",person.age,person.height);
        }
    }
    
    // 3.使用函数排序
    {
    
        // 产生随机数
        NSMutableArray *unsortDataM = [NSMutableArray array];
        for (NSInteger index = 0; index < 20; index++) {
            int random = arc4random()%20;
            [unsortDataM addObject:@(random)];
        }
        NSLog(@"使用函数排序前的数据:%@",unsortDataM);
        NSArray  *sortedData = [unsortDataM sortedArrayUsingFunction:customSort context:nil];
        NSLog(@"使用函数排序后的数据:%@",sortedData);
    }
}

#pragma mark - 排序函数

NSInteger customSort(id obj1, id obj2,void* context) {
    int value1 = (int)obj1;
    int value2 = (int)obj2;
    
    if (value1 < value2) {
        return (NSComparisonResult)NSOrderedAscending;
    }
    
    if (value1 > value2) {
        return (NSComparisonResult)NSOrderedDescending;
    }
    
    return (NSComparisonResult)NSOrderedSame;
}

@end
