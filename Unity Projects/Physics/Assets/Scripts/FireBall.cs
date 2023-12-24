using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FireBall : MonoBehaviour
{

    float forceMagnitude;
    GameObject objectToInstantiate;
    GameObject newObject1;
    GameObject newObject2;

    void Start()
    {
        forceMagnitude = Random.Range(50.0f, 100.0f);
        objectToInstantiate = Resources.Load<GameObject>("Ball");

        if (objectToInstantiate != null)
        {
            newObject1= Instantiate(objectToInstantiate, transform.position, Quaternion.identity);
            newObject2 = Instantiate(objectToInstantiate, transform.position, Quaternion.identity);
            newObject1.SetActive(false);
            newObject2.SetActive(false);
            StartCoroutine(FireNewBall());
        }
        else
        {
            Debug.LogError("Prefab yüklenemedi! Lütfen doğru dosya yolu belirttiğinizden emin olun.");
        }
    }
    bool isObject1 = true;
    IEnumerator FirePooledBall()
    {
        while (true)
        {
            if (isObject1)
            {
                newObject1.SetActive(false);
                newObject1.transform.position = transform.position;
                newObject1.SetActive(true);
                Rigidbody rb = newObject1.GetComponent<Rigidbody>();
                if (rb != null)
                {
                    Vector3 forceDirection = transform.rotation.y == 0 ? new Vector3(-1.0f, Random.Range(0, 0.3f), Random.Range(-0.3f, 0.3f)) : new Vector3(1.0f, Random.Range(0, 0.3f), Random.Range(-0.3f, 0.3f));
                    rb.AddForce(forceDirection * forceMagnitude, ForceMode.Impulse);
                }
                isObject1 = false;
            }
            else
            {
                newObject2.SetActive(false);
                newObject2.transform.position = transform.position;
                newObject2.SetActive(true);
                Rigidbody rb = newObject2.GetComponent<Rigidbody>();
                if (rb != null)
                {
                    Vector3 forceDirection = transform.rotation.y == 0 ? new Vector3(-1.0f, Random.Range(0, 0.3f), Random.Range(-0.3f, 0.3f)) : new Vector3(1.0f, Random.Range(0, 0.3f), Random.Range(-0.3f, 0.3f));
                    rb.AddForce(forceDirection * forceMagnitude, ForceMode.Impulse);
                }
                isObject1 = true;
            }
            
            yield return new WaitForSeconds(Random.Range(2f, 4f));
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
            yield return new WaitForSeconds(Random.Range(2f, 4f));
        }
    }
}