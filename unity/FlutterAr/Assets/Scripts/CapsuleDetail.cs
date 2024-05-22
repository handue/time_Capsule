using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.XR.ARFoundation;


public class CapsuleDetail : MonoBehaviour
{   
    
    public int cid;
    private ARRaycastManager _arRaycastManager;
    private RaycastHit hitInfo;
    public int getCapsule;

    private ARRaycastManager arRaycastManager;
    public string title;
    // Start is called before the first frame update
    void Start()
    {
       
    }

    // Update is called once per frame
    void Update()
    {   
        
    }   


    public int getCid(){
        return cid;
    }
      public string getTitle(){
        return title;
    }

    //! FIXME: 5월15일, 캡슐 잡고 움직여서 위치 바꾸는거 하려 했는데 지금 단계에선 굳이인듯, 나중에 다 하고 시간 남으면 해보자. 
    public void assignCid(int cid){
        this.cid = cid;
    }
    public void assignTitle(string title){
        this.title = title;
    }
}
