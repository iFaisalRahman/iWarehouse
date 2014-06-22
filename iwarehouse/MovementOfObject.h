//
//  shift.h
//  warehouse23
//
//  Created by system on 12/13/09.
//  Copyright 2009 rise uP!. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MovementOfObject : NSObject {

	UIImageView* man;
	UIImageView* object;
	int countAnimation;
}

@property(nonatomic,retain)UIImageView* man; 
@property(nonatomic,retain)UIImageView* object; 
 

-(MovementOfObject*)initWithMan:(UIImageView*)manK andObject:(UIImageView*)objectK;
-(void)moveFailedAnimation;
-(void)moveAnimationStart;
-(void)moveAnimationStop;
-(void)doMove;


@end
