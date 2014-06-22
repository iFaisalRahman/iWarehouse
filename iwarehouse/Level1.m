//
//  Level1.m
//  iwarehouse
//
//  Created by Faisal Rahman on 3/17/11.
//  Copyright 2011 BUET. All rights reserved.
//

#import "Level1.h"
#import "MovementOfObject.h"
#import "CheckObstacle.h"
#import "MenuViewController.h"

#define Tottal_Level 30
extern enum direction {
    up   = 0,
    down = 1,
    left = 2,
    right= 3,
}shift;


//////

enum direction lastMoveDirection=up;
UIImageView *lastObjectMoved;

/////


@implementation Level1
@synthesize glowTiles, menu, player,backgroundImage, levelCompletionView;
@synthesize undoButton;


-(NSArray*)readDataFromPlist:(NSString*)filename{
	
	NSError *error;
	//Create a list of paths.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
	//Get a path to your documents directory from the list.
	NSString *documentsDirectory = [paths objectAtIndex:0]; //2
	//Create a full file path.
	NSString* str = [[[NSString alloc] initWithFormat:@"%@.plist", filename]autorelease];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:str]; //3
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	//Check if file exists.
	if (![fileManager fileExistsAtPath: path]) //4
	{
		//get a path to your plist created before in bundle directory (by Xcode).
		NSString *bundle = [[NSBundle mainBundle] pathForResource:filename ofType:@"plist"]; //5
		
		
		//Copy this plist to your documents directory.
		[fileManager copyItemAtPath:bundle toPath: path error:&error]; //6
	}
	
	
	
	NSArray *savedStock = [[NSArray alloc] initWithContentsOfFile: path];
	
	NSLog(@"Data From File: %@", savedStock);
	
	return savedStock;
}

-(void)removeImages{

	for(UIView *view in [self.view subviews])
	{
		if( [view class] == NSClassFromString(@"UIImageView") )
		{
			[view removeFromSuperview];
			NSLog(@"%@",[view class]);
		}
	}
	
	[myObjectArray release];
	[boundaryArray release];
	[winArray release];
	[player release];

}

-(void)initView:(int)level{
	
	won=NO;
	
	if(undoMoveArray ==nil)
	{
		undoMoveArray = [[NSMutableArray alloc] init];
	}
	else
	{
		[undoMoveArray release];
		undoMoveArray = [[NSMutableArray alloc] init];
	}

	

	self.view.alpha=0;
	
	//[levelCompletionView removeFromSuperview];
	
	
	myObjectArray = [[NSMutableArray alloc] init];
	

	
	// Backgrounds
	NSString *bgImageName = [[[NSString alloc] initWithFormat:@"level%d.png",level] autorelease];
	backgroundImage.image = [UIImage imageNamed: bgImageName];
	//[self.view addSubview:backgroundImage];
	[self.view insertSubview:backgroundImage atIndex:0];

	
	
	NSString *levelFileName = [[[NSString alloc] initWithFormat:@"Level%d",level] autorelease];
	NSMutableArray *arr =[[NSMutableArray alloc] initWithArray:[self readDataFromPlist: levelFileName]];

	levelFileName = [[[NSString alloc] initWithFormat:@"BoundaryLevel%d",level] autorelease];
	boundaryArray =[[NSMutableArray alloc] initWithArray:[self readDataFromPlist: levelFileName]];
	
	
	levelFileName = [[[NSString alloc] initWithFormat:@"WinLevel%d",level] autorelease];
	winArray =[[NSMutableArray alloc] initWithArray:[self readDataFromPlist: levelFileName]];

	//undoButton.hidden=YES;
	
	float kX, kY;
	
	
	UIImage *goalPosition1 = [UIImage imageNamed:@"11 copy.png"];
	UIImage *goalPosition2 = [UIImage imageNamed:@"12 copy.png"];
	UIImage *goalPosition3 = [UIImage imageNamed:@"13 copy.png"];
	UIImage *goalPosition4 = [UIImage imageNamed:@"14 copy.png"];
	UIImage *goalPosition5 = [UIImage imageNamed:@"15 copy.png"];
	
	NSArray *goalarr = [[NSArray alloc ] initWithObjects:goalPosition1, goalPosition2, goalPosition3, goalPosition4, goalPosition5,nil];
	
	
	for (int i=0; i<[winArray count]; i++)
	{
		
		kX = [[[winArray objectAtIndex:i] objectForKey:@"x"] floatValue];
		kY = [[[winArray objectAtIndex:i] objectForKey:@"y"] floatValue];	
		
		UIImageView *goal = [[[UIImageView alloc] initWithFrame:CGRectMake(kX, kY, 40, 40)] autorelease];
		goal.animationImages=goalarr;
		goal.animationDuration = 1.0;
		goal.animationRepeatCount = 0;
		[self.view addSubview:goal];
		
		[goal startAnimating];	
	}
	
	
	UIImageView *object;

	kX = [[[arr objectAtIndex:0] objectForKey:@"x"] floatValue];
	kY = [[[arr objectAtIndex:0] objectForKey:@"y"] floatValue];
	player = [[UIImageView alloc] initWithFrame:CGRectMake(kX, kY, 40, 40)];
	player.image = [UIImage imageNamed:@"playerright.png"];
	player.contentMode=UIViewContentModeCenter;
	player.userInteractionEnabled=YES;
	[self.view addSubview:player];

	
	
	for (int i=1; i< [ arr count]; i++) 
	{
		kX = [[[arr objectAtIndex:i] objectForKey:@"x"] floatValue];
		kY = [[[arr objectAtIndex:i] objectForKey:@"y"] floatValue];
		
		object = [[UIImageView alloc] initWithFrame:CGRectMake(kX, kY, 40, 40)];
		object.image=[UIImage imageNamed:@"box.png"];
		[self.view addSubview:object];
		[myObjectArray addObject:object];
		[object release];
	}
	
	[arr release];
	self.view.alpha=1;
	
}

