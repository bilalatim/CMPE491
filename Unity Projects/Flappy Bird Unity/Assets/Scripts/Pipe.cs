using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Pipe : MonoBehaviour
{
    private void Start()
    {
        Destroy(gameObject, 3f);
    }

    void Update()
    {
        transform.Translate(Vector3.left * (Time.deltaTime * 3));
    }
    
    private void OnTriggerEnter2D(Collider2D other)
    {
        if (other.CompareTag("PipeDestroyer"))
        {
            Destroy(gameObject);
        }
    }
    
}
