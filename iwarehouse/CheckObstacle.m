//
//  CheckObstacle.m
//  iwarehouse
//
//  Created by Faisal Rahman on 3/17/11.
//  Copyright 2011 BUET. All rights reserved.
//

#import "CheckObstacle.h"

extern enum direction {
    up   = 0,
    down = 1,
    left = 2,
    right= 3,
}shift;

@implementation CheckObstacle
@synthesize man, object,objectArray;

-(CheckObstacle*)initWithMan:(UIImageView*)manK andObjects:(NSMutableArray*)objectArrayK{

	man = manK;
	objectArray = objectArrayK;

	return self;
	
}

-(BOOL)isObstacle:(UIImageView*)objectS{


	BOOL flag = NO;
	
	for (int i=0; i<[objectArray count];i++) 
	{

		object = (UIImageView*)[objectArray objectAtIndex:i];

		switch (shift) {
			case up:
				
				if(object.frame.origin.x==objectS.frame.origin.x && object.frame.origin.y==(objectS.frame.origin.y-objectS.frame.size.height))
				{
					flag =YES;
				}

				break;
				
		case down:
				
				if(object.frame.origin.x==objectS.frame.origin.x && object.frame.origin.y==(objectS.frame.origin.y+objectS.frame.size.height))
				{
					flag =YES;
				}
				
				break;
				
		case left:
				
				if(object.frame.origin.y==objectS.frame.origin.y && object.frame.origin.x==(objectS.frame.origin.x-objectS.frame.size.height))
				{
					flag =YES;
				}
				
				break;
		case right:
				
				if(object.frame.origin.y==objectS.frame.origin.y && object.frame.origin.x==(objectS.frame.origin.x+objectS.frame.size.height))
				{
					flag =YES;
				}
				
				break;				
			default:
				break;
		}
		
		if (flag==YES) {
			return YES;
		}
		

	}

	return NO;
}

-(int)objectAheadOfMan{

	UIImageView * objectS = man;
	BOOL flag=NO;
	for (int i=0; i<[objectArray count];i++) 
	{
		
		object = (UIImageView*)[objectArray objectAtIndex:i];
		
		switch (shift) {
			case up:
				
				if(object.frame.origin.x==objectS.frame.origin.x && object.frame.origin.y==(objectS.frame.origin.y-objectS.frame.size.height))
				{
					flag =YES;
				}
				
				break;
				
			case down:
				
				if(object.frame.origin.x==objectS.frame.origin.x && object.frame.origin.y==(objectS.frame.origin.y+objectS.frame.size.height))
				{
					flag =YES;
				}
				
				break;
				
			case left:
				
				if(object.frame.origin.y==objectS.frame.origin.y && object.frame.origin.x==(objectS.frame.origin.x-objectS.frame.size.height))
				{
					flag =YES;
				}
				
				break;
			case right:
				
				if(object.frame.origin.y==objectS.frame.origin.y && object.frame.origin.x==(objectS.frame.origin.x+objectS.frame.size.height))
				{
					flag =YES;
				}
				
				break;				
			default:
				break;
		}
		
		if (flag==YES) 
		{
			return i;
		}
	}
	
	return NSUIntegerMax;
	
}

@end
