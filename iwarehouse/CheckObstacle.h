//
//  CheckObstacle.h
//  iwarehouse
//
//  Created by Faisal Rahman on 3/17/11.
//  Copyright 2011 BUET. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CheckObstacle : NSObject {

	UIImageView *man;
	UIImageView *object;
	NSMutableArray *objectArray;
}

@property(nonatomic,retain) UIImageView* man; 
@property(nonatomic,retain) UIImageView* object;
@property(nonatomic,retain) NSMutableArray *objectArray;


-(CheckObstacle*)initWithMan:(UIImageView*)manK andObjects:(NSMutableArray*)objectArrayK;
-(BOOL)isObstacle:(UIImageView*)objectk;
-(int)objectAheadOfMan;

@end
