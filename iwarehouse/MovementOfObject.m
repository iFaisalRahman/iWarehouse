//
//  shift.m
//  warehouse23
//
//  Created by system on 12/13/09.
//  Copyright 2009 rise uP!. All rights reserved.
//

#import "MovementOfObject.h"

#define animatiReapeatCount_ 4;
#define animationTimeWalk 0.5
#define animationTime 0.5



enum direction {
    up   = 0,
    down = 1,
    left = 2,
    right= 3,
}shift;

BOOL isWalkingEnd;

@implementation MovementOfObject
@synthesize man, object;
/////////

-(void)moveFailedAnimation{
	
	NSMutableArray *playerImages;
	UIImage *image1, *image2;
	
	switch (shift) {
		case up:
				
			image1=[UIImage imageNamed:@"objectUp.png"];
			image2=[UIImage imageNamed:@"objectUp1.png"];
			
			break;
		case down:
			image1=[UIImage imageNamed:@"objectDown.png"];
			image2=[UIImage imageNamed:@"objectDown1.png"];
			break;
		case right:
			image1=[UIImage imageNamed:@"objectRight.png"];
			image2=[UIImage imageNamed:@"objectRight1.png"];
			break;
		case left:
			image1=[UIImage imageNamed:@"objectLeft.png"];
			image2=[UIImage imageNamed:@"objectLeft1.png"];
			break;
			break;
			
		default:
			break;
	}
	
	playerImages = [[NSMutableArray alloc]init];
	[playerImages addObject:image1];
	[playerImages addObject:image2];
	
	man.animationImages=playerImages;
	man.animationDuration = animationTimeWalk;
	man.animationRepeatCount = animatiReapeatCount_;
	[man startAnimating];
	
	[playerImages release];
	
	isWalkingEnd=YES;

}

-(void)moveAnimationStart{
	
	
	isWalkingEnd=NO;
	countAnimation++;

	NSMutableArray *playerImages;
	UIImage *image1, *image2;
	
	switch (shift) {
		case up:
			
			if(object!=nil)
			{
				man.image=[UIImage imageNamed:@"objectUp.png"];
				image1=[UIImage imageNamed:@"objectUp.png"];
				image2=[UIImage imageNamed:@"objectUp1.png"];
			}
			else
			{
				image1=[UIImage imageNamed:@"walkUp.png"];
				image2=[UIImage imageNamed:@"walkUp1.png"];
				
			}
/*			 
			image1=[UIImage imageNamed:@"up1.png"];
			image2=[UIImage imageNamed:@"up2.png"];
			image3=[UIImage imageNamed:@"up3.png"];
			image4=[UIImage imageNamed:@"up4.png"];
 */
			break;
			
		case down:
		
			if(object!=nil)
			{
				man.image=[UIImage imageNamed:@"objectDown.png"];
				image1=[UIImage imageNamed:@"objectDown.png"];
				image2=[UIImage imageNamed:@"objectDown1.png"];				
			}
			else
			{
				image1=[UIImage imageNamed:@"walkDown.png"];
				image2=[UIImage imageNamed:@"walkDown1.png"];
			}
			/*
			image1=[UIImage imageNamed:@"down1.png"];
			image2=[UIImage imageNamed:@"down2.png"];
			image3=[UIImage imageNamed:@"down3.png"];
			image4=[UIImage imageNamed:@"down4.png"];
			 */
			break;
			
		case left:
			
			if(object!=nil)
			{
				man.image=[UIImage imageNamed:@"objectLeft.png"];
				image1=[UIImage imageNamed:@"objectLeft.png"];
				image2=[UIImage imageNamed:@"objectLeft1.png"];
			}
			else
			{
				image1=[UIImage imageNamed:@"walkLeft.png"];
				image2=[UIImage imageNamed:@"walkLeft1.png"];

				
			}
			/*
			image1=[UIImage imageNamed:@"left1.png"];
			image2=[UIImage imageNamed:@"left2.png"];
			image3=[UIImage imageNamed:@"left3.png"];
			image4=[UIImage imageNamed:@"left4.png"];
			*/
			
			break;
			
		case right:
			
			if(object!=nil)
			{
				man.image=[UIImage imageNamed:@"objectRight.png"];
				image1=[UIImage imageNamed:@"objectRight.png"];
				image2=[UIImage imageNamed:@"objectRight1.png"];
			}
			else
			{
				image1=[UIImage imageNamed:@"walkRight.png"];
				image2=[UIImage imageNamed:@"walkRight1.png"];
			}
			/*
			image1=[UIImage imageNamed:@"right1.png"];
			image2=[UIImage imageNamed:@"right2.png"];
			image3=[UIImage imageNamed:@"right3.png"];
			image4=[UIImage imageNamed:@"right4.png"];
			 */
			break;
			
		default:
			break;
	}

	playerImages=[[NSMutableArray alloc]init];

	[playerImages addObject:image1];
	[playerImages addObject:image2];
	
	man.animationImages=playerImages;
	man.animationDuration = animationTime;
	man.animationRepeatCount = 0;
	
	[man startAnimating];
	[playerImages release];
}

