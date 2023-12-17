using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;
using UnityStandardAssets.Characters.ThirdPerson;

public class PlayerController : MonoBehaviour
{
    public Camera cam;
    public NavMeshAgent navMeshAgent;
    public ThirdPersonCharacter character;
    

    private void Start()
    {
        navMeshAgent.updateRotation = false;
        cam = Camera.main;
    }

    void Update()
    {
        if (Input.GetMouseButtonDown(0))
        {
            Ray ray = cam.ScreenPointToRay(Input.mousePosition);
            RaycastHit hit;
            if (Physics.Raycast(ray, out hit, Mathf.Infinity))
            {
                // navMeshAgent.SetDestination(hit.point);
                navMeshAgent.destination = hit.point;
            }
            else
            {
                Debug.Log("Did not Hit");
            }
            
        }
        if (navMeshAgent.remainingDistance > navMeshAgent.stoppingDistance)
        {
            character?.Move(navMeshAgent.desiredVelocity, false, false);
        }
        else
        {
            character?.Move(Vector3.zero, false, false);
        }
    }
}
