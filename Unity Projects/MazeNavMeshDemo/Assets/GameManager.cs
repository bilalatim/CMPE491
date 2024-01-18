using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class GameManager : MonoBehaviour
{
    public static GameManager instance;
    
    private int _chaserCount;
    private int _capturedCount;
    private int _capturedChaserCount;
    
    public TextMeshProUGUI chaserCountText;
    public TextMeshProUGUI capturedCountText;
    public TextMeshProUGUI capturedChaserCountText;
    
    private void Awake()
    {
        if (instance == null)
        {
            instance = this;
        }
        else
        {
            DestroyImmediate(this);
        }
    }
    
    public void IncreaseChaserCount()
    {
        _chaserCount++;
        chaserCountText.text = _chaserCount.ToString();
    }
    
    public void IncreaseCapturedCount()
    {
        _capturedCount++;
        capturedCountText.text = _capturedCount.ToString();
    }
    
    public void DecreaseCapturedCount()
    {
        _capturedCount--;
        _capturedChaserCount++;
        capturedCountText.text = _capturedCount.ToString();
        capturedChaserCountText.text = _capturedChaserCount.ToString();
    }
}
