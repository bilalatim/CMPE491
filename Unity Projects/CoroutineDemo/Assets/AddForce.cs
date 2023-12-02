using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AddForce : MonoBehaviour
{
    private void Start()
    {
        StartCoroutine(AddForceWithDelay());
    }
    
    private IEnumerator AddForceWithDelay()
    {
        while (true)
        {
            var randomDirection = new Vector3(Random.Range(-100, 100), Random.Range(0, 20), Random.Range(-100, 100));
            GetComponent<Rigidbody>().AddForce(randomDirection , ForceMode.Impulse);
            yield return new WaitForSeconds(1f);
        }
    }
}
