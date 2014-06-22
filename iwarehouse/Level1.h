//
//  Level1.h
//  iwarehouse
//
//  Created by Faisal Rahman on 3/17/11.
//  Copyright 2011 BUET. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"

@interface Level1 : UIViewController {

	IBOutlet MenuViewController *menu;
	IBOutlet UIView *levelCompletionView;
	IBOutlet UIImageView *glowTiles;
	IBOutlet UIImageView *backgroundImage;
	
	
	IBOutlet UIButton *undoButton;
	
	UIImageView *player;
	NSMutableArray *myObjectArray;
	NSArray *boundaryArray;
	NSArray *winArray;
	
	int currentLevel;
	
	NSMutableArray *undoMoveArray;
	
	
	UIImageView *shadowImage;
	
	BOOL touchedPlayer;
	NSTimer *refreshTimer;
	BOOL won;
}

@property(retain,nonatomic)UIImageView *player;
@property(retain,nonatomic)UIImageView *backgroundImage;
@property(retain,nonatomic)MenuViewController *menu;
@property(retain,nonatomic)UIImageView *glowTiles;
@property(retain,nonatomic)UIView *levelCompletionView;


@property(retain,nonatomic)UIButton *undoButton;

-(void)levelInit:(int)levelK;

-(IBAction)btnUP;
-(IBAction)btnDown;
-(IBAction)btnLeft;
-(IBAction)btnRight;

-(IBAction)undoMove;

-(IBAction)nextLevelButtonPressed;

-(IBAction)menuButtonClick;
-(IBAction)MenuExitButtonPressed;
-(IBAction)GoToLevelSelectPage;
-(IBAction)ResetButtonPressed;

@end
