using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InstantiatePlayer : MonoBehaviour
{
    public GameObject playerPrefab;
    public int playerCount;
    public Transform playerParent;
    // Start is called before the first frame update
    void Start()
    {
        for (int p = 0; p < playerCount; p++)
        {
            Instantiate(playerPrefab, new Vector3(transform.position.x,0,transform.position.z), Quaternion.identity, playerParent);
        }
    }

    
}
