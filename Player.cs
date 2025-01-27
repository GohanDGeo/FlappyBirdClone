using Godot;
using System;

public partial class Player : CharacterBody2D
{
	[Export]
	public float gravity = 500.0f; // Gravity
	
	[Export]
	public float jump = 1000.0f; // Player Speed
	
	[Export]
	public float jumpBoost = 20.0f; // Boost when button is pressed
	
	private const float MAX_VELOCITY = 800.0f;
	
	private bool wasPressed = false;
	
	public Vector2 ScreenSize;
	// Called when the node enters the scene tree for the Sfirst time.
	public override void _Ready()
	{
		ScreenSize = GetViewportRect().Size;
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		
	}
	// 	public override void _PhysicsProcess(double delta)
	public void flap(double delta)
	{
		var velocity = Velocity;
		
		velocity.Y += (float)delta * gravity;
		velocity.Y = Math.Min(velocity.Y, MAX_VELOCITY);
		
		if (Input.IsActionPressed("ui_accept"))
		{
			// Make velocity zero (nullify gravity when player presses jump)
			velocity.Y = Math.Min(0, velocity.Y);

			// Flap and go up with each press
			if (!wasPressed)
			{
				var position = new Vector2(x: 0, y: -jumpBoost);
				Position += position;
			}	
			
			// Update vertical velocity
			velocity.Y -= (float)delta * jump;
			velocity.Y = Math.Max(velocity.Y, -MAX_VELOCITY);
			
			// Check that button was pressed
			wasPressed = true;
		}
		else if (wasPressed) // If button is no longer pressed, zero velocity
		{
			velocity.Y = Math.Max(0, velocity.Y);
			wasPressed = false;
		}
		
		// Update velocity
		Velocity = velocity;
		
		MoveAndCollide(velocity*(float)delta);
		
		// Keep player in-bounds
		Position = new Vector2(
			x: Mathf.Clamp(Position.X, 0, ScreenSize.X),
			y: Mathf.Clamp(Position.Y, 0, ScreenSize.Y)
		);
	}
}
