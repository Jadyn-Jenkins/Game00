using Godot;
using System;

public class Enemy : KinematicBody2D : Character
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
    private const float ACCELERATION = 800.0f;

    // Variables
    private Vector2
}