-(void)levelInit:(int)levelK{

	currentLevel = levelK;
	//currentLevel = 22;
}

- (void)viewDidLoad{
	
	[self initView:currentLevel];
	
	self.view.userInteractionEnabled=YES;
    [super viewDidLoad];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	UITouch *touch=[[event allTouches]anyObject];
	//CGPoint touchLocation=[touch locationInView:self.view];
	if ([touch view]==player) 
	{
		NSLog(@"Touched Player");
		touchedPlayer=YES;
	}
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	UITouch *touch=[[event allTouches]anyObject];
	CGPoint touchLocation=[touch locationInView:self.view];
	
	if(touchedPlayer)
	{
		if((player.center.x+20)<touchLocation.x && (touchLocation.y<(player.center.y+20) && touchLocation.y>(player.center.y-20))) //right
		{
			NSLog(@"Right");
			//NSLog(@"player : %f  touchLocation : %f %f",player.center.x touchLocation.y,touchLocation.y);
			
			[self btnRight];
		}
		else if((player.center.x-20)>touchLocation.x && (touchLocation.y<(player.center.y+20) && touchLocation.y>(player.center.y-20))) //left
		{
			//NSLog(@"player : %f  touchLocation : %f %f",player.center.x touchLocation.y,touchLocation.y);
			[self btnLeft];
		}
		else if((player.center.y-20)>touchLocation.y && (touchLocation.x<(player.center.x+20) && touchLocation.x>(player.center.x-20))) //up
		{
			NSLog(@"Up");
			//NSLog(@"player : %f  touchLocation : %f %f",player.center.y touchLocation.x,touchLocation.y);
			
			[self btnUP];
		}
		else if((player.center.y+20)<touchLocation.y && (touchLocation.x<(player.center.x+20) && touchLocation.x>(player.center.x-20)))
		{
			NSLog(@"Down");
			[self btnDown];
		}
	}
	//NSLog(@"Touches Moved");
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	NSLog(@"Touch End");
	touchedPlayer=NO;
}


-(BOOL)didWin{
	
	NSString *strX, *strY;
	UIImageView *object;
	int kX, kY, index;
	NSDictionary *dic;
	

	for (int i=0; i< [myObjectArray count]; i++) 
	{
	
		object = [myObjectArray objectAtIndex:i];
		
		kX=object.frame.origin.x;
		kY=object.frame.origin.y;
		
		strX = [[[NSString alloc]  initWithFormat:@"%d",kX   ] autorelease];
		strY = [[[NSString alloc]  initWithFormat:@"%d",kY   ] autorelease];
		
		dic = [[[NSDictionary alloc] initWithObjectsAndKeys: strX,@"x",strY,@"y",nil] autorelease];
		
		
		index = [ winArray indexOfObject:dic];
		
		if(index>=0 && index<[winArray count])
		{
			continue;
		}
		else
		{
			return NO;
		}

		
	}

	return YES;

}