-(void)moveAnimationStop{

	isWalkingEnd=YES;
	countAnimation--;
	[man stopAnimating];
	
	if(countAnimation==0)
	{
		switch (shift) {
			case up:
				man.image=[UIImage imageNamed:@"player.png"];
				break;
			case down:
				man.image=[UIImage imageNamed:@"playerdown.png"];
				break;
			case right:
				man.image=[UIImage imageNamed:@"playerright.png"];
				break;
			case left:
				man.image=[UIImage imageNamed:@"playerleft.png"];
				break;
				
			default:
				break;
		}
	}
	
}

-(void)doMove{
	
	
	CGFloat xMan=0,yMan=0, yObject=0,xObject=0;
	
	switch (shift) {
		case up:
			xMan = man.frame.origin.x;
			yMan = man.frame.origin.y-man.frame.size.height;
			
			if(object!=nil)
			{
				
				xObject = object.frame.origin.x;
				yObject = object.frame.origin.y-object.frame.size.height;
				
			}	
			
			break;
			
			
		case down:
			
			xMan = man.frame.origin.x;
			yMan = man.frame.origin.y+man.frame.size.height;
			
			if(object!=nil)
			{
				xObject = object.frame.origin.x;
				yObject = object.frame.origin.y+object.frame.size.height;
				
			}	
			
			
			break;
			
		case left:
			
			xMan = man.frame.origin.x-man.frame.size.width;
			yMan = man.frame.origin.y;
			
			if(object!=nil)
			{
				xObject = object.frame.origin.x-object.frame.size.width;
				yObject = object.frame.origin.y;
			}	
			
			break;
			
		case right:
			
			xMan = man.frame.origin.x+man.frame.size.width;
			yMan = man.frame.origin.y;
			
			if(object!=nil)
			{
				xObject = object.frame.origin.x+object.frame.size.width;
				yObject = object.frame.origin.y;
			}	
			
			break;
			
			
		default:
			break;
	}
	
	[UIView beginAnimations:@"View Flip" context:nil];
	[UIView setAnimationDuration:animationTime];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	
	[UIView setAnimationDelegate:self];
	[UIView setAnimationWillStartSelector:@selector(moveAnimationStart)];
	[UIView setAnimationDidStopSelector:@selector(moveAnimationStop)];		
	
	man.frame=CGRectMake(xMan, yMan , man.frame.size.width, man.frame.size.height);
	
	if(object!=nil)
	{
		object.frame=CGRectMake(xObject, yObject, object.frame.size.width, object.frame.size.height);
		
		
	}
	
	[UIView commitAnimations];
	
	
}

-(MovementOfObject*)initWithMan:(UIImageView*)manK andObject:(UIImageView*)objectK{

	man = manK;
	object = objectK;
	countAnimation=0;
	
	return self;
}


@end
