//referance : https://gist.github.com/mstevenson/5103365

using UnityEngine;
using System.Collections;

public class FPS : MonoBehaviour
{
    private float count;
    private float totalFPS;
    private int FPScount = 0;
    private int time = 0;
    
    private IEnumerator Start()
    {
        GUI.depth = 2;
        while (true)
        {
            count = 1f / Time.unscaledDeltaTime;
            totalFPS += count;
            FPScount++;
            if(FPScount%10 == 0)
            {
                time++;
                Debug.Log("Average FPS: " + (totalFPS / FPScount) + " time: " + time);
                totalFPS = 0;
                FPScount = 0;
            }
            yield return new WaitForSeconds(0.1f);
        }
    }
    
    private void OnGUI()
    {
        GUI.Label(new Rect(5, 40, 100, 25), "FPS: " + Mathf.Round(count), new GUIStyle() { fontSize = 50, fontStyle = FontStyle.Bold, normal = new GUIStyleState() { textColor = Color.black } });
    }
}