-(BOOL)isBoundary:(UIImageView*)object{

	NSString *strX, *strY;
	
	int kX=object.frame.origin.x,kY=object.frame.origin.y;


	switch (shift) {
		case up:
			kY = kY-40;
			
			break;

		case down:
			kY = kY+40;
			
			break;
		case left:
			kX = kX-40;
			
			break;
		case right:
			kX = kX+40;
			
			break;
			
		default:
			break;
	}
	
	strX = [[[NSString alloc]  initWithFormat:@"%d",kX   ] autorelease];
	strY = [[[NSString alloc]  initWithFormat:@"%d",kY   ] autorelease];

	NSDictionary *dic = [[[NSDictionary alloc] initWithObjectsAndKeys: strX,@"x",strY,@"y",nil] autorelease];
	
	int i = [boundaryArray indexOfObject:dic];

	NSLog(@"%@,%d",dic,i);
	if( i>=0 && i<[boundaryArray count])
	{
	
		return NO;
	}
	else 
	{
		return YES;
	}


}

-(IBAction)undoMove{
	
	if([undoMoveArray count] == 0)
	{
		return;
	}
	
	NSDictionary *dic = (NSDictionary*) [undoMoveArray lastObject];
	
	UIImageView *lastObjectMovedK = (UIImageView*) [ dic objectForKey:@"Object"];
	
	NSString *str =(NSString*)[dic objectForKey:@"DirectionOfMove"] ;

    enum direction lastMoveDirectionK = [str intValue];

	if(lastObjectMovedK == [NSNull alloc])
	{
		lastObjectMovedK = nil;
	}

	
	
	float kX= player.frame.origin.x , kY = player.frame.origin.y;

	
	switch (lastMoveDirectionK) {
		case up:
			player.frame = CGRectMake(kX, kY+40, 40, 40);
			if (lastObjectMovedK!=nil) 
			{
				lastObjectMovedK.frame = CGRectMake(kX, kY, 40, 40);
			}
			break;
		case down:
	
			player.frame = CGRectMake(kX, kY-40, 40, 40);
			if (lastObjectMovedK!=nil) 
			{
				lastObjectMovedK.frame = CGRectMake(kX, kY, 40, 40);
			}
			break;

		case left:
			player.frame = CGRectMake(kX+40, kY, 40, 40);
			if (lastObjectMovedK!=nil) 
			{
				lastObjectMovedK.frame = CGRectMake(kX, kY, 40, 40);
			}
			break;

		case right:
			player.frame = CGRectMake(kX-40, kY, 40, 40);
			if (lastObjectMovedK!=nil) 
			{
				lastObjectMovedK.frame = CGRectMake(kX, kY, 40, 40);
			}
			break;
			
		default:
			break;
	}
	if(lastObjectMovedK!=nil)
	{
		[self changeBoxImage:lastObjectMovedK];
	}
	[undoMoveArray removeLastObject];
	
 
}

-(void)changeBoxImage:(UIImageView*)object{
	
	NSString *strX, *strY;
	int kX, kY, index;
	NSDictionary *dic;
	
	kX=object.frame.origin.x;
	kY=object.frame.origin.y;

	strX = [[[NSString alloc]  initWithFormat:@"%d",kX   ] autorelease];
	strY = [[[NSString alloc]  initWithFormat:@"%d",kY   ] autorelease];
	
	dic = [[[NSDictionary alloc] initWithObjectsAndKeys: strX,@"x",strY,@"y",nil] autorelease];
	
	NSLog(@"%@", dic);
	
	index = [ winArray indexOfObject:dic];
	
	if(index>=0 && index<[winArray count])
	{
		object.image = [ UIImage imageNamed:@"box2.png"];
	}
	else
	{
		object.image = [ UIImage imageNamed:@"box.png"];
	}
	
	
}

