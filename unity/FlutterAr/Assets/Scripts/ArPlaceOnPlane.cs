using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.XR.ARFoundation;

public class ArPlaceOnPlane : MonoBehaviour
{   
    public ARRaycastManager arRaycaster;
    public GameObject placeObject;
    GameObject spawnObject;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {   
        PlaceObjectByTouch();
        // UpdateCenterObject();
    }
    
    private void PlaceObjectCreate(){
        
    }
    private void PlaceObjectByTouch(){
        if(Input.touchCount>0){
            Touch touch = Input.GetTouch(0);
            List<ARRaycastHit> hits = new List<ARRaycastHit>();
            // C#에서는 LIST 위와 같이 만듬. 자바가 [];
            
            if(arRaycaster.Raycast(touch.position,hits,UnityEngine.XR.ARSubsystems.TrackableType.AllTypes)){
                Pose hitPose = hits[0].pose;
                if(!spawnObject){
                    spawnObject = Instantiate(placeObject, hitPose.position, hitPose.rotation);
                // 오브젝트 실사화 함수
                }
                else{
                    spawnObject.transform.position = hitPose.position;
                    spawnObject.transform.rotation = hitPose.rotation;
                }
               
            }
        }
    }

    // private void UpdateCenterObject(){
    //     Vector3 screenCenter = Camera.current.ViewportToScreenPoint(new Vector3(0.5f, 0.5f));
    //     List<ARRaycastHit> hits = new List<ARRaycastHit>();
    //     arRaycaster.Raycast(screenCenter, hits, UnityEngine.XR.ARSubsystems.TrackableType.Planes);

    //     if(hits.Count>0){
    //         Pose placementPose = hits[0].pose;
    //         placeObject.SetActive(true);
    //         placeObject.transform.SetPositionAndRotation(placementPose.position, placementPose.rotation);
    //     }

        // else{
        //     placeObject.SetActive(false);
        // }

    // }

}
