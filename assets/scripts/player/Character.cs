using Godot;
using System;

public class Character
{
    // Properties
    public string Name { get; set; }
    public int Health { get; set; }
    public int MaxHealth { get; set; }
    public int Damage { get; set; }
    public float Speed { get; set; }

    // Attacks
    public Action<Player> NormalAttack { get; set; }
    public Action<Player> SpecialAttack { get; set; }
    public Action<Player> GrabAttack { get; set; }

    public void Attack(Player player)
    {
        // Choose which attack to use based on player input and character's moveset
        if (Input.IsActionPressed("normal_attack"))
        {
            NormalAttack?.Invoke(player);
        }
        else if (Input.IsActionPressed("special_attack"))
        {
            SpecialAttack?.Invoke(player);
        }
        else if (Input.IsActionPressed("grab_attack"))
        {
            GrabAttack?.Invoke(player);
        }
    }
}


