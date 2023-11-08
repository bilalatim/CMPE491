using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class GameController : MonoBehaviour
{
    public bool isGamePlaying = false;
    public Pipe pipePrefab;
    [SerializeField] private float spawnTime = 1.5f;
    [SerializeField] private Transform spawnPoint;
    [SerializeField] private TMP_Text scoreText;
    [SerializeField] private Button restartButton;
    private int score = 0;
    

    public void StartGame()
    {
        score = 0;
        isGamePlaying = true;
        Time.timeScale = 1;
        StartCoroutine(SpawnPipe());
    }
    
    public void PauseGame()
    {
        isGamePlaying = false;
        Time.timeScale = 0;
        StopCoroutine(SpawnPipe());
    }
    
    public void LoseGame()
    {
        isGamePlaying = false;
        Time.timeScale = 0;
        restartButton.gameObject.SetActive(true);
        StopCoroutine(SpawnPipe());
    }
    
    public void RestartGame()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().name);
    }

    public static GameController instance;
    
    private void Awake()
    {
        instance = this;
        transform.parent = null;
        DontDestroyOnLoad(gameObject);
        PauseGame();
    }
    
    IEnumerator SpawnPipe()
    {
        while (isGamePlaying)
        {
            var spawnPosition = spawnPoint.position;
            spawnPosition.y += Random.Range(-1.0f,2.0f);
            Instantiate(pipePrefab, spawnPosition, Quaternion.identity);
            yield return new WaitForSeconds(spawnTime);
        }
    }
    
    public void BirdScored()
    {
        score++;
        scoreText.text = score.ToString();
    }
}
