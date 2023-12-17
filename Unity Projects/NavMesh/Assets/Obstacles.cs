using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Obstacles : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        StartCoroutine(Move());
    }
    private IEnumerator Move()
    {
        while (true)
        {
            var pos = transform.position;
            if (pos.y > 10f)
            {
                transform.position = new Vector3(pos.x, 1f, pos.z);
            }
            else
            {
                transform.position = new Vector3(pos.x, 15f, pos.z);
            }
            yield return new WaitForSeconds(Random.Range(1f, 10f));
        }
    }
}
