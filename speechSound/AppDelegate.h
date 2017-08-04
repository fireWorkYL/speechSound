//
//  AppDelegate.h
//  speechSound
//
//  Created by 楚简约 on 2017/8/2.
//  Copyright © 2017年 mlgentleman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

