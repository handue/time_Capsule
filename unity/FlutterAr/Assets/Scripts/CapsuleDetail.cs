using System.Collections;
using System.Collections.Generic;
using UnityEditor.DeviceSimulation;
using UnityEngine;

public class CapsuleDetail : MonoBehaviour
{
    private int cid;
    private string title;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void touchCapsule(){
        if(Input.touchCount>0){
            Touch touch = Input.GetTouch(0);
            // todo: 터치 시작됐을 때
            Debug.Log("캡슐 터치 됐음!, cid랑 title:" + cid + title);
        }
    }

    public void assignCid(int cid){
        this.cid = cid;
    }
    public void assignTitle(string title){
        this.title = title;
    }
}
