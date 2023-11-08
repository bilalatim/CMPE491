using System;
using UnityEngine;

public class Bird : MonoBehaviour
{
    public float upForce = 200f;
    private bool isDead = false;
    private Rigidbody2D rb;

    void Start()
    {
        rb = GetComponent<Rigidbody2D>();
    }

    void Update()
    {
        if (isDead || !GameController.instance.isGamePlaying) return;

        if (Input.GetMouseButtonDown(0))
        {
            rb.velocity = Vector2.zero;
            rb.AddForce(new Vector2(0, upForce));
        }

        // Rotation of the bird
        // float angle = Mathf.Atan2(rb.velocity.y, 10) * Mathf.Rad2Deg;
        // transform.rotation = Quaternion.Euler(0, 0, angle);
    }

    void OnCollisionEnter2D(Collision2D other)
    {
        if (other.transform.CompareTag("Enemy"))
        {
            isDead = true;
            GameController.instance.LoseGame();
            // GameController.instance.BirdDied();
        }
        
    }

    private void OnTriggerEnter2D(Collider2D other)
    {
        if (other.CompareTag("Score"))
        {
            GameController.instance.BirdScored();
        }
    }
}