-(void)move{


	CheckObstacle *obstacle =[[CheckObstacle alloc]initWithMan:player andObjects:myObjectArray];
	
	int i =[ obstacle objectAheadOfMan];
	
	NSLog(@"%d",i);
	
	UIImageView *object = nil;
	
	int flag=1;
	
	lastObjectMoved = nil;
	
	if(i>=0 && i<[myObjectArray count])// if An Obstacle exit there ahed of a Man
	{
		object = [myObjectArray objectAtIndex:i];
		
		if([obstacle isObstacle:object])
		{
			flag=0;
		}
		else
		{
			if( ![self isBoundary:object] )
			{
			
				flag=1;
				lastObjectMoved=[myObjectArray objectAtIndex:i];
			}
			else {
				flag=0;
			}

		}
		
	}
	else
	{
		if( ![self isBoundary:player] )
		{
			flag=1;
			
		}
		else 
		{
			flag=0;
		}
	}
	
	MovementOfObject *m = [[MovementOfObject alloc] initWithMan:player  andObject: object];
	
	if (flag) 
	{
		[m doMove];
		lastMoveDirection=shift;
		glowTiles.frame = CGRectMake(player.frame.origin.x-25, player.frame.origin.y-25, 90, 90);
		
		undoButton.hidden=NO;
	}
	
	else
	{
		//undoButton.hidden=YES;
	}


	
	[self changeBoxImage:object];
	object=nil;
	[m release];
	[obstacle release];

	if([self didWin])
	{
		//[self showLevelCompletionView];
		if(!won)
		{
			won=YES;
			NSLog(@"Inside did win");
			refreshTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(loadComplete) userInfo:nil repeats:NO];
		}
		//TopUnlockedLevel++;
	}

	
	
///////////////////////////////
	if (flag) 
	{
		if(lastObjectMoved == nil)
		{
			lastObjectMoved = [NSNull alloc];
		}
		
		NSString *str = [[[NSString alloc] initWithFormat:@"%d",shift] autorelease];
		NSLog(@"%@", str);
		
		NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:str,@"DirectionOfMove",lastObjectMoved,@"Object",nil];
		
		[undoMoveArray addObject: dic];
		[dic release];
	}
///////////////////////////////
}

-(void)loadComplete{
	NSLog(@"Print");
	//[refreshTimer invalidate];
	
	//refreshTimer = [NSTimer scheduledTimerWithTimeInterval:200000.0 target:self selector:@selector(loadComplete) userInfo:nil repeats:NO];
	[self showLevelCompletionView];
	
}


-(IBAction)btnUP{

	shift = up;

	[self move];
	
}

-(IBAction)btnDown{
	shift = down;
	
	[self move];
}

-(IBAction)btnLeft{
	shift = left;
	
	[self move];
}

-(IBAction)btnRight{

	shift = right;
	
	[self move];
}


-(void)showLevelCompletionView{

	
	//self.view.userInteractionEnabled=NO;
	[self.view addSubview:levelCompletionView];
}
-(IBAction)nextLevelButtonPressed{

	[levelCompletionView removeFromSuperview];
	if(currentLevel < Tottal_Level)
	{
		[self removeImages];
		currentLevel++;
		[self initView: currentLevel];
	}
	else
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Level Finished" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}

}

-(IBAction)menuButtonClick{
	
	[menu removeFromSuperview];
	
	shadowImage = [[[UIImageView alloc] initWithImage: [UIImage imageNamed:@"shadow.png"] ] autorelease];
	[self.view addSubview:shadowImage];
	shadowImage.alpha=0;
	
	[self.view addSubview:menu];
	
	menu.frame = CGRectMake(-480, 0, 480, 320);
	[UIView beginAnimations:@"View Flip" context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	UIViewAnimationTransition transition;
	transition = UIViewAnimationTransitionFlipFromLeft;
	menu.frame = CGRectMake(0, 0, 480, 320);
	shadowImage.alpha=1;
	[UIView commitAnimations];
	
	
}

-(IBAction)MenuExitButtonPressed{

	
	[shadowImage removeFromSuperview];
	menu.frame = CGRectMake(0, 0, 480, 320);
	
	[UIView beginAnimations:@"View Flip" context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	UIViewAnimationTransition transition;
	transition = UIViewAnimationTransitionFlipFromLeft;
	menu.frame = CGRectMake(-480, 0, 480, 320);	
	[UIView commitAnimations];
 

	
	
}

-(IBAction)GoToLevelSelectPage{

	[self dismissModalViewControllerAnimated:NO];
}

-(IBAction)ResetButtonPressed{

	[shadowImage removeFromSuperview];
	menu.frame = CGRectMake(0, 0, 480, 320);
	[levelCompletionView removeFromSuperview];
	[UIView beginAnimations:@"View Flip" context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	UIViewAnimationTransition transition;
	transition = UIViewAnimationTransitionFlipFromLeft;
	menu.frame = CGRectMake(-480, 0, 480, 320);	
	[UIView commitAnimations];
	
	[self removeImages];
	[self initView: currentLevel];
	
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	
	if (interfaceOrientation == UIInterfaceOrientationLandscapeRight)
	{
		return YES;
	}
	else
	{
		return NO;
	}
	
	
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	
	NSLog(@"dealloc Level Page");
    [super dealloc];
}


@end
