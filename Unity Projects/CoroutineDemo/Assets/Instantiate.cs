using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Instantiate : MonoBehaviour
{
    public int numberOfCubes;
    public float delay;
    public GameObject cube;
    public GameObject cubeParent;
    public bool useDelay = false;

    void Start()
    {
        if (useDelay)
        {
            StartCoroutine(InstantiateObjectsWithDelay());
        }
        else
        {
            InstantiateObjects();
        }
    }

    private IEnumerator InstantiateObjectsWithDelay()
    {
        for (int i = 0; i < numberOfCubes; i++)
        {
            var cubeClone = Instantiate(cube, Vector3.zero, Quaternion.identity, cubeParent.transform);
            cubeClone.name = "Cube " + i;
            yield return new WaitForSeconds(delay);
        }
    }
    
    private void InstantiateObjects()
    {
        for (int i = 0; i < numberOfCubes; i++)
        {
            var cubeClone = Instantiate(cube, Vector3.zero, Quaternion.identity, cubeParent.transform);
            cubeClone.name = "Cube " + i;
        }
    }
}
