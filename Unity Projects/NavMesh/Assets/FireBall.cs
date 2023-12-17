using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FireBall : MonoBehaviour
{

    float forceMagnitude;
    GameObject objectToInstantiate;

    void Start()
    {
        forceMagnitude = Random.Range(50.0f, 100.0f);
        objectToInstantiate = Resources.Load<GameObject>("Ball");

        if (objectToInstantiate != null)
        {
            StartCoroutine(FireNewBall());
        }
        else
        {
            Debug.LogError("Prefab yüklenemedi! Lütfen doğru dosya yolu belirttiğinizden emin olun.");
        }
    }

    IEnumerator FireNewBall()
    {
        while (true)
        {
            GameObject newObject = Instantiate(objectToInstantiate, transform.position, Quaternion.identity);

            // RigidBody bileşenini al (varsa)
            Rigidbody rb = newObject.GetComponent<Rigidbody>();

            // Eğer RigidBody bileşeni varsa, kuvvet uygula
            if (rb != null)
            {
                Vector3 forceDirection = transform.rotation.y == 0 ? new Vector3(-1.0f, Random.Range(0,0.3f), Random.Range(-0.3f,0.3f)) : new Vector3(1.0f, Random.Range(0,0.3f), Random.Range(-0.3f,0.3f));
                rb.AddForce(forceDirection * forceMagnitude, ForceMode.Impulse);
            }
            yield return new WaitForSeconds(Random.Range(1f, 4f));
        }
    }
}