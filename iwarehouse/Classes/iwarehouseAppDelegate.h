//
//  iwarehouseAppDelegate.h
//  iwarehouse
//
//  Created by Faisal Rahman on 3/17/11.
//  Copyright 2011 BUET. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iwarehouseViewController;

@interface iwarehouseAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    iwarehouseViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet iwarehouseViewController *viewController;

@end

