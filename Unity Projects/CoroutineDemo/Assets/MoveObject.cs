using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Random = UnityEngine.Random;

public class MoveObject : MonoBehaviour
{
    public Vector3 destination;
    public float speed;
    public float time;
    public bool useSpeed = false;
    public bool useRandomDestination = false;

    private void Start()
    {
        if (useRandomDestination)
        {
            FindRandomDestination();
        }
        else
        {
            if (useSpeed)
            {
                StartCoroutine(MoveWithSpeed(destination, speed));
            }
            else
            {
                StartCoroutine(MoveWithTime(destination, time));
            }
        }
    }

    void FindRandomDestination()
    {
        destination = new Vector3(Random.Range(-49, 49), Random.Range(0.5f, 30f), Random.Range(-49, 49));
        if (useSpeed)
        {
            StartCoroutine(MoveWithSpeed(destination, speed));
        }
        else
        {
            StartCoroutine(MoveWithTime(destination, time));
        }
    }

    private IEnumerator MoveWithSpeed(Vector3 destination, float speed)
    {
        while (transform.position != destination)
        {
            transform.position = Vector3.MoveTowards(transform.position, destination, speed * Time.deltaTime);
            yield return null;
        }
        FindRandomDestination();
    }
    
    private IEnumerator MoveWithTime(Vector3 destination, float time)
    {
        float elapsedTime = 0;
        Vector3 startingPos = transform.position;
        while (elapsedTime < time)
        {
            transform.position = Vector3.Lerp(startingPos, destination, (elapsedTime / time));
            elapsedTime += Time.deltaTime;
            yield return null;
        }
        FindRandomDestination();
    }
}
