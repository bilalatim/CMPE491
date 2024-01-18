using UnityEngine;
using UnityEngine.AI;
using UnityStandardAssets.Characters.ThirdPerson;

public class PlayerController : MonoBehaviour
{
    public NavMeshAgent navMeshAgent;
    public Renderer renderer;
    public bool _isChaser;
    private PlayerController _capturedPlayer;
    private bool _isRoleSet;


    private void Awake()
    {
        GenerateRandomPosition();
    }

    void Update()
    {
        if (_capturedPlayer != null)
        {
            navMeshAgent.SetDestination(_capturedPlayer.transform.position);
        }
        
        if (navMeshAgent.remainingDistance <= navMeshAgent.stoppingDistance)
        {
            if (!_isRoleSet)
            {
                SetRandomAgentRole();
                _isRoleSet = true;
            }
            if (_capturedPlayer != null)
            {
                _capturedPlayer.tag = "Chaser";
                _capturedPlayer.renderer.material.color = Color.red;
                _capturedPlayer._isChaser = true;
                _capturedPlayer = null;
                GameManager.instance.DecreaseCapturedCount();
            }
            GenerateRandomPosition();
            
        }
        RaycastHit hit;
        Physics.Raycast(transform.position, transform.forward, out hit, 7f);
        // Debug.DrawLine(transform.position + Vector3.up, transform.position + Vector3.up + transform.forward * 7f, Color.red);
        if (hit.collider != null && _capturedPlayer == null)
        {
            if (_isChaser && hit.collider.CompareTag("Captured"))
            {
                navMeshAgent.SetDestination(hit.collider.transform.position);
                _capturedPlayer = hit.collider.GetComponent<PlayerController>();
                hit.collider.tag = "Target";
            }
            else if (!_isChaser && hit.collider.CompareTag("Chaser"))
            {
                var randomPosition = transform.position - hit.collider.transform.position + transform.position;
                navMeshAgent.SetDestination(randomPosition);
            }
        }
    }
    
    void GenerateRandomPosition()
    {
        var randomPosition = new Vector3( Random.Range(0f, 120f), 0.5f, Random.Range(0f, 120f));
        navMeshAgent.SetDestination(randomPosition);
    }
    
    public void SetRandomAgentRole()
    {
        if (Random.Range(0, 2) == 0)
        {
            renderer.material.color = Color.red;
            tag = "Chaser";
            _isChaser = true;
            GameManager.instance.IncreaseChaserCount();
        }
        else
        {
            tag = "Captured";
            renderer.material.color = Color.red;
            GameManager.instance.IncreaseCapturedCount();
        }
    }
    
    public void SetAgentRole(bool isChaser)
    {
        if (isChaser)
        {
            renderer.material.color = Color.red;
            tag = "Chaser";
            _isChaser = true;
            GameManager.instance.IncreaseChaserCount();
        }
        else
        {
            tag = "Captured";
            renderer.material.color = Color.red;
            GameManager.instance.IncreaseCapturedCount();
        }
    }
}
