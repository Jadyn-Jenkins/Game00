using Godot;
using System;

public class Player : KinematicBody2D : Character
{
    // Properties
    public string Name { get; set; }
    public int Health { get; set; }
    public int MaxHealth { get; set; }
    public int Damage { get; set; }
    public float Speed { get; set; }

    // Constants
    private const float GRAVITY = 2000.0f;
    private const float MAX_SPEED = 400.0f;
    private const float JUMP_FORCE = -800.0f;
    private const float ACCELERATION = 800.0f;

    // Variables
    private Vector2 _velocity = new Vector2();
    private bool _isJumping = false;

    public override void _PhysicsProcess(float delta)
    {
        // Apply gravity
        _velocity.y += GRAVITY * delta;
        _velocity.y = Mathf.Clamp(_velocity.y, -MAX_SPEED, MAX_SPEED);

        // Handle movement
        if (Input.IsActionPressed("ui_right"))
        {
            _velocity.x = Mathf.Lerp(_velocity.x, MAX_SPEED, ACCELERATION * delta);
        }
        else if (Input.IsActionPressed("ui_left"))
        {
            _velocity.x = Mathf.Lerp(_velocity.x, -MAX_SPEED, ACCELERATION * delta);
        }
        else
        {
            _velocity.x = Mathf.Lerp(_velocity.x, 0, ACCELERATION * delta);
        }

        // Handle jumping
        if (IsOnFloor())
        {
            _isJumping = false;
            if (Input.IsActionJustPressed("ui_up"))
            {
                _velocity.y = JUMP_FORCE;
                _isJumping = true;
            }
        }

        // Move the player
        _velocity = MoveAndSlide(_velocity, new Vector2(0, -1));

        // Attack logic
        if (Input.IsActionPressed("attack"))
        {
            Character.Attack(this);
        }
    }
}