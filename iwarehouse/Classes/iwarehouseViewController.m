//
//  iwarehouseViewController.m
//  iwarehouse
//
//  Created by Faisal Rahman on 3/17/11.
//  Copyright 2011 BUET. All rights reserved.
//

#import "iwarehouseViewController.h"
#import "MovementOfObject.h";
#import "Level1.h"
#import "LevelSelect.h"

@implementation iwarehouseViewController



-(IBAction)playButtonPressed{
/*
	Level1 *level = [[Level1 alloc] initWithNibName:@"Level1" bundle:nil];
	
	[self presentModalViewController:level animated:NO];
 */
	
	LevelSelect *levelSelectPage = [[LevelSelect alloc] initWithNibName:@"LevelSelect" bundle:nil];
	[self presentModalViewController:levelSelectPage animated:NO];

		
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	 [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{

	
}


// Override to allow orientations other than the default portrait orientation.

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
	if (interfaceOrientation == UIInterfaceOrientationLandscapeRight)
	{
		return YES;
	}
	else {
		return NO;
	}


}

 
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
